clc; clear; close all; warning('off');tic

dataset='150811_SC1ATK50+1_BathoStyg_5_clip';
display(dataset);

val=10;
vel=100; %mm/s %UNKNOWN
percent=0.05; %percent allowable change in imwarp transform
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

preim_file=[indir,dataset,'_IMAGE.mat'];
im_file=[indir,dataset,'_IMAGEbody.mat'];
mask_file=[indir,dataset,'_MASKbody.mat'];
if exist(preim_file,'file')==2
    display('     Loading IMAGE stacks...');
    load(preim_file);
%     load(im_file);
%     load(mask_file);
else
    display('     Body points are not extracted. Run DeepPIV_3DR_ManualBody.m.')
    break
end

%% extract body features manually
display('Extracting body features manually')
im_filenew=[indir,dataset,'_IMAGEbody.mat'];
% im_filenew=[indir,dataset,'_IMAGEbody.mat'];
if exist(im_filenew,'file')==2
    display('     Loading IMAGEbody...');
    load(im_filenew);
%     im_filenew=[indir,dataset,'_',num2str(vel),'vel_MASKbody.mat'];
%     load(im_filenew)
else
    display('     Determining IMAGEbody using manual filling...');
    IMAGEbody=IMAGE.*0;
    MASK=IMAGEbody;
    for i=1:1:size(IMAGE,3)
        display(['frame number: ',num2str(i)]);
        im=IMAGE(:,:,i);
        imfinal=im.*0;mask=logical(imfinal);
        n=0;
        while n==0
            [imfinal,mask]=bodyfillmanual(im,imfinal,mask);
            m=input('Do you need to fill mask? no [enter], yes [0] ');
            if m==0
                mask=imfill(mask);
                imfinal=imadjust(im,[0,0.5],[0,1]).*uint8(mask);
                imshow(imfinal)
            end
            n=input('Do you need to manually fill? no = [enter], yes = 0 ');
        end
        clear n
        IMAGEbody(:,:,i)=imfinal;
        MASK(:,:,i)=mask;
    end
	save(im_filenew,'IMAGEbody','-v7.3');        %save post-processing parameters
%     im_filenew=[indir,dataset,'_',num2str(vel),'vel_MASKbody.mat'];
    im_filenew=[indir,dataset,'_MASKbody.mat'];
	save(im_filenew,'MASK','-v7.3');        %save post-processing parameters
end
close all; %clear IMAGE MASK