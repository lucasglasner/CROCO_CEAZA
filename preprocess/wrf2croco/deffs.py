'''
 # @ Author: lucasglasner
 # @ Create Time: 2022-11-07 10:14:00
 # @ Modified by: lucasglasner
 # @ Modified time: 2022-11-07 10:14:07
 # @ Description:
 
 '''

# ---------------------------------------------------------------------------- #
# ---------------------------------- IMPORTS --------------------------------- #
# ---------------------------------------------------------------------------- #

import re
import os
import datetime

# ---------------------------------------------------------------------------- #
# ----------------------------------- PATHS ---------------------------------- #
# ---------------------------------------------------------------------------- #    

# Path to wrfout_to_cf.ncl
wrf2cf_nclpath     = './wrfout_to_cf.ncl'  
        
# Directory with raw wrf outputs        
wrffiles_directory = './examples/c05_2022102012/'     
# Path to wrf file (Accepts glob like patterns)
wrffilespath       = wrffiles_directory + 'wrfout_d02_*'  

# Output path directory
outputdirectory    = './outputs/'          

# ---------------------------------------------------------------------------- #
# ---------------------------- CHANGE DICTIONARIES --------------------------- #
# ---------------------------------------------------------------------------- #

# Change variable name dictionary (table)
names_dict      = {'T_2m':'tair',                                                   
                   'rh_2m':'rhum',
                   'u_10m_tr':'uwnd',
                   'v_10m_tr':'vwnd',
                   'ws_10m':'wspd',
                   'precip':'prate',
                   'SW_d':'radsw',
                   'LW_d':'radlw_in'}

# Change variable unit name dictionary (table)
unitsnames_dict = {'degC':'Celsius',
                   'percent':'fraction',
                   'm s-1':'m/s',
                   'm s-1':'m/s',
                   'm s-1':'m s-1',
                   'mm':'cm day-1',
                   'W m-2':'Watts meter-2',
                   'W m-2':'Watts meter-2'}

# Change variable units dictionary (table)
unitscoeff_dict = {'tair':1.,
                   'rhum':0.01,
                   'uwnd':1.,
                   'vwnd':1.,
                   'ws_10m':1.,
                   'prate':0.417,
                   'radsw':1.,
                   'radlw_in':1.}