#!/bin/bash

BASEPATH=/geodata/ch.so.alw.drainagenplaene.sw_zugeschnitten/
OUTPATH=/geodata/output/ch.so.alw.drainagenplaene.sw_zugeschnitten/

#gdalbuildvrt $OUTPATH/drainagen.vrt $BASEPATH/*.tif
#gdal_translate $OUTPATH/drainagen.vrt $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten_tmp.tif -a_srs EPSG:2056 -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

#gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten_tmp.tif 2
#gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten_tmp.tif.ovr 2
#gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten_tmp.tif.ovr.ovr 2
#gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten_tmp.tif.ovr.ovr.ovr 2
#gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten_tmp.tif.ovr.ovr.ovr.ovr 2
#gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten_tmp.tif.ovr.ovr.ovr.ovr.ovr 2

#gdal_translate $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten_tmp.tif $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.alw.drainagenplaene.sw_zugeschnitten -co TILE_FORMAT=AUTO -of GPKG $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten.tif $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.alw.drainagenplaene.sw_zugeschnitten -r average $OUTPATH/ch.so.alw.drainagenplaene.sw_zugeschnitten.gpkg 2 4 8 16 32 64 128 256
