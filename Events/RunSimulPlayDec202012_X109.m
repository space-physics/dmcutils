%RunSimulPlay

clear 
close all
clc


%rotate CCD data 90 degrees clockwise?
ccd.rot90cw = true;

%rotate CMOS data 90 degrees clockwise?
cmos.rot90cw = true;

% data number scaling
ccd.minVal = 1000;
ccd.maxVal = 3000;

cmos.minVal = 0;
cmos.maxVal = 255;

ccd.stem = '/media/small/BigData/Imaging/2012-12-20/CCD/2012-12-20T22-48-34_frames_317600-1-339300.tif';
ccd.kineticSec = 0.02711; ccd.startUT = datenum([2012 12 21 1 12 04]);
cmos.stem = '/media/small/BigData/Imaging/2012-12-20/Neo/X109-8bitogv.tif';
cmos.kineticSec = 0.03030303; cmos.startUT =datenum([2012 12 21 1 19 17]);

both.pbFPS = 20;
both.simKineticSec = 0.25; %skips frames to speedup playback
both.reqStartUT = nan; 
both.reqStopUT = nan;
[ccd2,cmos2,both2]=simulPlay(ccd,cmos,both)