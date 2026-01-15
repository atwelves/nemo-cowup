import xarray as xr
import numpy as np

#latitude  
#longitude

ds = xr.open_dataset("temp_file.nc")
mod_lats = ds.nav_lat.values
mod_lats[mod_lats<0]=np.nan
mod_lons = ds.nav_lon.values
mod_lons[mod_lons<0]=np.nan
mod_lats = np.nanmean(mod_lats,1)
mod_lons = np.nanmean(mod_lons,0)
arg_lon = np.nanargmin(np.abs(mod_lons-lon))
arg_lat = np.nanargmin(np.abs(mod_lats-lat))
ds = ds.isel(x=arg_lon).isel(y=arg_lat)
# Write to file with temporary name
ds.to_netcdf('output.nc')
