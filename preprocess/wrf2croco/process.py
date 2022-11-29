'''
 # @ Author: lucas
 # @ Create Time: 2022-11-07 10:33:11
 # @ Modified by: lucas
 # @ Modified time: 2022-11-07 10:33:16
 # @ Description:
 '''

# ---------------------------------------------------------------------------- #
# ---------------------------------- Imports --------------------------------- #
# ---------------------------------------------------------------------------- #

import os
from glob import glob
from deffs import *
from shutil import which
import xarray as xr
import pandas as pd
# ---------------------------------------------------------------------------- #

def single_wrfout_to_cf(filein, fileout, wrf2cf_nclpath):
    """
    Function for running wrfout_to_cf.ncl script for a single netcdf file.

    Args:
        filein (str): path to input file.
        fileout (str): path to output file
        wrf2cf_nclpath (str): path to "wrfout_to_cf.ncl" script.
        Defaults to wrf2cf_nclpath in deffs.py.

    Raises:
        RuntimeError: If ncl is not installed.
        RuntimeError: If wrfout_to_cf.ncl script doesnt exists.
        RuntimeError: If input netcdf file doesnts exists.
    """
    #Check if ncl is installed...
    if which('ncl') == None:
        raise RuntimeError('NCAR Command Language (NCL) is not installed!')
    #Check if wrfout_to_cf.ncl script exists in the specified path...
    if not os.path.isfile(wrf2cf_nclpath):
        raise RuntimeError('Cannot access "'+wrf2cf_nclpath+'": No such file!')
    

    if not os.path.isfile(filein):
        raise RuntimeError('Cannot access "'+filein+'": No such file!')
    #Create shell command
    command = 'ncl \'file_in="'+filein+'"\' '+'\'file_out="'
    command = command+fileout+'"\' '+wrf2cf_nclpath
    print('Command: \"'+command+'\"\n')
    #Execute
    os.system(command)
    print('\n')

    return 

def wrfout_to_cf(wrf_files, outputdir, wrf2cf_nclpath):
    """
    Function for transforming a single or multiple wrf output files
    to a new CF based netCDF file.

    Args:
        wrf_files (str, optional): path to native wrfout file or a 
        glob-like expression to wrfout native files.
        
        outputdir (str, optional): path to output directory.
        
        wrf2cf_nclpath (str): path to "wrfout_to_cf.ncl" script.
    """
    print('Transforming wrfout to cf convention output ...')
    print('Looping over files...\n')
    # Check if WRFCF directory exists in output directory
    # if not then create it for storing CF-Convention wrf outputs
    if not os.path.isdir(outputdir+'WRFCF'):
        os.mkdir(outputdir+'WRFCF')
        
    # Check if input files are in a glob like fashion or it is
    # a single file
    if "*" in wrf_files:
        files = glob(wrf_files)
        print('Files: {')
        print(*files, sep='\n')
        print('}\n')
        for f in files:
            output = f.split("/")[-1].replace('wrfout','wrfcf')
            output = outputdir+'WRFCF/'+output+'.nc'
            if not os.path.isfile(output):
                #Transform to CF if file doesnt exists
                single_wrfout_to_cf(f,
                                    output,
                                    wrf2cf_nclpath)
            else:
                print('File "'+output+'" already created!!')
    else:
        print('Files: {')
        print(wrf_files)
        print('}')
        output = wrf_files.split("/")[-1].replace('wrfout','wrfcf')
        output = outputdir+'WRFCF/'+output+'.nc'
        if not os.path.isfile(output):
            #Transform to CF if file doesnt exists
            single_wrfout_to_cf(wrffilespath,
                                output,
                                wrf2cf_nclpath)
        else:
            print('File "'+output+'" already created!')
    return

def load_wrf(path, preprocess_CF=False, **kwargs):
    """ 
    Load a wrf model output and adjust it in xarray style
    Other arguments are passed to xarray.open_dataset() function
    Args:
        path (str): path to netcdf file

    Returns:
        XDataSet: xarray loaded dataset
    """
    if preprocess_CF:
        data = xr.open_dataset(path, engine='netcdf4', **kwargs)
        data['precip'] = data['precip_g']+data['precip_c']
    else:
        data = xr.open_dataset(path, engine='netcdf4', **kwargs)
        p = data.attrs['SIMULATION_START_DATE']
        data = data.sortby('XTIME')
        data = data.assign_coords({'west_east':data.XLONG.values[0,:],
                                'south_north':data.XLAT.values[:,0]})
        data = data.rename({'south_north':'lat',
                            'west_east':'lon',
                            'XTIME':'leadtime'})
        data.coords['time'] = pd.to_datetime(p,
                                             format="%Y-%m-%d_%H:%M:%S")
        data = data.sortby('lat').sortby('lon')
    return data
