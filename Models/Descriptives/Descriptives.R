#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr LoadPackages
require(RODBC)
require(grid)
require(dplyr)
require(ggplot2)
require(gridExtra)

############################
## @knitr DeclareGlobals
pathDir<- getwd()
# load common aesthetics definitions used in the reports
source(file.path(getwd(),"Models/Descriptives/AesDefine.R"))
# read back the definitions
# aesDefs



############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")

############################
## @knitr TweakData



############################
## @knitr AnalysisChunk01



############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03


