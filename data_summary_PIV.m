function [intArea,stepsize,finArea,subpixFinder,mask,ROI,npasses,windef,CLAHE,CLAHEsize,highpass,highpassSize,clip,weiner,weinerSize,umin,umax,vmin,vmax,stdthresh,epsilon,thresh]=data_summary_PIV(file);

if strcmp(file,'150601_SC1ATK25_vortexgen_1')==1
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[750,1,800,1079]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=9;   %CLAHE window size
    highpass=1; %1 = enable highpass, 0 = disable
    highpassSize=7;    %highpass size
    clip=0; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=2;   %Wiener2 window size
    umin = [];%-5; % minimum allowed u velocity
    umax = [];%5; % maximum allowed u velocity
    vmin = [];%-5; % minimum allowed v velocity
    vmax = [];%5; % maximum allowed v velocity
    stdthresh=5; % threshold for standard deviation check
    epsilon=0.5; % epsilon for normalized median test
    thresh=5; % threshold for normalized median test
elseif strcmp(file,'150601_SC1ATK25_vortexgen_3')==1
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[700,1,800,1079]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=9;   %CLAHE window size
    highpass=1; %1 = enable highpass, 0 = disable
    highpassSize=7;    %highpass size
    clip=0; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=2;   %Wiener2 window size
    umin = [];%-5; % minimum allowed u velocity
    umax = [];%5; % maximum allowed u velocity
    vmin = [];%-5; % minimum allowed v velocity
    vmax = [];%5; % maximum allowed v velocity
    stdthresh=5; % threshold for standard deviation check
    epsilon=0.25; % epsilon for normalized median test
    thresh=5; % threshold for normalized median test
elseif strcmp(file,'150601_SC1ATK28_pasiph_4')==1
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[450,1,1025,1079]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=9;   %CLAHE window size
    highpass=0; %1 = enable highpass, 0 = disable
    highpassSize=7;    %highpass size
    clip=0; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=4;   %Wiener2 window size
    umin = [];%-5; % minimum allowed u velocity
    umax = [];%5; % maximum allowed u velocity
    vmin = [];%-5; % minimum allowed v velocity
    vmax = [];%5; % maximum allowed v velocity
    stdthresh=30; % threshold for standard deviation check
    epsilon=0.3; % epsilon for normalized median test
    thresh=5; % threshold for normalized median test
elseif strcmp(file,'150808_SC1ATK45_vortexgen_1')==1
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[350,1,1200,1079]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=10;   %CLAHE window size
    highpass=0; %1 = enable highpass, 0 = disable
    highpassSize=7;    %highpass size
    clip=0; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=2;   %Wiener2 window size
    umin = [];%-5; % minimum allowed u velocity
    umax = [];%5; % maximum allowed u velocity
    vmin = [];%-5; % minimum allowed v velocity
    vmax = [];%5; % maximum allowed v velocity
    stdthresh=5; % threshold for standard deviation check
    epsilon=0.5; % epsilon for normalized median test
    thresh=5; % threshold for normalized median test
elseif strcmp(file,'150808_SC1ATK45_vortexgen_3')==1
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[350,1,1200,1079]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=10;   %CLAHE window size
    highpass=0; %1 = enable highpass, 0 = disable
    highpassSize=7;    %highpass size
    clip=0; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=2;   %Wiener2 window size
    umin = [];%-5; % minimum allowed u velocity
    umax = [];%5; % maximum allowed u velocity
    vmin = [];%-5; % minimum allowed v velocity
    vmax = [];%5; % maximum allowed v velocity
    stdthresh=5; % threshold for standard deviation check
    epsilon=0.5; % epsilon for normalized median test
    thresh=5; % threshold for normalized median test
