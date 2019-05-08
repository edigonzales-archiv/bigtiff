#!/bin/bash

BASEPATH=/geodata/ch.so.agi.lidar_2014.dom/
OUTPATH=/geodata/output/ch.so.agi.lidar_2014.dom/

gdalbuildvrt $OUTPATH/lidar_2014_dom.vrt $BASEPATH/*_50cm.tif
gdal_translate $OUTPATH/lidar_2014_dom.vrt $OUTPATH/ch.so.agi.lidar_2014.dom_tmp.tif -a_srs EPSG:2056 -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.lidar_2014.dom_tmp.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.lidar_2014.dom_tmp.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.lidar_2014.dom_tmp.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.lidar_2014.dom_tmp.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.lidar_2014.dom_tmp.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.agi.lidar_2014.dom_tmp.tif.ovr.ovr.ovr.ovr.ovr 2

gdal_translate $OUTPATH/ch.so.agi.lidar_2014.dom_tmp.tif $OUTPATH/ch.so.agi.lidar_2014.dom.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.lidar_2014.dom -co TILE_FORMAT=TIFF -of GPKG $OUTPATH/ch.so.agi.lidar_2014.dom.tif $OUTPATH/ch.so.agi.lidar_2014.dom.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.lidar_2014.dom -r average $OUTPATH/ch.so.agi.lidar_2014.dom.gpkg 2 4 8 16 32 64 128 256
