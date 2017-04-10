% clc;clear
% addpath(genpath('/Users/kakani/Documents/MATLAB/PIVlab1/'))
clc; clear; close all
global filt average

file='150601_SC1ATK28_pasiph_4';
filt=1;
average=1;    
[dir,~,~,calib]=data_summary(file);
inc=5;

    %% importing video file to stack of images
    outfile=[dir file '_imdata.mat'];
	display('Progress: loading frames')
    if exist(outfile)==0
        IMAGES = PIV_videoread(file);
    else
        load(outfile);
    end
    display('Progress: frames loaded')
	%% running PIV post-processing
  	outfile=[dir file '_filtveldata.mat'];
    display('Progress: filtering velocity field data')
    if exist(outfile)==0
        filtdata=PIV_postproc(file,IMAGES,data);
        save(outfile,'filtdata')
    else
        load(outfile)
    end
    display('Progress: velocity fields filtered')
    %%
	for i=92%1:1:size(filtdata,2)
        h=figure(2);
        imshow(IMAGES(:,:,i))
        hold on
        if exist('filt')==1
            if filt==1 && average==1
                aveu=mean(mean(filtdata(i).u));
                avev=mean(mean(filtdata(i).v));
                quiver(filtdata(i).x,filtdata(i).y,filtdata(i).u-aveu,filtdata(i).v-avev,3,'w','LineWidth',2)
            elseif filt==1 && average==0
                quiver(filtdata(i).x,filtdata(i).y,filtdata(i).u,filtdata(i).v,3,'w')
            else
                quiver(data(i).x,data(i).y,data(i).u,data(i).v,3,'w')
            end
        else
            quiver(filtdata(i).x,filtdata(i).y,filtdata(i).u,filtdata(i).v,3,'w')
        end
        axis([0,1920,0,1080]);axis off
%         text(0,100,['frame number: ',num2str(i)],'Color','w')
        pause(1)
        pts=[995,879;1135,879];
        plot(pts(:,1),pts(:,2),'r-')
        range=[pts(1,1):inc:pts(2,1)]';
        range=[range,range*0+pts(1,2)];
        urange=interp2(filtdata(i).x,filtdata(i).y,filtdata(i).u,range(:,1),range(:,2));
        vrange=interp2(filtdata(i).x,filtdata(i).y,filtdata(i).v,range(:,1),range(:,2));
        quiver(range(:,1),range(:,2),urange,vrange,3,'r','LineWidth',2)
        hold off
        dx=range(2,1)-range(1,1);
        intline=sum(dx*vrange);
        intvolume=intline*pi/(calib^3)*60*60    %cubic centimeters per hour
    end
    
    im=getframe(h,[60,36,1920,1080]);
    imwrite(im.cdata, ['/users/kakani/desktop/',file,'_',num2str(i),'_velvolout.tif']);
%     assignin('base','mov',mov);
%     assignin('base','dir',dir)