elseif strcmp(file,'150808_SC1ATK45_vortexgen_4')==1
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[350,1,1200,1079]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=10;   %CLAHE window size
    highpass=0; %1 = enable highpass, 0 = disable
    highpassSize=7;    %highpass size
    clip=0; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=2;   %Wiener2 window size
    umin = [];%-5; % minimum allowed u velocity
    umax = [];%5; % maximum allowed u velocity
    vmin = [];%-5; % minimum allowed v velocity
    vmax = [];%5; % maximum allowed v velocity
    stdthresh=5; % threshold for standard deviation check
    epsilon=0.5; % epsilon for normalized median test
    thresh=5; % threshold for normalized median test
elseif strcmp(file,'151023_MVI3475_vortexgen_30mm')==1 || strcmp(file,'151023_MVI3476_vortexgen_40mm')==1 || strcmp(file,'151023_MVI3477_vortexgen_50mm')==1
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[400,1,600,719]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=10;   %CLAHE window size
    highpass=1; %1 = enable highpass, 0 = disable
    highpassSize=8;    %highpass size
    clip=1; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=2;   %Wiener2 window size
    umin = []; % minimum allowed u velocity
    umax = []; % maximum allowed u velocity
    vmin = []; % minimum allowed v velocity
    vmax = []; % maximum allowed v velocity
    stdthresh=2; % threshold for standard deviation check
    epsilon=0.1; % epsilon for normalized median test
    thresh=2; % threshold for normalized median test
elseif strcmp(file,'151120_SC1ATK58_VortexGen_best')==1 
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[400,1,1000,1079]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=10;   %CLAHE window size
    highpass=1; %1 = enable highpass, 0 = disable
    highpassSize=10;    %highpass size
    clip=1; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=2;   %Wiener2 window size
    umin = []; % minimum allowed u velocity
    umax = []; % maximum allowed u velocity
    vmin = []; % minimum allowed v velocity
    vmax = []; % maximum allowed v velocity
    stdthresh=2; % threshold for standard deviation check
    epsilon=0.1; % epsilon for normalized median test
    thresh=2; % threshold for normalized median test
elseif strcmp(file,'161027_33-3_VortexGenerator_1')==1 
    intArea=64; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=32; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=3; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=20;   %CLAHE window size
    highpass=1; %1 = enable highpass, 0 = disable
    highpassSize=20;    %highpass size
    clip=0; %1 = enable clipping, 0 = disable
    weiner=0;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=2;   %Wiener2 window size
    umin = []; % minimum allowed u velocity
    umax = []; % maximum allowed u velocity
    vmin = []; % minimum allowed v velocity
    vmax = []; % maximum allowed v velocity
    stdthresh=4; % threshold for standard deviation check
    thresh=2; % threshold for normalized median test
    epsilon=0.5; % epsilon for normalized median test
else
    intArea=0; %initialwindow size
    stepsize=0.5*intArea;   %stepsize
    finArea=0; %additional pass window size
    subpixFinder=1; %1 = 3point Gauss, 2 = 2D Gauss
    mask=[];    %generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
    ROI=[]; %[x,y,width,height] in pixels (matrix indexing), may be left empty
    npasses=4; %1-4 nr. of passes
    windef='*linear'; %'*spline' is more accurate, but slower
    CLAHE=1;    %1 = enable CLAHE (contrast enhancement), 0 = disable
    CLAHEsize=50;   %CLAHE window size
    highpass=1; %1 = enable highpass, 0 = disable
    highpassSize=15;    %highpass size
    clip=0; %1 = enable clipping, 0 = disable
    weiner=1;   %1 = enable Wiener2 adaptive denaoise filter, 0 = disable
    weinerSize=3;   %Wiener2 window size
    umin = -1; % minimum allowed u velocity
    umax = 1; % maximum allowed u velocity
    vmin = -1; % minimum allowed v velocity
    vmax = 1; % maximum allowed v velocity
    stdthresh=1; % threshold for standard deviation check
    epsilon=0; % epsilon for normalized median test
    thresh=1; % threshold for normalized median test
end