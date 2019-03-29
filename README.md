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


## JPEG-in-TIFF+internal_mask_band


```
gdal_translate orthofoto_2017_rgb_12_5cm.vrt ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif -b 1 -b 2 -b 3 -mask 4 -co TILED=YES -co COMPRESS=JPEG --config GDAL_TIFF_INTERNAL_MASK YES -co PHOTOMETRIC=YCBCR
```

Overviews:
```
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config GDAL_TIFF_INTERNAL_MASK YES -ro -r average ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2

gdal_translate ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg.tif ../singletiff/2017/orthofoto_2017_rgb_12_5cm_jpeg_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' --config GDAL_TIFF_INTERNAL_MASK YES -co 'COMPRESS=JPEG' -co 'PHOTOMETRIC=YCBCR' -co 'TILED=YES' -co 'BIGTIFF=YES'
```


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

Schon fast zu gross für SDD:
```
gdal_translate ../singletiff/2015/orthofoto_2015_rgb_12_5cm_packbits.tif ../singletiff/2015/orthofoto_2015_rgb_12_5cm_deflate.tif -co TILED=YES -co COMPRESS=DEFLATE -co PREDICTOR=1 -co BIGTIFF=YES
```




## Links

* http://www.digital-geography.com/geotiff-compression-comparison/



