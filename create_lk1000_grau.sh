#!/bin/bash

BASEPATH=/geodata/ch.swisstopo.lk1000.grau/
OUTPATH=/geodata/output/ch.swisstopo.lk1000.grau/

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.swisstopo.lk1000.grau -co TILE_FORMAT=PNG_JPEG -of GPKG $BASEPATH/ch.swisstopo.lk1000.grau.tif $OUTPATH/ch.swisstopo.lk1000.grau.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.swisstopo.lk1000.grau -r average $OUTPATH/ch.swisstopo.lk1000.grau.gpkg 2 4 8 16 32 64 128 256
