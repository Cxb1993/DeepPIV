function [dir,start,finish,calib,shutter,fps]=data_summary(file)

fps=60;
if strcmp(file,'150601_SC1ATK25_vortexgen_3')==1
   	dir='/Users/kakani/Desktop/150601_RachelCarson_DeepPIV/';
    start=15;
    finish=530;
    calib=34;   %pixels/cm
    shutter=30;
elseif strcmp(file,'150601_SC1ATK28_pasiph_4')==1
   	dir='/Users/kakani/Desktop/150601_RachelCarson_DeepPIV/';
    start=135;
    finish=800;
    calib=43;   %pixels/cm assuming animal is 5 cm long
    shutter=60;
elseif strcmp(file,'150601_SC1ATK25_vortexgen_1')==1
    dir='/Users/kakani/Desktop/150601_RachelCarson_DeepPIV/';
    start=54;
    finish=332;
    calib=34;
    shutter=30;
elseif strcmp(file,'150808_SC1ATK45_vortexgen_1')==1
   	dir='/Users/kakani/Desktop/150808_WesternFlyer_DeepPIV/';
    start=78;
    finish=255;
    calib=1;   %pixels/cm
    shutter=60;
elseif strcmp(file,'150808_SC1ATK45_vortexgen_3')==1
   	dir='/Users/kakani/Desktop/150808_WesternFlyer_DeepPIV/';
    start=211;
    finish=770;
    calib=1;   %pixels/cm
    shutter=60;
elseif strcmp(file,'150808_SC1ATK45_vortexgen_4')==1
   	dir='/Users/kakani/Desktop/150808_WesternFlyer_DeepPIV/';
    start=415;
    finish=775;
    calib=1;   %pixels/cm
    shutter=60;
elseif strcmp(file,'151023_MVI3475_vortexgen_30mm_1')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=163;
    finish=512;
    calib=1;
    shutter=60;
elseif strcmp(file,'151023_MVI3475_vortexgen_30mm_3')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=756;
    finish=1155;
    calib=1;
    shutter=60;
elseif strcmp(file,'151023_MVI3475_vortexgen_30mm_5')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=1441;
    finish=1925;
    calib=1;
    shutter=60;
elseif strcmp(file,'151023_MVI3476_vortexgen_40mm_1')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=540;
    finish=992;
    calib=1;
    shutter=60;
elseif strcmp(file,'151023_MVI3476_vortexgen_40mm_3')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=967;
    finish=1270;
    calib=1;
    shutter=60;
elseif strcmp(file,'151023_MVI3476_vortexgen_40mm_5')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=1478;
    finish=1765;
    calib=1;
    shutter=60;
elseif strcmp(file,'151023_MVI3477_vortexgen_50mm_1')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=145;
    finish=673;
    calib=1;
    shutter=60;
elseif strcmp(file,'151023_MVI3477_vortexgen_50mm_3')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=3326;
    finish=3672;
    calib=1;
    shutter=60;
elseif strcmp(file,'151023_MVI3477_vortexgen_50mm_5')==1
   	dir='/Users/kakani/Desktop/151023_LabTest_VortexGen/clips/';
    start=1212;
    finish=1796;
    calib=1;
    shutter=60;
