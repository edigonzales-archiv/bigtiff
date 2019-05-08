#!/bin/bash

BASEPATH=/geodata/ch.bl.agi.orthofoto_2015.rgb/
OUTPATH=/geodata/output/ch.bl.agi.orthofoto_2015.rgb/

gdalbuildvrt -addalpha $OUTPATH/orthofoto_2015_rgb.vrt $BASEPATH/*.tif
gdal_translate $OUTPATH/orthofoto_2015_rgb.vrt $OUTPATH/ch.bl.agi.orthofoto_2015.rgb_tmp.tif -a_srs EPSG:2056 -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.orthofoto_2015.rgb_tmp.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.orthofoto_2015.rgb_tmp.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.orthofoto_2015.rgb_tmp.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.orthofoto_2015.rgb_tmp.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.orthofoto_2015.rgb_tmp.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average $OUTPATH/ch.bl.agi.orthofoto_2015.rgb_tmp.tif.ovr.ovr.ovr.ovr.ovr 2

gdal_translate $OUTPATH/ch.bl.agi.orthofoto_2015.rgb_tmp.tif $OUTPATH/ch.bl.agi.orthofoto_2015.rgb.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.bl.agi.orthofoto_2015.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG $OUTPATH/ch.bl.agi.orthofoto_2015.rgb.tif $OUTPATH/ch.bl.agi.orthofoto_2015.rgb.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.bl.agi.orthofoto_2015.rgb -r average $OUTPATH/ch.bl.agi.orthofoto_2015.rgb.gpkg 2 4 8 16 32 64 128 256
