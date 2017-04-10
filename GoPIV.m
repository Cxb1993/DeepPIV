function GoPIV(file)
    global filt average filestub
    [dir,~,~,~]=data_summary(file);

    %% importing video file to stack of images
    outfile=[dir file '_imdata.mat'];
	display('Progress: loading frames')
    if exist(outfile)==0
    	IMAGES = PIV_videoread(file);
    else
        load(outfile);
    end
    display('Progress: frames loaded')
    %% running PIV analysis
  	outfile=[dir file '_veldata.mat'];
    display('Progress: calculating velocity fields')
    if exist(outfile)==0
        %add if statement for PIV specs
        if strcmp(filestub,'151023_MVI3475_vortexgen_30mm')==1 || strcmp(filestub,'151023_MVI3476_vortexgen_40mm')==1 || strcmp(filestub,'151023_MVI3477_vortexgen_50mm')==1
            data=PIV_analysis(IMAGES,filestub);
        else
            data=PIV_analysis(IMAGES,file);
        end
        save(outfile,'data')
    else
        load(outfile);
    end
    display('Progress: velocity fields calculated')
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
    
    if isempty(filt)==0
        for i=1:1:size(data,2)
            figure(1)
            subplot(2,1,1),subimage(IMAGES(:,:,i))
            hold on
            quiver(data(i).x,data(i).y,data(i).u,data(i).v,3,'w')
            hold off
            axis([0,1920,0,1080])
            subplot(2,1,2),subimage(IMAGES(:,:,i))
            hold on
            quiver(filtdata(i).x,filtdata(i).y,filtdata(i).u,filtdata(i).v,3,'w')
            hold off
            axis([0,1920,0,1080])
            pause(0.2)

            h=figure(2);
            imshow(IMAGES(:,:,i))
            hold on
            if isempty(filt)==0
                if filt==1 && average==1
                    aveu=mean(mean(filtdata(i).u));
                    avev=mean(mean(filtdata(i).v));
                    quiver(filtdata(i).x,filtdata(i).y,filtdata(i).u-aveu,filtdata(i).v-avev,3,'w')
                elseif filt==1 && average==0
                    quiver(filtdata(i).x,filtdata(i).y,filtdata(i).u,filtdata(i).v,3,'w')
                else
                    quiver(data(i).x,data(i).y,data(i).u,data(i).v,3,'w')
                end
            else
                quiver(filtdata(i).x,filtdata(i).y,filtdata(i).u,filtdata(i).v,3,'w')
            end
            hold off
            axis([0,1920,0,1080]);axis off
            mov(i)=getframe(h,[60,36,1920,1080]);
        end
        assignin('base','mov',mov);
        assignin('base','dir',dir)
    end