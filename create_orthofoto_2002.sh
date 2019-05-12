#!/bin/bash

BASEPATH=/geodata/ch.so.agi.orthofoto_2002.rgb/
OUTPATH=/geodata/output/ch.so.agi.orthofoto_2002.rgb/

gdalbuildvrt $OUTPATH/ch.so.agi.orthofoto_2002.rgb.vrt $BASEPATH/*50cm.tif
gdal_translate $OUTPATH/ch.so.agi.orthofoto_2002.rgb.vrt $OUTPATH/ch.so.agi.orthofoto_2002.rgb_tmp.tif -a_srs EPSG:2056 -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.orthofoto_2002.rgb_tmp.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.orthofoto_2002.rgb_tmp.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.orthofoto_2002.rgb_tmp.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.orthofoto_2002.rgb_tmp.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.orthofoto_2002.rgb_tmp.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.orthofoto_2002.rgb_tmp.tif.ovr.ovr.ovr.ovr.ovr 2

gdal_translate $OUTPATH/ch.so.agi.orthofoto_2002.rgb_tmp.tif $OUTPATH/ch.so.agi.orthofoto_2002.rgb.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto_2002.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG $OUTPATH/ch.so.agi.orthofoto_2002.rgb.tif $OUTPATH/ch.so.agi.orthofoto_2002.rgb.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto_2002.rgb -r average $OUTPATH/ch.so.agi.orthofoto_2002.rgb.gpkg 2 4 8 16 32 64 128 256
