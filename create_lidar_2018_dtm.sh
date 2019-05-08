#!/bin/bash

BASEPATH=/geodata/ch.bl.agi.lidar_2018.dtm/
OUTPATH=/geodata/output/ch.bl.agi.lidar_2018.dtm/

gdalbuildvrt $OUTPATH/lidar_2018_dtm.vrt $BASEPATH/*0.tif
gdal_translate $OUTPATH/lidar_2018_dtm.vrt $OUTPATH/ch.bl.agi.lidar_2018.dtm_tmp.tif -a_srs EPSG:2056 -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.lidar_2018.dtm_tmp.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.lidar_2018.dtm_tmp.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.lidar_2018.dtm_tmp.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.lidar_2018.dtm_tmp.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.lidar_2018.dtm_tmp.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.lidar_2018.dtm_tmp.tif.ovr.ovr.ovr.ovr.ovr 2

gdal_translate $OUTPATH/ch.bl.agi.lidar_2018.dtm_tmp.tif $OUTPATH/ch.bl.agi.lidar_2018.dtm.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.bl.agi.lidar_2018.dtm -co TILE_FORMAT=TIFF -of GPKG $OUTPATH/ch.bl.agi.lidar_2018.dtm.tif $OUTPATH/ch.bl.agi.lidar_2018.dtm.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.bl.agi.lidar_2018.dtm -r average $OUTPATH/ch.bl.agi.lidar_2018.dtm.gpkg 2 4 8 16 32 64 128 256
