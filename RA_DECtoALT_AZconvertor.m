% RA_DECtoALT_AZconvertor.m 
% Asuagbor Asuagbor
% Mar 20 2024

% User inputs Long/Lat data that can be found from google maps
clear; clc; close all;
format long
longi = input('Type in your longitude in degrees ');
lati = input('Type in your latitude in degrees ');
longi;
lati;

% User inputs RA data that can be found from google maps
RAh = input('Type in your Right Ascension hours ');
RAm = input('Type in your Right Ascension minutes ');
RAh;
RAm;

% User inputs RA data that can be found from google maps
DECd = input('Type in your Declination degrees ');
DECm = input('Type in your Declination minutes ');
DECd;
DECm;

date = input('Type in your date in MM-DD-YYYY format ', 's');
D = day(date);
Mon = month(date);
Y = year(date);

time = input('Type in your time in HH:MM UT format ', 's');
H = hour(time);
Min = minute(time);

% This is where the units are standardized for proper calculations
if RAh >= 0
    RA = (RAh + (RAm/60)) * 15;
else
    RAh = RAh*-1;
    RA = (RAh + (RAm/60)) * 15;
    RA = RA*-1;
end

if DECd >= 0
    DEC = DECd + (DECm/60);
else
    DECd = DECd*-1;
    DEC = DECd + (DECm/60);
    DEC = DEC*-1;
end

Trutime = H + (Min/60);

% J2000 reference date system
J2000MJ = [0 31 59 90 120 151 181 212 243 273 304 334];
J2000M = J2000MJ(Mon);
J2000Y = ((Y - 2000) * 365) -1.5;
leapaccount = floor((Y - 2000) / 4);
if Mon > 2
    J2000D = D + leapaccount;
else
    J2000D = D;
end

J2000 = J2000D + J2000M + J2000Y;

% Local Siderial Time Calculation
LSTs = 100.46 + 0.985647*J2000 + longi + 15*Trutime;

LST = LSTs;
while 0 > LST || LST > 360
    if LST > 360
        LST = LST - 360;
    elseif 0 > LST
        LST = LST + 360;
    else
    end
end

% Hour Angle
HA = LST - RA;
if 0 > HA
    HA = HA + 360;
else
end

% HA and DEC to ALT and AZ
ALT = sind(DEC)*sind(lati)+cosd(DEC)*cosd(lati)*cosd(HA);
ALT = asind(ALT);
A = (sind(DEC)-sind(ALT)*sind(lati))/(cosd(ALT)*cosd(lati));
A = acosd(A);

if 0 > sind(HA)
    AZ = A;
else
    AZ = 360 - A;
end

fprintf('Altitude is %3.2f°, Azimuth is %3.15f° \n',ALT,AZ)