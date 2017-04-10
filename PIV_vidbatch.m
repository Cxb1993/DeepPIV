addpath(genpath('/Users/kakani/Documents/MATLAB/PIVlab1/'))
clc; clear; close all
global filestub file dir

filestub='161027_33-3_VortexGenerator_1';
dir='/users/kakani/desktop/VortexGenerator/';
namestub=['a','b','c','d','e'];
for i=1:1:size(namestub,2)
    file=[filestub,namestub(1,i)];
    display(['Loading video: ',file])
    vid=VideoReader([dir,file,'.mov']);
    fps=vid.FrameRate;length=vid.Duration;
    start=1;finish=fps*length;
    if round(fps)==30
        inc=2;
    else
        inc=1;
    end
    for j=start:inc:5%finish
        im=read(vid,j);
        imgray=im(:,:,1);
        IMAGES(:,:,(j-start)/inc+1)=imgray;
    end
    GoPIV_vids(file,IMAGES)
end