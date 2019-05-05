#!/bin/bash

BASEPATH=/geodata/ch.swisstopo.lk200.grau/
OUTPATH=/geodata/output/ch.swisstopo.lk200.grau/

gdal_translate $BASEPATH/lk200_grau.vrt $OUTPATH/ch.swisstopo.lk200.grau_tmp.tif -a_srs EPSG:2056 -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES'

gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk200.grau_tmp.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk200.grau_tmp.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk200.grau_tmp.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk200.grau_tmp.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk200.grau_tmp.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk200.grau_tmp.tif.ovr.ovr.ovr.ovr.ovr 2

gdal_translate $OUTPATH/ch.swisstopo.lk200.grau_tmp.tif $OUTPATH/ch.swisstopo.lk200.grau.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES'

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.swisstopo.lk200.grau -co TILE_FORMAT=PNG_JPEG -of GPKG $OUTPATH/ch.swisstopo.lk200.grau.tif $OUTPATH/ch.swisstopo.lk200.grau.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.swisstopo.lk200.grau -r average $OUTPATH/ch.swisstopo.lk200.grau.gpkg 2 4 8 16 32 64 128 256
