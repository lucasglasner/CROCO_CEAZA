clear all
close all

%
DIRDATA='../../CEAZAMAR-H/CROCO_FILES/';
addpath(['../../CEAZAMAR-H/']);
start
crocotools_param
name='ceazamar_blk_ERA5_';
%
TIME_INIT=datenum('1900-01-01 00:00:00','yyyy-mm-dd HH:MM:SS');
Yblkref=2020;%a??o de referencia para replicar en el spinup
Ymin=2018;  
Ymax=2019;
Mmin=1;
Mmax=12;

for year=Ymin:Ymax
    for mes= Mmin:Mmax
        
        namefileo=[DIRDATA name 'Y' num2str(Yblkref) 'M' num2str(mes, Mth_format) '.nc'];
        namefiled=[DIRDATA name 'Y' num2str(year) 'M' num2str(mes, Mth_format) '.nc'];
        display(['Creating ', namefiled, '...'])
        system(['cp ' namefileo ' ' namefiled]);
        
        nc=netcdf(namefileo,'r');
        
        blk_time=nc{'bulk_time'}(:)-(Yblkref-year)*365;
        close(nc)
        nw=netcdf(namefiled,'write');
        % blk_time=nc{'bulk_time'}(:);
        
        nw{'bulk_time'}(:)=blk_time;
        close(nw)
    end
end


% TIME_INIT=datenum('1958-01-01 00:00:00','yyyy-mm-dd HH:MM:SS');
% 
% %
% %Dateref=datenum('1958-01-01 00:00:00','yyyy-mm-dd HH:MM:SS');
% Yblkref=2008;%a??o de referencia para replicar en el spinup
% Ymin=2009 ;
% Ymax=2017;
% Mmin=1;
% Mmax=12;
% 
% for year=Ymin:Ymax
%     diasE=datenum([num2str(year) '-01-01 00:00:00'],'yyyy-mm-dd HH:MM:SS')-datenum([num2str(Yblkref) '-01-01 00:00:00'],'yyyy-mm-dd HH:MM:SS');
% 
%     for mes= Mmin:Mmax
%          namefileo=[DIRDATAO name 'Y' num2str(Yblkref) 'M' num2str(mes) '.nc'];
%          namefiled=[DIRDATA name 'Y' num2str(year) 'M' num2str(mes) '.nc'];
% %         %***
%           system(['cp ' namefileo ' ' namefiled]);
%           blk_time=ncread(namefileo,'bulk_time')+diasE;
%           ncwrite(namefiled,'bulk_time',blk_time);
%           datestr(blk_time-diasE+TIME_INIT)
%           disp('nuevo')
%           datestr(blk_time+TIME_INIT)
%     end
% end
% 
% 
