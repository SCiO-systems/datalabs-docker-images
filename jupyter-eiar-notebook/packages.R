install.packages(c('devtools', 'remotes', 'tidyverse', 'dplyr', 'stringr', 'ggplot2', 'ggpmisc', 'Metrics', 'lme4','geodata', 'lubridate',
                    'MuMIn', 'gridExtra', 'ggspatial', 'sf', 'plyr', 'foreach', 'parallel', 'doParallel',
                    'h2o', 'Rquefts', 'limSolve', 'lpSolve', 'terra', 'randomForest', 'gridExtra', 'tmaptools',
                    'tmap', 'DSSAT', 'readxl', 'caret', 'tidymodels', 'tidyterra', 'leaflet'),
    dependencies=TRUE, 
    repos='http://cran.rstudio.com/', 
    Ncpus = 4)

remotes::install_github("rlesur/klippy")