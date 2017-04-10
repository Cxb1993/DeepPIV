function [s,p] = piv_settings(file)

[intArea,stepsize,finArea,subpixFinder,mask,ROI,npasses,windef,CLAHE,CLAHEsize,highpass,highpassSize,clip,weiner,weinerSize]=data_summary_PIV(file);

%% Standard PIV Settings
s = cell(10,2); % To make it more readable, let's create a "settings table"
%Parameter                       %Setting           %Options
s{1,1}= 'Int. area 1';           s{1,2}=intArea;         % window size of first pass
s{2,1}= 'Step size 1';           s{2,2}=stepsize;         % step of first pass
s{3,1}= 'Subpix. finder';        s{3,2}=subpixFinder;          % 1 = 3point Gauss, 2 = 2D Gauss
s{4,1}= 'Mask';                  s{4,2}=mask;         % If needed, generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
s{5,1}= 'ROI';                   s{5,2}=ROI;         % Region of interest: [x,y,width,height] in pixels (matrix indexing), may be left empty
s{6,1}= 'Nr. of passes';         s{6,2}=npasses;          % 1-4 nr. of passes
s{7,1}= 'Int. area 2';           s{7,2}=finArea;         % second pass window size
s{8,1}= 'Int. area 3';           s{8,2}=finArea;         % third pass window size
s{9,1}= 'Int. area 4';           s{9,2}=finArea;         % fourth pass window size
s{10,1}='Window deformation';    s{10,2}=windef; % '*spline' is more accurate, but slower

%% Standard image preprocessing settings
p = cell(8,1);
%Parameter                       %Setting           %Options
p{1,1}= 'ROI';                   p{1,2}=s{5,2};     % same as in PIV settings
p{2,1}= 'CLAHE';                 p{2,2}=CLAHE;          % 1 = enable CLAHE (contrast enhancement), 0 = disable
p{3,1}= 'CLAHE size';            p{3,2}=CLAHEsize;         % CLAHE window size
p{4,1}= 'Highpass';              p{4,2}=highpass;          % 1 = enable highpass, 0 = disable
p{5,1}= 'Highpass size';         p{5,2}=highpassSize;         % highpass size
p{6,1}= 'Clipping';              p{6,2}=clip;          % 1 = enable clipping, 0 = disable
p{7,1}= 'Wiener';                p{7,2}=weiner;          % 1 = enable Wiener2 adaptive denaoise filter, 0 = disable
p{8,1}= 'Wiener size';           p{8,2}=weinerSize;          % Wiener2 window size
