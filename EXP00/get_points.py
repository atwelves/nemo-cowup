import xarray as xr
import numpy as np

ds = xr.open_dataset("temp_file.nc")
ds = ds.isel(x=600).isel(y=250)
ds.to_netcdf('output.nc')
