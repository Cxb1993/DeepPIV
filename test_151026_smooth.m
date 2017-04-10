clc; clear; close all; warning('off');tic

dataset='150811_SC1ATK50+1_BathoStyg_5_clip';
display(dataset);

val=10;
vel=10; %mm/s %UNKNOWN
percent=1; %percent allowable change in imwarp transform
inc=1;
skip=2;

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
load(im_file);                 %if exists, load original image stack
% im_file=[indir,dataset,'_IMAGEunwarp.mat'];
data_file=[indir,dataset,'_transform.mat'];
% load(im_file);
load(data_file);
out_file=[indir,dataset,'_IMAGEunwarpsm.mat'];
data_out=[indir,dataset,'_transformsm.mat'];
IMAGEunwarpsm=IMAGE*0;
%%
for i=1:1:size(transform,1)
    rot(i,1)=asin(transform(i,1).T(1,2));
    xdisp(i,1)=transform(i,1).T(3,1);
    ydisp(i,1)=transform(i,1).T(3,2);
end
%%
if rem(size(rot,1),2)==0
    fix=1;
else
    fix=0;
end
rotsm=sgolayfilt(rot(1:size(rot,1)),9,size(rot,1)-fix);
xdispsm=sgolayfilt(xdisp(1:size(rot,1)),9,size(rot,1)-fix);
ydispsm=sgolayfilt(ydisp(1:size(rot,1)),9,size(rot,1)-fix);
%%
transformsm=transform;
for i=1:1:size(transformsm,1)
    transformsm(i,1).T=[cos(rotsm(i,1)), sin(rotsm(i,1)),0; -sin(rotsm(i,1)), cos(rotsm(i,1)), 0; xdispsm(i,1), ydispsm(i,1), 1];
end
%%
im1=IMAGE(:,:,1);
IMAGEunwarpsm(:,:,1)=im1;%makethemstoptalkingplease%first image
for i=1:1:size(IMAGE,3)-1
    display([num2str((size(IMAGE,3)-i)/size(IMAGE,3)*100),'% complete'])
    im2=IMAGE(:,:,i+1);
    tform=transformsm(i,1);
    if isRigid(tform)==0
        break
    else
        newim2 = imwarp(im2,tform,'OutputView',imref2d(size(im1)));
    end
    IMAGEunwarpsm(:,:,i+1)=newim2;
end

% clear im1 im2 newim2 tform tform2 optimizer metric im_filenew
%%
for i=1:1:size(IMAGEunwarpsm,3)-1
    imshow([IMAGE(:,:,i),IMAGEunwarpsm(:,:,i)])
%     imshowpair(IMAGEunwarpsm(:,:,1),IMAGEunwarpsm(:,:,i+1))
    pause(0.1)
end
%%
n=input('Are you satisfied with the unwarped image stack? Yes [enter]; No [0] ');
if n==0
    break
else
 	save(out_file,'IMAGEunwarpsm','-v7.3');
    save(data_out,'transformsm');
end