clc; clear; close all; warning('off');tic

dataset='150811_SC1ATK50+1_BathoStyg_5_clip';
display(dataset);

val=10;
vel=10; %mm/s %UNKNOWN
percent=0.2; %percent allowable change in imwarp transform
inc=2;

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
vid=VideoReader([viddir,dataset,'.mov']);
im_file=[indir,dataset,num2str(vel),'vel_IMAGE.mat'];
% im_file=[indir,dataset,'_IMAGE.mat'];
if exist(im_file,'file')==2
    load(im_file);                 %if exists, load original image stack
else
    im=read(vid,1);
    IMAGE(:,:,(finish-start)/inc)=im(:,:,1).*0;
    clear im
    for i=start:inc:finish
        im=read(vid,i);
        imgray=rgb2gray(im);
%         imgray=rgb2lab(im);
    	IMAGE(:,:,(i-start)/inc+1)=imgray;
    end
    save(im_file,'IMAGE','-v7.3');        %save post-processing parameters
end
close all; clear vid im imgray

%% unwarping all images in stack
display('Unwarping all images in stack')
im_body=[indir,dataset,'_IMAGEbody.mat'];
im_file=[indir,dataset,'_IMAGEunwarp.mat'];
data_file=[indir,dataset,'_transform.mat'];
if exist(im_file,'file')==2
    load(im_body);
    load(im_file);
% elseif exist(data_file,'file')==2 && exist(im_file,'file')==0   %if transform data exists but unwarped images does not
%     load(im_body);
%     load(data_file);
%     IMAGEunwarp=IMAGE;
%     for i=1:1:size(IMAGE,3)-1
%         tform=transform(:,:,i);
%         im=IMAGE(:,:,i+1);%makethemstoptalkingplease
%         newim = imwarp(im,tform,'OutputView',imref2d(size(im)));
%         IMAGEunwarp(:,:,i+1)=newim;
%     end
%     save(im_file,'IMAGEunwarp','-v7.3');
else    %if neither the transform data or unwarped image stack exist
    load(im_body);
    IMAGEunwarp=IMAGE*0;
    counter=0;
    [optimizer, metric]  = imregconfig('monomodal');
    IMAGEunwarp(:,:,1)=IMAGE(:,:,1)-IMAGEbody(:,:,1);%makethemstoptalkingplease%first image
    for i=1:1:size(IMAGE,3)-1
        if counter==0
            xdispold=0;ydispold=0;rotold=0;
        end
        display([num2str((size(IMAGE,3)-i)/size(IMAGE,3)*100),'% complete'])
        im1=IMAGE(:,:,i)-IMAGEbody(:,:,i);
        im2=IMAGE(:,:,i+1)-IMAGEbody(:,:,i+1);
        tform=imregtform(im2,im1,'rigid',optimizer,metric);
        rotnew=asin(tform.T(1,2));xdispnew=tform.T(3,1);ydispnew=tform.T(3,2);
        if i==1
            rot(i,1)=rotnew;
            deltax(i,1)=xdispnew;
            deltay(i,1)=ydispnew;
        else
            abs(abs(rotnew)-abs(rotold))/max(abs(rotold),abs(rotnew))
%             if abs(abs(rotnew)-abs(rotold))/max(abs(rotold),abs(rotnew))>percent && abs(rotnew)>percent
%                 rot(i,1)=rotold;
%                 deltax(i,1)=xdispold;
%                 deltay(i,1)=ydispold;
%             elseif abs(abs(rotnew)-abs(rotold))/max(abs(rotold),abs(rotnew))<=percent && abs(rotnew)>percent
                rot(i,1)=rotnew;
                deltax(i,1)=xdispnew;
                deltay(i,1)=ydispnew;
%             elseif rotnew<=percent
%                 rot(i,1)=rotnew;
%                 deltax(i,1)=xdispnew;
%                 deltay(i,1)=ydispnew;
%             end
        end
%         newim2 = imwarp(im2,tform,'OutputView',imref2d(size(im1)));
%         IMAGEunwarp(:,:,i+1)=newim2;
%         transform(:,:,i+1)=tform;
%         imshow(IMAGEunwarp(:,:,i+1))
%         pause(0.1)
    rotold=rotnew;xdispold=xdispnew;ydispold=ydispnew;
    counter=counter+1;
    end
end
clear im1 im2 newim2 optimizer metric im_filenew

for i=1:1:size(IMAGEunwarp,3)
    imshow([IMAGE(:,:,i),IMAGEunwarp(:,:,i)])
    pause(0.1)
end

n=input('Are you satisfied with the unwarped image stack? Yes [enter]; No [0] ');
if n==0
    break
else
 	save(im_file,'IMAGEunwarp','-v7.3');
    save(data_file,'transform');
end