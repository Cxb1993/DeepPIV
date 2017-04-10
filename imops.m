function [mask,maxarea,minarea]=imops(dataset,imnew)

dataset=dataset(1,1:size(dataset,2)-1);

if strcmp(dataset,'150727_SC1ATK41_bathos_14')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>160,25),'close'),25);
    minarea=20;
    maxarea=200;
elseif strcmp(dataset,'150727_SC1ATK41_bathos_15')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>100,15),'close'),20);
    minarea=20;
    maxarea=200;
elseif strcmp(dataset,'150727_SC1ATK42_bathos_14')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>220,25),'close'),25);
    minarea=20;
    maxarea=150;
elseif strcmp(dataset,'150727_SC1ATK42_bathos_15')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>220,25),'close'),25);
    minarea=20;
    maxarea=150;
elseif strcmp(dataset,'150727_SC1ATK42_bathos_17')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>220,25),'close'),25);
    minarea=20;
    maxarea=150;
elseif strcmp(dataset,'150727_SC1ATK42_bathos_27')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>125,25),'close'),25);
    minarea=20;
    maxarea=300;
elseif strcmp(dataset,'150808_SC1ATK45_Batho_8')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>120,25),'close'),25);
    minarea=15;
    maxarea=200;
elseif strcmp(dataset,'150811_SC1ATK50_BathoStyg_10')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>70,25),'close'),25);
    minarea=25;
    maxarea=200;
elseif strcmp(dataset,'150811_SC1ATK50+1_BathoStyg_4')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>80,25),'close'),25);
    minarea=25;
    maxarea=400;
elseif strcmp(dataset,'150811_SC1ATK50+1_BathoStyg_5')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>80,25),'close'),25);
    minarea=20;
    maxarea=1000;
elseif strcmp(dataset,'150813_SC1ATK52+1_Batho_3')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>90,25),'close'),25);
    minarea=20;
    maxarea=400;
elseif strcmp(dataset,'150813_SC1ATK52+1_Batho_14')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>120,25),'close'),25);
    minarea=20;
    maxarea=400;
elseif strcmp(dataset,'150813_SC1ATK52+1_Batho_8')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>80,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'150813_SC1ATK52+1_Batho_9')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>130,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'151120_SC1ATK62_Batho_20')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>115,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'151120_SC1ATK62_Batho_22')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>110,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'150813_SC1ATK52+1_Batho_14')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>110,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'151205_SC1ATK67+1_Batho_10')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>150,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'151205_SC1ATK67+1_Batho_12')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>150,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'151206_SC1ATK69+1_Batho_6')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>170,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'151206_SC1ATK69+1_Batho_8')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>200,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'151206_SC1ATK70_Batho_6')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>170,25),'close'),25);
    minarea=20;
    maxarea=500;
elseif strcmp(dataset,'151206_SC1ATK70_Batho_7')==1
    mask=bwareaopen(bwmorph(bwareaopen(imnew>170,25),'close'),25);
    minarea=20;
    maxarea=500;
else
    mask=0*imnew;
    minarea=1;
    maxarea=1000;
end
    