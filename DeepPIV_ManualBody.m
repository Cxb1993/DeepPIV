function [IMAGEbody,MASK]=DeepPIV_ManualBody(dataset)
% clc; clear; close all; warning('off');tic

% dataset='150811_SC1ATK50+1_BathoStyg_5_clip';
display(dataset);
inc=1;

%retrieving data set-specific parameters
[dir,~,~,~,~,fps]=data_summary(dataset);
indir=[dir,'input/'];
outdir=[dir,'output/'];
% nFrames=finish-start;

preim_file=[indir,dataset,'_IMAGE.mat'];
im_file=[indir,dataset,'_IMAGEbody.mat'];
mask_file=[indir,dataset,'_MASKbody.mat'];
if exist(preim_file,'file')==2
    display('     Loading IMAGE stacks...');
    load(preim_file);
%     load(im_file);
%     load(mask_file);
else
    display('     IMAGE stack is not extracted. Run DeepPIV_MakeIMAGE.m.')
    break
end

%% extract body features manually
display('Extracting body features manually')
im_filenew=[indir,dataset,'_IMAGEbody.mat'];
mask_filenew=[indir,dataset,'_MASKbody.mat'];
%     mask_filenew=[indir,dataset,'_',num2str(vel),'vel_MASKbody.mat'];
if exist(im_filenew,'file')==2
    display('     Loading IMAGEbody...');
    load(im_filenew);
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
	save(mask_filenew,'MASK','-v7.3');        %save post-processing parameters
end
close all; %clear IMAGE MASK