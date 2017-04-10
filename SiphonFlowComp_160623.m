clc; clear; close all;
dir='/Volumes/DeepPIV-3DR/DeepPIV_field/160623_WesternFlyer_DeepPIV/clips/';
file_1000='DEEPPIV_S850_S001_T011.MOV';
file_60='DEEPPIV_S850_S001_T012.MOV';

vid=[dir,file_1000];
start=1;
finish=41;
vidObj=VideoReader(vid);
fps=vidObj.FrameRate;
vidObj.CurrentTime=start/fps;
k=1;
while vidObj.CurrentTime <= finish/fps
    mov(k).cdata=readFrame(vidObj);
    k=k+1;
end
mov_1000=mov;
clear mov start finish vid vidObj fps k

vid=[dir,file_60];
start=40710;
finish=40810;
% start=100;
% finish=200;
vidObj=VideoReader(vid);
fps=vidObj.FrameRate;
vidObj.CurrentTime=start/fps;
k=1;
while vidObj.CurrentTime <= finish/fps
    mov(k).cdata=readFrame(vidObj);
    k=k+1;
end
mov_60=mov;
clear mov start finish vid vidObj fps k

%%
mov=mov_60;
% mov=mov_1000;
start=1;
finish=30;
im=mov(start).cdata(:,:,1);
counter=1;
for i=start+1:1:finish
    newim=mov(i).cdata(:,:,1);
    im=max(im,newim);
    figure(1)
%     imshow([newim,im])
    imshow(im)
    pause(0.5)
%     newmov(counter).cdata=im;
%     newmov(counter).colormap=gray;
%     counter=counter+1;
end
% outfile=[dir,'SiphonFlowRate_1000sh.mp4'];
% writerObj=VideoWriter(outfile,'MPEG-4');
% open(writerObj);
% writeVideo(writerObj,newmov);
% close(writerObj);