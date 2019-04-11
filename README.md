# singlelayertiff
From VRT to BigTIFF.


## Deflate

Bestehendes VRT (warum warp und nicht translate?):
```
export GDAL_CACHEMAX=8192
gdalwarp -tr 0.125 0.125 -of GTiff  -co 'BIGTIFF=YES' -co 'TILED=YES' -co 'PROFILE=GeoTIFF'  -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -wo NUM_THREADS=ALL_CPUS -s_srs epsg:2056 -t_srs epsg:2056 orthofoto_2017_rgb_12_5cm.vrt ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif
```

export GDAL_CACHEMAX=4096

(
Sicherheitshalber (wegen Grösse):
```
gdal_translate ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate_tmp.tif ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
```
Bleibt gleich gross.
)

Overviews. Gemäss Even Rouault am besten via externe Overviews (aufgrund der Grösse):
```
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2

gdal_translate ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate.tif ../singletiff/2017/orthofoto_2017_rgb_12_5cm_deflate_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
```

GeoPackage:
```
gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto_2017.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG orthofoto_2017_rgb_12_5cm_deflate_with_ovr.tif orthofoto_2017_rgb_12_5cm_deflate.gpkg

gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto_2017.rgb -r average orthofoto_2017_rgb_12_5cm_deflate.gpkg 2 4 8 16 32 64 128 256

```



## JPEG-in-TIFF+internal_mask_band


```
gdal_translate orthofoto_2017_rgb_12_5cm.vrt ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif -b 1 -b 2 -b 3 -mask 4 -co TILED=YES -co COMPRESS=JPEG --config GDAL_TIFF_INTERNAL_MASK YES -co PHOTOMETRIC=YCBCR
```

Overviews:
```
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2

gdal_translate ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' --config GDAL_TIFF_INTERNAL_MASK YES -b 1 -b 2 -b 3 -mask 4 -co 'COMPRESS=JPEG' -co 'PHOTOMETRIC=YCBCR' -co 'TILED=YES' -co 'BIGTIFF=YES'
```


gdalwarp -tr 0.25 0.25 -of GTiff  -co 'BIGTIFF=YES' -co 'TILED=YES' -co 'PROFILE=GeoTIFF'  -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=JPEG' -co 'PHOTOMETRIC=YCBCR' --config GDAL_TIFF_INTERNAL_MASK YES -b 1 -b 2 -b 3 -mask 4 -wo NUM_THREADS=ALL_CPUS -s_srs epsg:2056 -t_srs epsg:2056 orthofoto_2017_rgb_12_5cm_jpeg.tif ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr



## Packbits

```
gdal_translate orthofoto_2017_rgb_12_5cm.vrt ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif -co TILED=YES -co COMPRESS=PACKBITS -co BIGTIFF=YES
```

Overviews:
```
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2

gdal_translate ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits.tif ../singletiff/2017/orthofoto_2017_rgb_12_5cm_packbits_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=PACKBITS' -co 'TILED=YES' -co 'BIGTIFF=YES'

```

## 2015 (really large):


```
export GDAL_CACHEMAX=4096
gdal_translate orthofoto_2015_rgb_12_5cm.vrt ../singletiff/2015/orthofoto_2015_rgb_12_5cm_packbits.tif -co TILED=YES -co COMPRESS=PACKBITS -co BIGTIFF=YES
```

Schon fast zu gross für SSD, darum trotzdem deflate (zum testen predictor 1):
```
gdal_translate ../singletiff/2015/orthofoto_2015_rgb_12_5cm_packbits.tif ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=1 -co BIGTIFF=YES

gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2

gdal_translate ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co PREDICTOR=1 -co 'TILED=YES' -co 'BIGTIFF=YES'
```

Vergleich Predictor 2:
```
gdal_translate orthofoto_2015_rgb_12_5cm_deflate.tif orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=2 -co BIGTIFF=YES

gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2

gdal_translate orthofoto_2015_rgb_12_5cm_deflate_predictor2.tif orthofoto_2015_rgb_12_5cm_deflate_predictor2_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co PREDICTOR=2 -co 'TILED=YES' -co 'BIGTIFF=YES'

```




```

gdal_translate orthofoto_2015_rgb_12_5cm_deflate_with_ovr.tif orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif -b 1 -b 2 -b 3 -co 'COMPRESS=JPEG' -co PHOTOMETRIC=YCBCR -co 'TILED=YES' -co 'BIGTIFF=YES'

gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif 2
gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR -ro -r average orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2

gdal_translate orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2.tif orthofoto_2015_rgb_12_5cm_jpeg_with_ovr_v2_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=JPEG' -co PHOTOMETRIC=YCBCR -co 'TILED=YES' -co 'BIGTIFF=YES'
```


GeoPackage:
```
gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto_2015.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG orthofoto_2015_rgb_12_5cm_deflate.tif orthofoto_2015_rgb_12_5cm_deflate.gpkg

gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto_2015.rgb -r average orthofoto_2015_rgb_12_5cm_deflate.gpkg 2 4 8 16 32 64 128 256
```

## 2016

```
gdal_translate orthofoto_2016_rgb_12_5cm.vrt ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=2 -co BIGTIFF=YES

gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE -ro -r average ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2

gdal_translate ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate.tif ../singletiff/2016/orthofoto_2016_rgb_12_5cm_deflate_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co PREDICTOR=2 -co 'TILED=YES' -co 'BIGTIFF=YES'
```


(
Predictor=2:
```
gdal_translate orthofoto_2016_rgb_12_5cm_deflate.tif orthofoto_2016_rgb_12_5cm_deflate_predictor2.tif -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=2 -co BIGTIFF=YES

gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average orthofoto_2016_rgb_12_5cm_deflate.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2


gdal_translate orthofoto_2016_rgb_12_5cm_deflate.tif orthofoto_2016_rgb_12_5cm_deflate_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co PREDICTOR=2 -co 'TILED=YES' -co 'BIGTIFF=YES'
```
)

GeoPackage:
```
gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto_2016.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG orthofoto_2016_rgb_12_5cm_deflate.tif orthofoto_2016_rgb_12_5cm_deflate.gpkg

gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto_2016.rgb -r average orthofoto_2016_rgb_12_5cm_deflate.gpkg 2 4 8 16 32 64 128 256
```





## Links

* http://www.digital-geography.com/geotiff-compression-comparison/


