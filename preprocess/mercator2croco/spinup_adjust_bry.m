clear all
close all

%
DIRDATA='../../CEAZAMAR-H/CROCO_FILES/';
addpath(['../../CEAZAMAR-H/']);
start
crocotools_param
name='ceazamar_bry_mercator_';
%
%Dateref=datenum('1958-01-01 00:00:00','yyyy-mm-dd HH:MM:SS');
Dateref=datenum('1900-01-01 00:00:00','yyyy-mm-dd HH:MM:SS');
Ybryref=2020;%a??o de referencia para replicar en el spinup
Ymin=2018;
Ymax=2019;
Mmin=1;
Mmax=12;

for year=Ymin:Ymax
  for mes= Mmin:Mmax
    namefileo=[DIRDATA name 'Y' num2str(Ybryref) 'M' num2str(mes, Mth_format) '.nc'];
    namefiled=[DIRDATA name 'Y' num2str(year) 'M' num2str(mes, Mth_format) '.nc'];
    display(['Creating ', namefiled, '...']);
    system(['cp ' namefileo ' ' namefiled]);
    
    nc=netcdf(namefileo,'r');
    
    bry_time  = nc{'bry_time'}(:)-(Ybryref-year)*365;

    close(nc)
    nw=netcdf(namefiled,'write');
    nw{'bry_time'}(:)  = bry_time;
    nw{'tclm_time'}(:) = bry_time;
    nw{'temp_time'}(:) = bry_time;
    nw{'sclm_time'}(:) = bry_time;
    nw{'salt_time'}(:) = bry_time;
    nw{'uclm_time'}(:) = bry_time;
    nw{'vclm_time'}(:) = bry_time;
    nw{'v2d_time'}(:)  = bry_time;
    nw{'v3d_time'}(:)  = bry_time;
    nw{'ssh_time'}(:)  = bry_time;
    nw{'zeta_time'}(:) = bry_time;
    close(nw)
  end
end


