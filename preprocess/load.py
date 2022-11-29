'''
 # @ Author: lucas
 # @ Create Time: 2022-11-07 10:28:57
 # @ Modified by: lucas
 # @ Modified time: 2022-11-07 10:29:07
 # @ Description:
 '''



# ---------------------------------------------------------------------------- #
# ---------------------------------- Imports --------------------------------- #
# ---------------------------------------------------------------------------- #

import os
import datetime
from glob import iglob,glob
import xarray as xr
import pandas as pd

# ---------------------------------------------------------------------------- #
# ---------------------------- Load data functions --------------------------- #
# ---------------------------------------------------------------------------- #

        
def load_wrf(path, **kwargs):
    """ 
    Load a wrf model output and adjust in xarray style
    Other arguments are passed to xarray.open_dataset() function
    Args:
        path (str): path to netcdf file

    Returns:
        XDataSet: xarray loaded dataset
    """
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

def load_mercator(path, **kwargs):
    """ 
    load a mercator model output and adjust for the package to work
    other arguments are passed to xarray.open_dataset() function
    Args:
        path (str): path to netcdf file

    Returns:
        XDataSet: xarray loaded dataset
    """
    data = xr.open_dataset(path, engine='netcdf4', **kwargs)
    data = data.squeeze()
    data = data.rename({'latitude':'lat',
                        'longitude':'lon',
                        'time':'leadtime'})
    p = path.split("/")[-1].split(".")[0]
    data.coords['time'] = pd.to_datetime(p,format="%Y-%m-%d")
    return data


