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
% vid=VideoReader([viddir,dataset,'.mov']);
im_file=[indir,dataset,num2str(vel),'vel_IMAGE.mat'];
load(im_file);                 %if exists, load original image stack
%% unwarping all images in stack
display('Unwarping all images in stack')
im_body=[indir,dataset,'_IMAGEbody.mat'];
im_file=[indir,dataset,'_IMAGEunwarp.mat'];
data_file=[indir,dataset,'_transform.mat'];
    load(im_body);
    IMAGEunwarp=IMAGE*0;
    counter=0;
    xdisp=0;ydisp=0;rot=0;
    [optimizer, metric]  = imregconfig('multimodal');
    optimizer.InitialRadius = 0.009;
    optimizer.Epsilon = 1.5e-4;
    optimizer.GrowthFactor = 1.01;
    optimizer.MaximumIterations = 300;
    im1=IMAGE(:,:,1)-IMAGEbody(:,:,1);
    IMAGEunwarp(:,:,1)=IMAGE(:,:,1);%makethemstoptalkingplease%first image
    for i=1:1:size(IMAGE,3)-1
        display([num2str((size(IMAGE,3)-i)/size(IMAGE,3)*100),'% complete'])
        if max(max(IMAGE(:,:,i)))>0
%             im1=IMAGE(:,:,i)-IMAGEbody(:,:,i);
            im2=IMAGE(:,:,i+1)-IMAGEbody(:,:,i+1);
%             tformEstimate = imregcorr(im2,im1,'rigid');
            if i==1
                tformnew=imregtform(im2,im1,'rigid',optimizer,metric);%,'InitialTransformation',tformEstimate);
            else
                tformnew=imregtform(im2,im1,'rigid',optimizer,metric,'InitialTransformation',tform);
            end
            rotnew=asin(tformnew.T(1,2));
            xdispnew=tformnew.T(3,1);
            ydispnew=tformnew.T(3,2);
            if isRigid(tformnew)==0
                break
            else
             	tform=tformnew;
                rot=rotnew;
                xdisp=xdispnew;
                ydisp=ydispnew;
                newim2 = imwarp(IMAGE(:,:,i+1),tform,'OutputView',imref2d(size(im1)));
            end
        end
    transform(i,1)=tform;
    simptrans(i,1:3)=[rot,xdisp,ydisp];
    IMAGEunwarp(:,:,i+1)=newim2;
%     imshowpair(im1,newim2)
%  	pause(0.1)
    end

% clear im1 im2 newim2 tform tform2 optimizer metric im_filenew

for i=1:1:size(IMAGEunwarp,3)-1
    imshow([IMAGE(:,:,i),IMAGEunwarp(:,:,i)])
%     imshowpair(IMAGEunwarp(:,:,1),IMAGEunwarp(:,:,i+1))
    pause(0.1)
end

n=input('Are you satisfied with the unwarped image stack? Yes [enter]; No [0] ');
if n==0
    break
else
 	save(im_file,'IMAGEunwarp','-v7.3');
    save(data_file,'transform');
end