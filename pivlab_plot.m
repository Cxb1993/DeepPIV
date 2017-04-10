clc; clear; close all

directory='/users/kakani/desktop/pasapheid/';
direc = dir([directory,filesep,'*.tif']); filenames={};
[filenames{1:length(direc),1}] = deal(direc.name);
filenames = sortrows(filenames); %sort all image files
outfile=[directory 'veldata/pasapheid_1_veldata.mat'];
load(outfile,'data')

x=data.x;
y=data.y;
u=data.u;
v=data.v;
uf=data.uf;
vf=data.vf;

xpos=x{1,1};
ypos=y{1,1};

maxvel=0;
for i=1:1:size(x,1)
    ucf=uf{i,1};
    vcf=vf{i,1};
    maxucf=max(max(abs(ucf)));
    maxvcf=max(max(abs(vcf)));
    if maxucf>maxvcf && maxucf>maxvel
        maxvel=maxucf;
    elseif maxvcf>maxucf && maxvcf>maxvel
        maxvel=maxvcf;
    end
end

for i=1:1:size(x,1)
    uc=u{i,1};
    vc=v{i,1};
    ucf=uf{i,1};
    vcf=vf{i,1};
%     index=find(isnan(uc)==1);
%     uc(index)=0;
%     index=find(isnan(vc)==1);
%     vc(index)=0;

	im=imread(fullfile(directory, filenames{i})); % read images
    
%     figure(1)
%     subplot(1,2,1)
%     imshow(im)
%     hold on
%     quiver(xpos,ypos,uc,vc,'w')
%     hold off
%     title('Raw Velocity Field')
%     axis equal
%     subplot(1,2,2)
%     imshow(im)
%     hold on
%     quiver(xpos,ypos,ucf,vcf,'w')
%     hold off
%     title('Filtered Velocity Field')
%     axis equal
%     pause(0.5)
    
    figure(2)
    colormap('gray')
    imshow(im)
%     imagesc(im)
%     freezeColors
    hold on
    quiver(xpos,ypos,ucf-mean(mean(ucf)),vcf-mean(mean(vcf)),2,'y')
%     colormap('jet')
%     quiverwcolorbar(xpos,ypos,ucf-mean(mean(ucf)),vcf-mean(mean(vcf)),0,'bounds',[0,round(maxvel)]);
    hold off
    axis off
    outim=[directory '/overlay/overlay_' num2str(i) '.tif'];
%     print('-f2','-dtiff','-r200',outim)
    pause(0.5)
	    
%     figure(3)
%     colormap('gray')
%     subplot(2,1,1),subimage(im),hold on, quiver(xpos,ypos,uc,vc,2,'w'),hold off,title('unfiltered'),axis off
%     subplot(2,1,2),subimage(im),hold on, quiver(xpos,ypos,ucf,vcf,2,'w'),hold off,title('filtered'),axis off
%     pause(0.5)
%     
%     figure(4)
%     colormap('gray')
%     subplot(2,1,1),subimage(im),hold on, quiver(xpos,ypos,ucf,vcf,2,'w'),hold off,title('uncorrected'),axis off
%     subplot(2,1,2),subimage(im),hold on, quiver(xpos,ypos,ucf-mean(mean(ucf)),vcf-mean(mean(vcf)),2,'w'),hold off,title('corrected'),axis off
%     pause(0.5)
%     
%     figure(5)
%     colormap('gray')
%     subplot(2,1,1),subimage(im),hold on, quiver(xpos,ypos,uc,vc,2,'w'),hold off,title('uncorrected'),axis off
%     subplot(2,1,2),subimage(im),hold on, quiver(xpos,ypos,uc-mean(mean(uc)),vc-mean(mean(vc)),2,'w'),hold off,title('corrected'),axis off
%     pause(0.5)
    
end
close all
