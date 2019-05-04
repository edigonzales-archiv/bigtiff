# bigtiff
From VRT to BigTIFF.

## Vagrant
Eventuell muss man die "synced folders" im Vagrantfile anpassen, z.B.:

```
config.vm.synced_folder "/Volumes/2TB_WD_Elements/", "/geodata"
```

## Umwandlung
Falls möglich wird neben dem BigTIFF auch eine Geopackage-Rasterdatei erzeugt, da damit viel kleinere (JPEG) Dateien mögliche sind. Bei BigTIFF muss zwingend immer ein Alpha-Kanal mitgeliefert werden, was bei JPEG nicht möglich ist. 

Im Prinzip müssten man jetzt die Originaldaten aus dem Keller holen, da die jetzt vorhandenen Orthofotos JPEG-komprimiert sind.

### ch.swisstopo.lk10.grau_relief
```
gdal_translate /geodata/Geodaten/ch.swisstopo.lk10.grau_relief/lk10_grau_relief.vrt /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.tif /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.swisstopo.lk10.grau_relief -co TILE_FORMAT=PNG_JPEG -of GPKG /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief_packbits_with_ovr.tif /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.swisstopo.lk10.grau_relief -r average ch.swisstopo.lk10.grau_relief.gpkg 2 4 8 16 32 64 128 256

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.swisstopo.lk10.grau_relief -co TILE_FORMAT=PNG -of GPKG /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief_packbits_with_ovr.tif /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.grau_relief/ch.swisstopo.lk10.grau_relief.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.swisstopo.lk10.grau_relief -r average ch.swisstopo.lk10.grau_relief.gpkg 2 4 8 16 32 64 128 256
```

### ch.swisstopo.lk10.farbig_relief
```
gdal_translate lk10_farbig_relief.vrt /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.swisstopo.lk10.farbig_relief -co TILE_FORMAT=PNG_JPEG -of GPKG /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.tif /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.swisstopo.lk10.farbig_relief -r average /geodata/Geodaten_BigTIFF/ch.swisstopo.lk10.farbig_relief/ch.swisstopo.lk10.farbig_relief.gpkg 2 4 8 16 32 64 128 256

```

### ch.so.agi.lidar_2014.dom
```
gdal_translate lidar_2014_dom_50cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.lidar_2014.dom -co TILE_FORMAT=TIFF -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.lidar_2014.dom -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom/ch.so.agi.lidar_2014.dom.gpkg 2 4 8 16 32 64 128 256

```

### ch.so.agi.lidar_2014.dom_relief
```
gdalbuildvrt -addalpha lidar_2014_dom_relief_50cm.vrt *_50cm.tif

gdal_translate /geodata/Geodaten/ch.so.agi.lidar_2014.dom_relief/lidar_2014_dom_relief_50cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

# ---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.lidar_2014.dom_relief -co TILE_FORMAT=PNG_JPEG -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.lidar_2014.dom_relief -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dom_relief/ch.so.agi.lidar_2014.dom_relief.gpkg 2 4 8 16 32 64 128 256
```

### ch.so.agi.lidar_2014.domdiff2001
```
gdal_translate /geodata/Geodaten/ch.so.agi.lidar_2014.domdiff2001/lidar_2014_domdiff2001_50cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.lidar_2014.domdiff2001 -co TILE_FORMAT=TIFF -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.lidar_2014.domdiff2001 -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.domdiff2001/ch.so.agi.lidar_2014.domdiff2001.gpkg 2 4 8 16 32 64 128 256
```


### ch.so.agi.lidar_2014.dtm
```
gdal_translate /geodata/Geodaten/ch.so.agi.lidar_2014.dtm/lidar_2014_dtm_50cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.lidar_2014.dtm -co TILE_FORMAT=TIFF -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.lidar_2014.dtm -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm/ch.so.agi.lidar_2014.dtm.gpkg 2 4 8 16 32 64 128 256

```

### ch.so.agi.lidar_2014.dtm_relief
```
gdalbuildvrt -addalpha lidar_2014_dtm_relief_50cm.vrt *_50cm.tif

gdal_translate /geodata/Geodaten/ch.so.agi.lidar_2014.dtm_relief/lidar_2014_dtm_relief_50cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.lidar_2014.dtm_relief -co TILE_FORMAT=PNG_JPEG -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.lidar_2014.dtm_relief -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.dtm_relief/ch.so.agi.lidar_2014.dtm_relief.gpkg 2 4 8 16 32 64 128 256
```

### ch.so.agi.lidar_2014.hangneigung
```
gdal_translate /geodata/Geodaten/ch.so.agi.lidar_2014.hangneigung/lidar_2014_hangneigung_50cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.lidar_2014.hangneigung -co TILE_FORMAT=TIFF -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.lidar_2014.hangneigung -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.hangneigung/ch.so.agi.lidar_2014.hangneigung.gpkg 2 4 8 16 32 64 128 256


```

### ch.so.agi.lidar_2014.ndom
```
gdal_translate /geodata/Geodaten/ch.so.agi.lidar_2014.ndom/lidar_2014_ndom_50cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.lidar_2014.ndom -co TILE_FORMAT=TIFF -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.tif /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.lidar_2014.ndom -r average /geodata/Geodaten_BigTIFF/ch.so.agi.lidar_2014.ndom/ch.so.agi.lidar_2014.ndom.gpkg 2 4 8 16 32 64 128 256
```

