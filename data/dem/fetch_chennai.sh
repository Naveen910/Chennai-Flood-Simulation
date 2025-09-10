#!/bin/bash
set -e  # Stop on errors

# Download Copernicus DEM tiles covering Chennai
AWS_DEFAULT_REGION=eu-central-1 aws s3 cp --no-sign-request s3://copernicus-dem-30m/Copernicus_DSM_COG_10_N12_00_E079_00_DEM/Copernicus_DSM_COG_10_N12_00_E079_00_DEM.tif ./
AWS_DEFAULT_REGION=eu-central-1 aws s3 cp --no-sign-request s3://copernicus-dem-30m/Copernicus_DSM_COG_10_N13_00_E079_00_DEM/Copernicus_DSM_COG_10_N13_00_E079_00_DEM.tif ./
AWS_DEFAULT_REGION=eu-central-1 aws s3 cp --no-sign-request s3://copernicus-dem-30m/Copernicus_DSM_COG_10_N12_00_E080_00_DEM/Copernicus_DSM_COG_10_N12_00_E080_00_DEM.tif ./
AWS_DEFAULT_REGION=eu-central-1 aws s3 cp --no-sign-request s3://copernicus-dem-30m/Copernicus_DSM_COG_10_N13_00_E080_00_DEM/Copernicus_DSM_COG_10_N13_00_E080_00_DEM.tif ./

# Merge into VRT
gdalbuildvrt merged.vrt Copernicus_DSM_COG_10_*.tif

# Crop to Chennai bounding box (79.9E, 13.3N top-left; 80.4E, 12.9N bottom-right)
gdal_translate -projwin 79.9 13.3 80.4 12.9 merged.vrt chennai_dem.tif
