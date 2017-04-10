dataset='151206_SC1ATK70_Batho_6c';
% function DeepPIV_MakeIMAGE(dataset)

display(dataset);
inc=1;
vel=1;
%% retrieving data set-specific parameters
[dir,start,finish,~,~,fps]=data_summary(dataset);
if fps==30
    inc=2;
end
display('Making image stack.')
viddir=[dir,'clips/'];
outdir=[dir,'output/'];
indir=[dir,'input/'];
% vid=VideoReader([viddir,dataset,'.mov']);
vid=VideoReader([viddir,dataset(1,1:size(dataset,2)-1),'.mov']);

%% arranging planar cross sections into "volume" matrix
% im_file=[indir,dataset,num2str(vel),'vel_IMAGE.mat'];
im_file=[indir,dataset,'_IMAGE.mat'];
if exist(im_file,'file')==2
    display('Image stack already exists.')
    return
else
    im=read(vid,1);
    IMAGE(:,:,floor((finish-start)/inc))=im(:,:,1).*0;
    clear im
    for i=start:inc:finish
        im=read(vid,i);
        imgray=rgb2gray(im);
%         imgray=rgb2lab(im);
        IMAGE(:,:,(i-start)/inc+1)=imgray;
    end
    display('Saving image stack.')
    save(im_file,'IMAGE','-v7.3');        %save post-processing parameters
end
clear; close all;
% end
