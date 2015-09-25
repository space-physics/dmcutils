
%% quickly try to read CMOS data
% only reads a single frame, maybe not that useful. Just use readCMOSdata.m

clear

datadir = '~/data/CMOS/110301_1009/';

path = '110301_1009';

yy = 2000 + str2num(path(1:2));
mm = str2num(path(3:4));
dd = str2num(path(5:6));
hh = str2num(path(8:9));
mn = str2num(path(10:11));
ss = 0;
if length(path) > 11,
    second = 30;
end

starttime = datenum(yy,mm,dd,hh,mn,ss);

d = dir([datadir '*.dat']);

imsize = [2544 2160];
darkfn = '../flats_and_darks/dark_1s_fullframe_280MHz_hix30.dat';
flatfn = '../flats_and_darks/flat_5ms_fullframe_280MHz_hix30_diffuser.dat';
framesize = 'full';

%% process flat and dark
[flatnorm,dark] = flatdark(flatfn,darkfn);
%% screen to cut off corners 
% is this just setting to zero regions outside of the optical field presented by
% the lens?
screen = cornerzero(imsize);
%%

fac = 10;       % multiplying factor, to get numbers into 16-bit range

% read process, taken from readCMOSdata --------------

datafile = [datadir d(250).name];
data1 = readCMOSdata(datafile,imsize);

% de-noising! very slow if I denoise then bin; faster if I bin
% first, but I think it's better to denoise the original data.

[thr,sorh,keepapp] = ddencmp('den','wv',data1);
xd = wdencmp('gbl',data1,'sym8',2,thr,sorh,keepapp);

data1a = (double(data1) - dark) ./ flat1;
data1b = (double(data1) - dark) .* screen ./ flat1;

data2 = (xd - dark) .* screen ./ flat1;

data3 = uint16(data2*fac);


%% plot it

close all;

h1 = figure(1);
set(h1,'position',[200 200 800 600]);
ax = axes;
imagesc(data2,'parent',ax); axis(ax,'xy');
xlabel(ax,'Pixels x');
ylabel(ax,'Pixels y');
title(ax,'Denoised, calibrated, masked data');

c = colormap(hot);
cb = [c(:,2), c(:,1), c(:,3)];      % blue version!
c2 = brighten(cb,0.5);
colormap(ax,c2);
caxis(ax,[0 300]);

%%

set(ax,'ylim',[2480 2542]);
