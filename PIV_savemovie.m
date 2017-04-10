addpath(genpath('/Users/kakani/Documents/MATLAB/PIVlab1/'))
clc; clear; close all
global filt average

file='150808_SC1ATK45_vortexgen_4';
filt=1;
average=1;

GoPIV(file)

if filt==1 && average==1
    outfile=[dir,file,'_velfiltave.mp4'];
elseif filt==1 && average==0
    outfile=[dir,file,'_velfilt.mp4'];
else
    outfile=[dir,file,'_velunfilt.mp4'];
end
writerObj=VideoWriter(outfile,'MPEG-4');
open(writerObj);
writeVideo(writerObj,mov);
close(writerObj);