### ch.so.agi.orthofoto_1993.grau
```
#gdalbuildvrt -addalpha orthofoto_1993_grau_70cm.vrt *_70cm.tif

gdal_translate /geodata/Geodaten/ch.so.agi.orthofoto_1993.grau/orthofoto_1993_grau_70cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto_1993.grau -co TILE_FORMAT=PNG_JPEG -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.tif /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto_1993.grau -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_1993.grau/ch.so.agi.orthofoto_1993.grau.gpkg 2 4 8 16 32 64 128 256
```

### ch.so.agi.orthofoto_2002.rgb
```
gdal_translate /geodata/Geodaten/ch.so.agi.orthofoto_2002.rgb/orthofoto_2002_rgb_50cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---
gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto_2002.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.tif /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.gpkg
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto_2002.rgb -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2002.rgb/ch.so.agi.orthofoto_2002.rgb.gpkg 2 4 8 16 32 64 128 256
```


### ch.so.agi.orthofoto_2006.rgb
```
gdal_translate /geodata/Geodaten/ch.so.agi.orthofoto_2006.rgb/orthofoto_2006_rgb_12_5cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto_2006.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.tif /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2006.rgb/ch.so.agi.orthofoto_2006.rgb.gpkg


```


### ch.so.agi.orthofoto_2007.rgb
```
gdal_translate /geodata/Geodaten/ch.so.agi.orthofoto_2007.rgb/orthofoto_2007_rgb_12_5cm.vrt /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif.ovr.ovr.ovr.ovr.ovr.ovr.ovr.ovr 2
gdal_translate /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb_with_ovr.tif -co 'COPY_SRC_OVERVIEWS=YES' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'

# rename manually

#---

gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto_2007.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.tif /geodata/Geodaten_BigTIFF/ch.so.agi.orthofoto_2007.rgb/ch.so.agi.orthofoto_2007.rgb.gpkg


```


### ch.swisstopo.orthofoto_2018.rgb

#### Test
https://lists.osgeo.org/pipermail/gdal-dev/2014-August/039907.html

```
gdalbuildvrt -a_srs EPSG:2056 -addalpha test.vrt *.tif

gdal_translate /geodata/test/test.vrt test1.tif -co COMPRESS=JPEG -co PHOTOMETRIC=RGB -co TILED=YES -co ALPHA=YES -co INTERLEAVE=BAND
gdaladdo /geodata/test/test1.tif -r average 2 4 8 16 32 64


gdal_translate /geodata/test/test.vrt test2.tif -b 1 -b 2 -b 3 -mask 4 -co TILED=YES -co COMPRESS=JPEG  -co PHOTOMETRIC=YCBCR --config GDAL_TIFF_INTERNAL_MASK YES
#gdaladdo /geodata/test/test2.tif --config GDAL_TIFF_INTERNAL_MASK YES -r average 2 4 8 16 32 64

gdaladdo --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR --config GDAL_TIFF_INTERNAL_MASK YES -ro /geodata/test/test2.tif  -r average 2
gdal_translate /geodata/test/test2.tif test2_with_ovr.tif -b 1 -b 2 -b 3 -mask 4 -co TILED=YES -co COMPRESS=JPEG  -co PHOTOMETRIC=YCBCR -co 'COPY_SRC_OVERVIEWS=YES' --config GDAL_TIFF_INTERNAL_MASK YES





```






```
gdalbuildvrt -a_srs EPSG:2056 -addalpha ch.swisstopo.orthofoto_2018.rgb.vrt *.tif
gdal_translate /geodata/swisstopo/SWISSIMAGE_LEVEL3/10cm/ch.swisstopo.orthofoto_2018.rgb.vrt /geodata/geodata/ch.swisstopo.orthofoto_2018.rgb/ch.swisstopo.orthofoto_2018.rgb_tmp.tif -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'TILED=YES' -co 'BIGTIFF=YES'
gdaladdo --config COMPRESS_OVERVIEW DEFLATE --config PREDICTOR_OVERVIEW 2 -ro -r average /geodata/geodata/ch.swisstopo.orthofoto_2018.rgb/ch.swisstopo.orthofoto_2018.rgb_tmp.tif 2



```


















## Geoserver Image Pyramid

gdal_retile.py -v -r bilinear -levels 8 -ps 4096 4096 -co "TILED=YES" -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -targetDir pyramid ch.swisstopo.lk10.grau_relief.tif
gdal_retile.py -v -r cubic -levels 8 -ps 4096 4096 -co "TILED=YES" -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -targetDir lk10_grau_relief_cubic/ ch.swisstopo.lk10.grau_relief.tif
gdal_retile.py -v -r bilinear -levels 8 -ps 4096 4096 -co "TILED=YES" -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -targetDir lk10_farbig_relief ch.swisstopo.lk10.farbig_relief.tif


gdal_retile.py -v -r bilinear -levels 8 -ps 4096 4096 -co "TILED=YES" -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -targetDir lidar_2014_dom_relief ch.so.agi.lidar_2014.dom_relief.tif








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


