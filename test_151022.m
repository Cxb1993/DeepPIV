clc; clear; close all; warning('off');tic

dataset='150811_SC1ATK50+1_BathoStyg_5_clip';
display(dataset);

val=10;
vel=10; %mm/s %UNKNOWN
percent=0.1; %percent allowable change in imwarp transform
inc=1;

%retrieving data set-specific parameters
% [dir,start,finish,fps,fstop,shutter,calib,red,aspectratio,contrast]=videoinfo(dataset,vel);
dir='/users/kakani/desktop/';
start=1;
finish=89;
viddir=[dir,'clips/'];
indir=[dir,'input/'];
outdir=[dir,'output/'];
nFrames=finish-start;

%% arranging planar cross sections into "volume" matrix
im_file=[indir,dataset,num2str(vel),'vel_IMAGE.mat'];
body_file=[indir,dataset,'_IMAGEbody.mat'];
load(im_file);                 %if exists, load original image stack
load(body_file);

%%
for i=1:1:size(IMAGE,3)-length+1
    im=IMAGE(:,:,i);
    imbody=IMAGEbody(:,:,i);
    imnew=bwareaopen(bwmorph(bwareaopen(imadjust(im,[0,0.3],[0,1])>165,25),'close'),25);
    bodybounds=bwboundaries(imbody);
    bodydata=regionprops(logical(imbody),'Area','Centroid');
    imdata=regionprops(logical(imnew),'Area','Centroid');
    index=[];
    
    figure(1)
    imshow([imnew,mask*255,imstrnew])
    if i==1
        imshow(mask)
        pts=ginput(2);
        xpts=pts(1,1):5:pts(2,1);
        m=(pts(2,2)-pts(1,2))/(pts(2,1)-pts(1,1));
        b=pts(1,2)-m*pts(1,1);
        ypts=m*xpts+b;
    end
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
            if dist<50 && area<1000
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
    
    stats=streaklengthwidthdist(im);
    data{i}.stats=stats;    %data{i}.stats(1).Area
    data{i}.xpts=xpts;
    data{i}.ypts=ypts;
    data{i}.im=im;
    data{i}.imstr=imstrnew;
end