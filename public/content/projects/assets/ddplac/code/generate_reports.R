
# ABOUT -------------------------------------------------------------------

# Description: <The aim of this script>
# Usage: <How to run this script: what input it requires and output produced>
# Author: <Your name>
# Date: <current date>

# SETUP -------------------------------------------------------------------

# Script-specific options or packages
p_load(knitr, rmarkdown) # install/load packages to generate reports

# RUN ---------------------------------------------------------------------

# Generate article --------------------------------------------------------

render(input = "report/article.Rmd")

# Generate presentation slides --------------------------------------------

render(input = "report/slides.Rmd")

# Generate webpage --------------------------------------------------------

render(input = "report/web.Rmd")

# Generar presentacion powerpoint --------------------------------------------

render(input = "report/presentacion.Rmd")

# Generar Informe --------------------------------------------------------

render(input = "report/reporte.Rmd")



# LOG ---------------------------------------------------------------------

# Any descriptives that will be helpful to understand the results of this
# script and how it contributes to the aims of the project

# CLEAN UP ----------------------------------------------------------------

# Remove all current environment variables
rm(list = ls())
