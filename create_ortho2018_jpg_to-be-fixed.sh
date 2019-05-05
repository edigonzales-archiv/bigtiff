#!/bin/bash

BASEPATH=/geodata/swisstopo/SWISSIMAGE_LEVEL3/10cm/
OUTPATH=/geodata/geodata/ch.swisstopo.orthofoto_2018.rgb.jpg

for FILE in ${BASEPATH}*.tif
do
  echo $FILE
  BASENAME=$(basename $FILE .tif)
  OUTFILE=${OUTPATH}/${BASENAME}.tif
  
  echo "Processing: ${BASENAME}.tif"
  if [ -f $OUTFILE ] #skip if exists
  then
    echo "Skipping: $OUTFILE"
  else    
    gdal_translate -of GTiff -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -co 'COMPRESS=JPEG' -co 'PHOTOMETRIC=YCBCR'  -co 'BLOCKXSIZE=256' -co 'BLOCKYSIZE=256' -a_srs EPSG:2056 $FILE $OUTFILE
    gdaladdo -r average --config COMPRESS_OVERVIEW DEFLATE --config BLOCKXSIZE 256 --config BLOCKYSIZE 256 $OUTFILE 2 4 8 16 32 64 128
  fi
done

#/usr/local/gdal_master/bin/gdalbuildvrt -addalpha lk10-farbig.vrt *.tif
#/usr/local/gdal_master/bin/gdalwarp -tr 5.0 5.0 -of GTiff -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -co 'COMPRESS=DEFLATE' -co 'BLOCKXSIZE=256' -co 'BLOCKYSIZE=256' -wo NUM_THREADS=ALL_CPUS -s_srs epsg:2056 -t_srs epsg:2056 lk10-farbig.vrt lk10-farbig-5m.tif
#/usr/local/gdal_master/bin/gdaladdo -r average --config COMPRESS_OVERVIEW DEFLATE --config BLOCKXSIZE 256 --config BLOCKXSIZE 256 lk10-farbig-5m.tif 2 4 8 16 32 64 128

# relativeToVrt no working w/ this devel version
#/usr/bin/gdalbuildvrt -addalpha ${OUTPATH}/lk10-grau.vrt ${OUTPATH}*.tif
#/usr/local/gdal_master/bin/gdalwarp -tr 5.0 5.0 -of GTiff -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -co 'COMPRESS=DEFLATE' -co 'BLOCKXSIZE=256' -co 'BLOCKYSIZE=256' -wo NUM_THREADS=ALL_CPUS -s_srs epsg:2056 -t_srs epsg:2056 ${OUTPATH}.vrt ${OUTPATH}/lk10-grau-5m.tif
#/usr/local/gdal/gdal-dev/bin/gdaladdo -r nearest --config COMPRESS_OVERVIEW DEFLATE --config GDAL_TIFF_OVR_BLOCKSIZE 512 ${OUTPATH}/lk10-grau-5m.tif 2 4 8 16 32 64 128"
