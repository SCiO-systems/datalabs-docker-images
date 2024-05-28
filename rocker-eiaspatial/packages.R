install.packages(c('devtools', 'shapefiles', 
                    'ncdf4', 'terra', 'rworldmap', 'spatstat.geom', 'ggmap', 'rgee', 
                    'leaflet', 'dismo', 'gdalUtilities', 'Hmisc', 
                    'circlize', 'diagis', 'ggnewscale', 'lmerTest', 'lme4', 'metafor', 
                    'metan', 'pbapply', 'FactoMineR', 'doParallel', 'ggpubr', 'broom', 
                    'mlr3', 'RInside', 'doSNOW', 'Microsoft365R', 'googleCloudStorageR', 
                    'circular', 'miceadds', 'multimode', 'sfsmisc', 'rJava', 'R.utils', 
                    'reshape2', 'rworldxtra', 'RCurl', 'tidyverse', 'ranger', 'sodium', 
                    'pals', 'ggcorrplot', 'aws.s3', 'agricolae', 'xlsx', 'ecmwfr', 
                    'envirem', 'ranger', 'maps', 'dplyr', 'DSSAT', Ncpus = 4), 
    dependencies=TRUE, 
    repos='http://cran.rstudio.com/')

devtools::install_github(c("CIAT-DAPA/analogues",
                   "SantanderMetGroup/loadeR.java",
                   "SantanderMetGroup/climate4R.UDG",
                   "SantanderMetGroup/loadeR",
                   "SantanderMetGroup/transformeR",
                   "SantanderMetGroup/visualizeR",
                   "SantanderMetGroup/downscaleR",
                   "femiguez/apsimx"))
devtools::install_github(c("SantanderMetGroup/convertR",
                   "SantanderMetGroup/climate4R.indices"), Ncpus = 4)

devtools::install_github("bakaburg1/BaySREn")