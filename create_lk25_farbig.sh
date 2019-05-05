#!/bin/bash

BASEPATH=/geodata/ch.swisstopo.lk25.farbig/
OUTPATH=/geodata/output/ch.swisstopo.lk25.farbig/

gdalbuildvrt -addalpha $OUTPATH/lk25_farbig.vrt $BASEPATH/*.tif
gdal_translate $OUTPATH/lk25_farbig.vrt $OUTPATH/ch.swisstopo.lk25.farbig_tmp.tif -a_srs EPSG:2056 -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk25.farbig_tmp.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk25.farbig_tmp.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk25.farbig_tmp.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk25.farbig_tmp.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk25.farbig_tmp.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.swisstopo.lk25.farbig_tmp.tif.ovr.ovr.ovr.ovr.ovr 2

gdal_translate $OUTPATH/ch.swisstopo.lk25.farbig_tmp.tif $OUTPATH/ch.swisstopo.lk25.farbig.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdal_translate  -expand rgba --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.swisstopo.lk25.farbig -co TILE_FORMAT=PNG_JPEG -of GPKG $OUTPATH/ch.swisstopo.lk25.farbig.tif $OUTPATH/ch.swisstopo.lk25.farbig.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.swisstopo.lk25.farbig -r average $OUTPATH/ch.swisstopo.lk25.farbig.gpkg 2 4 8 16 32 64 128 256
