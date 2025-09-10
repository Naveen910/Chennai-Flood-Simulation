# Use Ubuntu as the base image
FROM ubuntu:22.04

# Install dependencies including Tippecanoe
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    git \
    wget \
    make \
    gcc \
    g++ \
    libsqlite3-dev \
    libmapnik-dev \
    && rm -rf /var/lib/apt/lists/*
    

# Build and install latest Tippecanoe
RUN git clone https://github.com/felt/tippecanoe.git \
    && cd tippecanoe \
    && make -j$(nproc) \
    && make install \
    && cd .. && rm -rf tippecanoe


# Set the working directory inside the container
WORKDIR /workspace

# Copy the script and the GeoJSON into the container
COPY generate_stream_tile.sh /workspace/
COPY stream_influence_reclass.geojson /workspace/

# Make the script executable
RUN chmod +x /workspace/generate_stream_tile.sh

# Default command to run the script
CMD ["./generate_stream_tile.sh", "stream_influence_reclass.geojson", "tiles.pmtiles"]
