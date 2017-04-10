addpath(genpath('/Users/kakani/Documents/MATLAB/PIVlab 1/'))
clc; clear; close all

file='150601_SC1ATK25_vortexgen_3';
inc=1;
[dir,start,finish,calib]=data_summary(file);

video_file=[dir,file,'.mov'];
vidObj=VideoReader(video_file);
vidHeight=vidObj.Height;
vidWidth=vidObj.Width;
fps=vidObj.FrameRate;
tstart=start/fps;
tfinish=finish/fps;

mov=struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
%% compiling sampling of images into a single matrix
vidObj.CurrentTime = tstart;   %start time on clip
k = 1;
while vidObj.CurrentTime <= tfinish
    mov(k).cdata = readFrame(vidObj);
    k = k+1;
end
% hf=figure;
% set(hf,'Position',[0,0,vidWidth,vidHeight]);
% movie(hf,mov,1,vidObj.FrameRate);

% IMAGES(1:vidHeight,1:vidWidth,1:size(mov,2))=0;
for i=1:1:size(mov,2)
    im=mov(i).cdata;
    imnew=rgb2gray(im);
%     imnew=imsubtract(imnew,mean(mean(imnew)));
    IMAGES(:,:,i)=imnew;
%     imshow(IMAGES(:,:,i))
%     pause(0.1)
end

[s,p]=piv_settings(file);
amount = size(mov,2);

%% PIV pre-analysis loop
if mod(amount,2) == 1 %Uneven number of images?
    IMAGES(:,:,amount)=[];  %remove last image from list
    amount=amount-1;
end
x=cell(amount/2,1);
y=x;
u=x;
v=x;
typevector=x; %typevector will be 1 for regular vectors, 0 for masked areas
counter=0;

%% PIV analysis loop:
for i=1:1:amount-inc
    counter=counter+1;
    image1=IMAGES(:,:,i); % read images
    image2=IMAGES(:,:,i+inc);
    image1 = PIVlab_preproc(image1,p{1,2},p{2,2},p{3,2},p{4,2},p{5,2},p{6,2},p{7,2},p{8,2}); %preprocess images
    image2 = PIVlab_preproc(image2,p{1,2},p{2,2},p{3,2},p{4,2},p{5,2},p{6,2},p{7,2},p{8,2});
% 	s{4,2}=mask;         % If needed, generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    [x{counter} y{counter} u{counter} v{counter} typevector{counter}] = piv_FFTmulti(image1,image2,s{1,2},s{2,2},s{3,2},s{4,2},s{5,2},s{6,2},s{7,2},s{8,2},s{9,2},s{10,2});
    disp([int2str((i+1)/amount*100) ' % PIV processing completed']);
    
%     % Graphical output (disable to improve speed)
%     imagesc(double(image1)+double(image2));colormap('gray');
%     hold on
%     quiver(x{counter},y{counter},u{counter},v{counter},'g','AutoScaleFactor', 1.5);
%     hold off;
%     axis image;
%     set(gca,'xtick',[],'ytick',[])
%     drawnow;
end

%% PIV post-processing Loop
[~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,umin,umax,vmin,vmax,stdthresh,epsilon,thresh]=data_summary_PIV(file);
u_filt=cell(amount/2,1);
v_filt=u_filt;
typevector_filt=u_filt;
for j=1:size(x,1)
    u_filtered=u{j,1};
    v_filtered=v{j,1};
    typevector_filtered=typevector{j,1};
    %vellimit check
    u_filtered(u_filtered<umin)=NaN;
    u_filtered(u_filtered>umax)=NaN;
    v_filtered(v_filtered<vmin)=NaN;
    v_filtered(v_filtered>vmax)=NaN;
    % stddev check
    meanu=nanmean(nanmean(u_filtered));
    meanv=nanmean(nanmean(v_filtered));
    std2u=nanstd(reshape(u_filtered,size(u_filtered,1)*size(u_filtered,2),1));
    std2v=nanstd(reshape(v_filtered,size(v_filtered,1)*size(v_filtered,2),1));
    minvalu=meanu-stdthresh*std2u;
    maxvalu=meanu+stdthresh*std2u;
    minvalv=meanv-stdthresh*std2v;
    maxvalv=meanv+stdthresh*std2v;
    u_filtered(u_filtered<minvalu)=NaN;
    u_filtered(u_filtered>maxvalu)=NaN;
    v_filtered(v_filtered<minvalv)=NaN;
    v_filtered(v_filtered>maxvalv)=NaN;
    % normalized median check
    %Westerweel & Scarano (2005): Universal Outlier detection for PIV data
    [J,I]=size(u_filtered);
    medianres=zeros(J,I);
    normfluct=zeros(J,I,2);
    b=1;
    for c=1:2
        if c==1; velcomp=u_filtered;else;velcomp=v_filtered;end %#ok<*NOSEM>
        for i=1+b:I-b
            for k=1+b:J-b
                neigh=velcomp(k-b:k+b,i-b:i+b);
                neighcol=neigh(:);
                neighcol2=[neighcol(1:(2*b+1)*b+b);neighcol((2*b+1)*b+b+2:end)];
                med=median(neighcol2);
                fluct=velcomp(k,i)-med;
                res=neighcol2-med;
                medianres=median(abs(res));
                normfluct(k,i,c)=abs(fluct/(medianres+epsilon));
            end
        end
    end
    info1=(sqrt(normfluct(:,:,1).^2+normfluct(:,:,2).^2)>thresh);
    u_filtered(info1==1)=NaN;
    v_filtered(info1==1)=NaN;

    typevector_filtered(isnan(u_filtered))=2;
    typevector_filtered(isnan(v_filtered))=2;
    typevector_filtered(typevector{j,1}==0)=0; %restores typevector for mask
    
    %Interpolate missing data
    u_filtered=inpaint_nans(u_filtered,4);
    v_filtered=inpaint_nans(v_filtered,4);
    
%     u_filt{j,1}=u_filtered;
%     v_filt{j,1}=v_filtered;
%     typevector_filt{j,1}=typevector_filtered;
	data(j).x=x{j,1};data(j).y=y{j,1};
    data(j).u=u{j,1};data(j).v=v{j,1};
    data(j).uf=u_filtered;data(j).vf=v_filtered;
%     data(j).typevec=typevector_filtered;
end
outfile=[dir file '_veldata.mat'];
save(outfile,'data')
