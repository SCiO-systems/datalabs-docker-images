install.packages(c('devtools','raster', 'rgdal', 'rgeos', 'maptools', 'shapefiles', 
                    'ncdf4', 'terra', 'rworldmap', 'spatstat.geom', 'ggmap', 'rgee', 
                    'plotKML', 'leaflet', 'dismo', 'geodata', 'gdalUtilities', 'Hmisc', 
                    'circlize', 'diagis', 'ggnewscale', 'lmerTest', 'lme4', 'metafor', 
                    'metan', 'pbapply', 'FactoMineR', 'doParallel', 'ggpubr', 'broom', 
                    'mlr3', 'RInside', 'doSNOW', 'rdrop2', 'Microsoft365R', 'googleCloudStorageR', 
                    'circular', 'miceadds', 'multimode', 'sfsmisc', 'rJava', 'R.utils', 
                    'reshape2', 'rworldxtra', 'RCurl', 'tidyverse', 'ranger', 'sodium', 
                    'pals', 'ggcorrplot', 'aws.s3', 'agricolae', 'xlsx', 'ecmwfr', 
                    'envirem', 'ranger', 'maps', 'dplyr', 'DSSAT'), 
    dependencies=TRUE, 
    repos='http://cran.rstudio.com/', 
    Ncpus = 4)

devtools::install_github(c("CIAT-DAPA/analogues",
                   "SantanderMetGroup/loadeR.java",
                   "SantanderMetGroup/climate4R.UDG",
                   "SantanderMetGroup/loadeR",
                   "SantanderMetGroup/transformeR",
                   "SantanderMetGroup/visualizeR",
                   "SantanderMetGroup/downscaleR",
                   "femiguez/apsimx"), configure.args="Ncpus = 4")
devtools::install_github(c("SantanderMetGroup/convertR",
                   "SantanderMetGroup/climate4R.indices"))

devtools::install_github("bakaburg1/BaySREn")