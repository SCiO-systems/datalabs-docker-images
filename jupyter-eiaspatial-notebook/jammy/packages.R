install.packages(c('devtools', 'raster', 'shapefiles', 'ncdf4', 'terra', 'geodata',
                    'spatstat.geom', 'ggmap', 'rgee', 'leaflet', 'dismo', 'gdalUtilities',
                    'circlize', 'diagis', 'ggnewscale', 'lmerTest', 'lme4', 'metafor',
                    'metan', 'pbapply', 'FactoMineR', 'doParallel', 'ggpubr', 'broom',
                    'mlr3', 'RInside', 'doSNOW', 'Microsoft365R', 'googleCloudStorageR',
                    'circular', 'miceadds', 'multimode', 'sfsmisc', 'rJava', 'R.utils', 
                    'reshape2', 'rworldxtra', 'RCurl', 'tidyverse', 'ranger', 'sodium',
                    'pals', 'ggcorrplot', 'aws.s3', 'agricolae', 'xlsx', 'ecmwfr', 'Hmisc',
                    'envirem', 'maps', 'dplyr', 'DSSAT', 'rworldmap'),
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
                   "SantanderMetGroup/convertR",
                   "SantanderMetGroup/climate4R.indices",
                   "bakaburg1/BaySREn",
                   "femiguez/apsimx"), configure.args="Ncpus = 4")