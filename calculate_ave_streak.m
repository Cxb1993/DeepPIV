clc; clear; close all; warning('off');tic

dataset='150727_SC1ATK42_bathos_27c';
display(dataset);

[dir,~,~,calib,~,fps]=data_summary(dataset);
indir=[dir,'input/'];
outdir=[dir,'output/'];
% nFrames=finish-start;

im_file=[indir,dataset,'_IMAGE.mat'];
% im_file=[indir,dataset,num2str(vel),'vel_IMAGE.mat'];
body_file=[indir,dataset,'_MASKbody.mat'];
data_file=[outdir,dataset,'_streakdata.mat'];

load(data_file);                 %if exists, load original image stack

length=[];
for m=1:1:size(data,2)
    if isempty(data{1,m})==0
        for n=1:1:size(data{1,m}.stats,1)
            length=[length,data{1,m}.stats(n).Distance];
            maxlength(m,1)=max(length);
            length=[];
        end
    else
        maxlength(m,1)=0;
    end
end

figure(1)
% plot(maxlength(maxlength>0),'b*')
avetotlength=mean(maxlength(maxlength>0));
plot(maxlength,'b*')
hold on
plot([0,size(maxlength,1)],[avetotlength,avetotlength],'k--')
hold off
grid on

cutoff=input('What is the cutoff length? ');
display(['Average streak length = ',num2str(round(mean(maxlength(maxlength>=cutoff)))),' pixels'])
cutoff=avetotlength;
display(['Average streak length = ',num2str(round(mean(maxlength(maxlength>=cutoff)))),' pixels'])