#!/bin/bash

BASEPATH=/geodata/ch.swisstopo.lk500.grau/
OUTPATH=/geodata/output/ch.swisstopo.lk500.grau/

gdal_translate -expand rgb --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.swisstopo.lk500.grau -co TILE_FORMAT=PNG_JPEG -of GPKG $BASEPATH/ch.swisstopo.lk500.grau.tif $OUTPATH/ch.swisstopo.lk500.grau.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.swisstopo.lk500.grau -r average $OUTPATH/ch.swisstopo.lk500.grau.gpkg 2 4 8 16 32 64 128 256
