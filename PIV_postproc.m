function filtdata=PIV_postproc(file,IMAGES,data)
%% PIV post-processing Loop
amount = size(IMAGES,3);
[~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,umin,umax,vmin,vmax,stdthresh,epsilon,thresh]=data_summary_PIV(file);
if mod(amount,2) == 1 %Uneven number of images?
    IMAGES(:,:,amount)=[];  %remove last image from list
    amount=amount-1;
end
u_filt=cell(amount*0.5,1);
v_filt=u_filt;
typevector_filt=u_filt;
for j=1:amount-1
    u_filtered=data(j).u;
    v_filtered=data(j).v;
    typevector_filtered=data(j).typevec;
    %vellimit check
    if isempty(umin)==0;
        u_filtered(u_filtered<umin)=NaN;
        u_filtered(u_filtered>umax)=NaN;
        v_filtered(v_filtered<vmin)=NaN;
        v_filtered(v_filtered>vmax)=NaN;
    end
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
        if c==1; 
            velcomp=u_filtered;
        else
            velcomp=v_filtered;
        end %#ok<*NOSEM>
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
    typevector_filtered(data(j).typevec==0)=0; %restores typevector for mask
    
    %Interpolate missing data
    u_filtered=inpaint_nans(u_filtered,4);
    v_filtered=inpaint_nans(v_filtered,4);
    
%     u_filt{j,1}=u_filtered;
%     v_filt{j,1}=v_filtered;
%     typevector_filt{j,1}=typevector_filtered;
% 	data(j).x=x{j,1};data(j).y=y{j,1};
%     data(j).u=u{j,1};data(j).v=v{j,1};
    filtdata(j).x=data(j).x;
    filtdata(j).y=data(j).y;
    filtdata(j).u=u_filtered;
    filtdata(j).v=v_filtered;
    filtdata(j).typevecfilt=typevector_filtered;
end
