clc; clear; close all; warning('off');tic
%this code requires an IMAGE stack. use DeepPIV_MakeIMAGE.m prior to using this code.
% function DeepPIV_MeasureStreakLength(dataset)

dataset='DEEPPIV_S850_S001_T101';
display(dataset);

val=10;
vel=10; %mm/s %UNKNOWN
percent=0.1; %percent allowable change in imwarp transform
inc=1;
length=3;
calib=1;

%retrieving data set-specific parameters
% [dir,~,~,calib,~,fps]=data_summary(dataset);
dir='/users/kakani/desktop/microplastics/';
start=1;finish=180;fps=60;
indir=[dir,'input/'];
outdir=[dir,'output/'];
% nFrames=finish-start;
if fps==60
    length=2*length;
    inc=2;
end

%% arranging planar cross sections into "volume" matrix
im_file=[indir,dataset,'_IMAGE.mat'];
% im_file=[indir,dataset,num2str(vel),'vel_IMAGE.mat'];
body_file=[indir,dataset,'_MASKbody.mat'];
data_file=[outdir,dataset,'_streakdata.mat'];
load(im_file);                 %if exists, load original image stack

figure(1)
for i=1:1:size(IMAGE,3)-length+1
    im=max(IMAGE(:,:,i),IMAGE(:,:,i+1));
    imshow(im)
    pause(0.2)
end

%%
% IMAGE=IMAGEunwarpsm;
 for i=1:inc:size(IMAGE,3)-length+1
%     imstr=IMAGE(:,:,i);
    imstr=max(IMAGE(:,:,i),IMAGE(:,:,i+1));
    for j=2:1:length-1
        imstr=max(imstr,IMAGE(:,:,i+j));
    end
    imnew=imadjust(imstr,[0,0.3],[0,1]);
    [mask,maxarea,minarea]=imops(dataset,imnew);
    imstrnew=imnew.*uint8(mask);
    figure(2)
    imshowpair(imnew,mask*255)
    pts=ginput(2);
    xpts=pts(1,1):5:pts(2,1);
    m=(pts(2,2)-pts(1,2))/(pts(2,1)-pts(1,1));
    b=pts(1,2)-m*pts(1,1);
    ypts=m*xpts+b;
%     end
    BW=bwlabel(mask,4);
    label=bwconncomp(mask,4);
    s=regionprops(label,'Centroid','Area');
    %%REMOVE areas < 25 from regionprops output
    index=[];
    for k=1:1:size(s,1)
        for j=1:1:size(xpts,2)
            cent=s(k).Centroid;
            area=s(k).Area;
            dist=sqrt((cent(1,1)-xpts(1,j))^2+(cent(1,2)-ypts(1,j))^2);
            if dist<50 && area<maxarea && area>minarea
                index=[index,k];
            end
        end
    end
    index=unique(index);
    im=BW*0;
    for j=1:1:size(index,2)
        if isempty(index)==1
            im=BW*0;
        else
            im=max(im,BW==index(j));
        end
    end
    figure(3)
    imshowpair(imstrnew,im)
    hold on
    plot(xpts,ypts,'r*')
    hold off
    pause(0.5)
    stats=streaklengthwidthdist(im);
    
m=input('Do you need to connect streaks? no [enter], yes [0] ');
    while m==0
        zoom()
        pause()
        str=ginput(2);
        index=[];
        for k=1:1:size(s,1)
            for j=1:1:2
                cent=s(k).Centroid;
                dist=sqrt((cent(1,1)-str(j,1))^2+(cent(1,2)-str(j,2))^2);
                if dist<10
%                         index=[index,k];
                    strpt(j,1:2)=cent;
                end
            end
        end
        %connect the dots using strpt as line endpoints
        slope=(strpt(2,2)-strpt(1,2))/(strpt(2,1)-strpt(1,1));
        b=strpt(1,2)-slope.*strpt(1,1);
        xcon=strpt(1,1):0.1:strpt(2,1);
        ycon=slope*xcon+b;
        for j=1:1:size(xcon,2)
            im(round(ycon(j)),round(xcon(j)))=1;
        end
        imshow(im)
        m=input('Do you need to connect streaks? no [enter], yes [0] ');
        if isempty(m)==1
            stats=streaklengthwidthdist(im);
            m=input('Do you need to connect streaks? no [enter], yes [0] ');
        end
    end

    data{i}.stats=stats;    %data{i}.stats(1).Area
    data{i}.xpts=xpts;
    data{i}.ypts=ypts;
    data{i}.im=im;
    data{i}.imstr=imstrnew;
    clear m
end
save(data_file,'data','-v7.3');

%%
length=[];
for m=1:1:size(data,2)
    if isempty(data{1,m})==0
        for n=1:1:size(data{1,m}.stats,1)
            length=[length,data{1,m}.stats(n).Distance];
            maxlength(m,1)=max(length);
            length=[];
        end
    else
        maxlength(m,1)=0;
    end
end
figure(4)
plot(maxlength(maxlength>0),'*-')
hold on
plot([0,size(maxlength,1)],[mean(maxlength(maxlength>0)),mean(maxlength(maxlength>0))],'k--')
hold off
grid on
display(['maximum streak length for ',num2str(dataset),' = ',num2str(round(max(maxlength))),' pixels'])
display(['mean streak length with cutoff > 10 for ',num2str(dataset),' = ',num2str(mean(maxlength(maxlength>mean(maxlength(maxlength>0))))),' pixels'])
display(['mean streak length with cutoff > mean for ',num2str(dataset),' = ',num2str(mean(maxlength(maxlength>10))),' pixels'])
m=input('Are you finished with this data set? no [enter], yes [0]');
if isempty(m)==1
    blah=1;
else
    return
end
% end