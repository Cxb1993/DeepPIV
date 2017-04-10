function data=PIV_analysis(IMAGES,file)
global filestub
[s,p]=PIV_settings(filestub);
amount = size(IMAGES,3);
skip=1;
%% PIV pre-analysis loop
% if mod(amount,2) == 1 %Uneven number of images?
%     IMAGES(:,:,amount)=[];  %remove last image from list
%     amount=amount-1;
% end
% x=cell(amount/2,1);
x=cell(1,1);
y=x;
u=x;
v=x;
typevector=x; %typevector will be 1 for regular vectors, 0 for masked areas
counter=0;

%% PIV analysis loop:
for i=1:1:amount-skip
    counter=counter+1;
    image1=IMAGES(:,:,i); % read images
    image2=IMAGES(:,:,i+skip);
    image1 = PIVlab_preproc(image1,p{1,2},p{2,2},p{3,2},p{4,2},p{5,2},p{6,2},p{7,2},p{8,2}); %preprocess images
    image2 = PIVlab_preproc(image2,p{1,2},p{2,2},p{3,2},p{4,2},p{5,2},p{6,2},p{7,2},p{8,2});
% 	s{4,2}=mask;         % If needed, generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    [x{counter},y{counter},u{counter},v{counter},typevector{counter}] = piv_FFTmulti(image1,image2,s{1,2},s{2,2},s{3,2},s{4,2},s{5,2},s{6,2},s{7,2},s{8,2},s{9,2},s{10,2});
    disp([int2str((i+1)/amount*100) ' % PIV processing completed']);
    data(i).x=x{counter};
    data(i).y=y{counter};
    data(i).u=u{counter};
    data(i).v=v{counter};
    data(i).typevec=typevector{counter};
%     % Graphical output (disable to improve speed)
%     imagesc(double(image1)+double(image2));colormap('gray');
%     hold on
%     quiver(x{counter},y{counter},u{counter},v{counter},'g','AutoScaleFactor', 1.5);
%     hold off;
%     axis image;
%     set(gca,'xtick',[],'ytick',[])
%     drawnow;
end