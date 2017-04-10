function IMAGES = PIV_videoread(file)

global filestub

[dir,start,finish,~,shutter]=data_summary(file);
if shutter==30
    inc=2;
else
    inc=1;
end
if strcmp(filestub,'151023_MVI3475_vortexgen_30mm')==1 || strcmp(filestub,'151023_MVI3476_vortexgen_40mm')==1 || strcmp(filestub,'151023_MVI3477_vortexgen_50mm')==1
    video_file=[dir,filestub,'.mov'];
else
    video_file=[dir,file,'.mov'];
end
vidObj=VideoReader(video_file);
vidHeight=vidObj.Height;
vidWidth=vidObj.Width;
fps=vidObj.FrameRate;
tstart=start/fps;
tfinish=finish/fps;

mov=struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
%% compiling sampling of images into a single matrix
vidObj.CurrentTime = tstart;   %start time on clip
k = 1;
while vidObj.CurrentTime <= tfinish
    mov(k).cdata = readFrame(vidObj);
    k = k+1;
end
% hf=figure;
% set(hf,'Position',[0,0,vidWidth,vidHeight]);
% movie(hf,mov,1,vidObj.FrameRate);

% IMAGES(1:vidHeight,1:vidWidth,1:size(mov,2))=0;
counter=1;
for i=1:inc:size(mov,2)
    im=mov(i).cdata;
    imnew=rgb2gray(im);
%     imnew=imsubtract(imnew,mean(mean(imnew)));
    IMAGES(:,:,counter)=imnew;
    counter=counter+1;
end

% for i=1:1:size(IMAGES,3)
%     figure(1)
%     imshow(IMAGES(:,:,i))
%     pause()
% end

outfile=[dir file '_imdata.mat'];
save(outfile,'IMAGES','-v7.3')