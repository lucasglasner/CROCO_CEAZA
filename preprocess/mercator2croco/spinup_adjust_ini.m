clear all
close all
%
DIRDATA='../../CEAZAMAR-H/CROCO_FILES/';
addpath(['../../CEAZAMAR-H/']);
start
crocotools_param
name='ceazamar_ini_mercator_';
%
%Dateref=datenum('1958-01-01 00:00:00','yyyy-mm-dd HH:MM:SS');
TIME_INIT=datenum('1900-01-01 00:00:00','yyyy-mm-dd HH:MM:SS');
Yiniref=2020;%a??o de referencia para replicar en el spinup
Ymin=2018;  
Ymax=2018;
Mmin=1;
Mmax=1;

for year=Ymin:Ymax
    for mes= Mmin:Mmax
        namefileo=[DIRDATA name 'Y' num2str(Yiniref) 'M' num2str(mes, Mth_format) '.nc'];
        namefiled=[DIRDATA name 'Y' num2str(year) 'M' num2str(mes, Mth_format) '.nc'];
        display(['Creating ', namefiled, '...'])
        %***
        system(['cp ' namefileo ' ' namefiled]);
        scrum_time=ncread(namefileo,'scrum_time')-(Yiniref-year)*365*3600*24;
        ocean_time=ncread(namefileo,'ocean_time')-(Yiniref-year)*365*3600*24;
        display(scrum_time/3600/24)
        ncwrite(namefiled,'scrum_time',scrum_time);
        ncwrite(namefiled,'ocean_time',ocean_time);
    end
end


