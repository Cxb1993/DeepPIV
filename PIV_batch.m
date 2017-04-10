addpath(genpath('/Users/kakani/Documents/MATLAB/PIVlab1/'))
clc; clear; close all
global filestub

filestub='151023_MVI3475_vortexgen_30mm';
for i=5:2:5
    file=[filestub,'_',num2str(i)];
    display(file)
    GoPIV(file)
end
filestub='151023_MVI3476_vortexgen_40mm';
for i=1:2:5
    file=[filestub,'_',num2str(i)];
    display(file)
    GoPIV(file)
end
filestub='151023_MVI3477_vortexgen_50mm';
for i=1:2:5
    file=[filestub,'_',num2str(i)];
    display(file)
    GoPIV(file)
end