elseif strcmp(file,'150727_SC1ATK41_bathos_14a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=417;
    finish=458;
    calib=113;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK41_bathos_15a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=458;
    finish=506;
    calib=111;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK41_bathos_15b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=506;
    finish=552;
    calib=111;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK41_bathos_15c')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=552;
    finish=600;
    calib=111;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_14a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=748;
    finish=808;
    calib=67;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_14b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=1070;
    finish=1125;
    calib=67;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_15a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=279;
    finish=333;
    calib=67;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_15b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=333;
    finish=384;
    calib=67;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_15c')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=384;
    finish=437;
    calib=67;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_15d')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=652;
    finish=702;
    calib=67;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_15e')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=702;
    finish=754;
    calib=67;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_17a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=222;
    finish=277;
    calib=63;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150808_SC1ATK45_Batho_8a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150808_WesternFlyer_DeepPIV/';
    start=263;
    finish=425;
    calib=68;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50_BathoStyg_10a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=1329;
    finish=1450;
    calib=66;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50+1_BathoStyg_4a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=2600;
    finish=2677;
    calib=70;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50+1_BathoStyg_4b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=2677;
    finish=2749;
    calib=70;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50+1_BathoStyg_4c')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=2749;
    finish=2828;
    calib=70;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50+1_BathoStyg_4d')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=2828;
    finish=2906;
    calib=70;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50+1_BathoStyg_4e')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=2906;
    finish=2986;
    calib=70;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50+1_BathoStyg_5a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=1318;
    finish=1411;
    calib=116;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50+1_BathoStyg_5b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=1411;
    finish=1507;
    calib=116;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150811_SC1ATK50+1_BathoStyg_5c')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150811_WesternFlyer_DeepPIV/';
    start=1507;
    finish=1601;
    calib=116;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_3a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=372;
    finish=435;
    calib=76;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_3b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=435;
    finish=497;
    calib=76;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_3c')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=739;
    finish=797;
    calib=76;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_8a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=1;
    finish=58;
    calib=101;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_8b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=58;
    finish=116;
    calib=101;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_8c')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=232;
    finish=293;
    calib=101;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_8d')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=293;
    finish=353;
    calib=101;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_8e')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=527;
    finish=586;
    calib=101;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_9a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=405;
    finish=466;
    calib=99;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_9b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=466;
    finish=521;
    calib=99;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_9c')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=521;
    finish=580;
    calib=99;
    fps=60;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_20a')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=549;
    finish=613;
    calib=60;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_20b')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=805;
    finish=870;
    calib=60;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_20c')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=870;
    finish=936;
    calib=60;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_20d')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=936;
    finish=996;
    calib=60;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_22a')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=489;
    finish=552;
    calib=57;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_22b')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=552;
    finish=612;
    calib=57;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_22c')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=612;
    finish=671;
    calib=57;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_22d')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=671;
    finish=734;
    calib=57;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_22e')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=734;
    finish=793;
    calib=57;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK62_Batho_22f')==1
    dir='/Volumes/DeepPIV/151120_DeepPIV_RachelCarson/';
    start=793;
    finish=855;
    calib=57;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151205_SC1ATK67+1_Batho_10a')==1
    dir='/Volumes/DeepPIV/151205_DeepPIV_WesternFlyer/';
    start=184;
    finish=221;
    calib=102;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151205_SC1ATK67+1_Batho_10b')==1
    dir='/Volumes/DeepPIV/151205_DeepPIV_WesternFlyer/';
    start=284;
    finish=309;
    calib=102;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151205_SC1ATK67+1_Batho_12a')==1
    dir='/Volumes/DeepPIV/151205_DeepPIV_WesternFlyer/';
    start=9;
    finish=72;
    calib=92;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK69+1_Batho_6a')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=35;
    finish=127;
    calib=42;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK69+1_Batho_6b')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=210;
    finish=300;
    calib=69;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK69+1_Batho_8a')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=235;
    finish=313;
    calib=62;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK69+1_Batho_8b')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=1138;
    finish=1227;
    calib=58;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK69+1_Batho_8c')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=1227;
    finish=1319;
    calib=58;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK70_Batho_6a')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=281;
    finish=346;
    calib=63;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK70_Batho_6b')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=774;
    finish=827;
    calib=63;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK70_Batho_6c')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=827;
    finish=887;
    calib=63;
    fps=30;
    shutter=fps;
elseif strcmp(file,'151206_SC1ATK70_Batho_7a')==1
    dir='/Volumes/DeepPIV/151206_DeepPIV_WesternFlyer/';
    start=36;
    finish=91;
    calib=62;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_14a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=335;
    finish=398;
    calib=124;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150813_SC1ATK52+1_Batho_14b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150813_WesternFlyer_DeepPIV/';
    start=398;
    finish=466;
    calib=124;
    fps=30;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_27a')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=2028;
    finish=2133;
    calib=50;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_27b')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=2133;
    finish=2232;
    calib=50;
    fps=60;
    shutter=fps;
elseif strcmp(file,'150727_SC1ATK42_bathos_27c')==1
    dir='/Volumes/HD1/Users/kakani/Desktop/150727_RachelCarson_DeepPIV/';
    start=2232;
    finish=2334;
    calib=50;
    fps=60;
    shutter=fps;
elseif strcmp(file,'151120_SC1ATK58_VortexGen_best')==1
    dir='/Users/kakani/Desktop/151120_RachelCarson_DeepPIV/';
    start=1;
    finish=679;
    calib=67;
    fps=60;
    shutter=fps;
else
    dir='';
    start=1;
    finish=1;
    calib=1;
    shutter=1;
end