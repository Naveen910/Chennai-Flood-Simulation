#!/bin/bash

D:\ABN\chennai\chennai-water-log\data\basemap

# Define the local directory and file paths (use forward slashes for Git Bash)
BASE_DIR="/d/ABN/chennai/chennai-water-log/data/basemap/"
PBF_FILE="$BASE_DIR/tamil-naidu.osm.pbf"
PROCESS_FILE="$BASE_DIR/process-openmaptiles.lua"
CONFIG_FILE="$BASE_DIR/config-openmaptiles.json"
OUTPUT_FILE="$BASE_DIR/basemap.pmtiles"

# Download the OpenStreetMap PBF file for Tamil Nadu
wget -nc https://download.geofabrik.de/asia/india/tamil-nadu-latest.osm.pbf -O "/d/ABN/chennai/chennai-water-log/data/basemap/chennai.osm.pbf"


# Run the tilemaker Docker container with explicit volume mapping
docker run -it --rm --pull always \
  -v "/d/ABN/chennai/chennai-water-log/data/basemap:/data" \
  ghcr.io/systemed/tilemaker:master \
  /data/chennai.osm.pbf \
  --output /data/basemap.pmtiles \
  --bbox 79.9,12.9,80.4,13.3 \
  --process /data/process-openmaptiles.lua \
  --config /data/config-openmaptiles.json \
  --skip-integrity

#for windows
  docker run -it --rm --pull always -v "D:\ABN\chennai\chennai-water-log\data\basemap:/data" ghcr.io/systemed/tilemaker:master /data/chennai.osm.pbf --output /data/basemap.pmtiles --bbox 79.9,12.9,80.4,13.3 --process /data/process-openmaptiles.lua --config /data/config-openmaptiles.json --skip-integrity

