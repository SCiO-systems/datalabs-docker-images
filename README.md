This project has been separated into two Docker images each based on different OS in order to surpass dependencies issues for the software tools that are being installed and configured on them

- `sciohub/jupyter-eiaspatial-notebook:jammy`
- `sciohub/jupyter-eiaspatial-notebook:focal`

They are both based on `jupyter/scipy-notebook` image instead of using `jupyter/datascience-notebook` as this has R installed through conda and this causes compatibility issues with geospatial packages.

The below are installed on them:

- GDAL
- R
- Rstudio Server (based on [jupyter-rsession-proxy](https://github.com/jupyterhub/jupyter-rsession-proxy))
- Basic Python & R geospatial packages
- Several Jupyter plugins for smoother experience
- Crop models (DSSAT, APSIM)