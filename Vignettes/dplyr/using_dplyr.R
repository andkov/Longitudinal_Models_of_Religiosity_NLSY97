#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr LoadPackages
require(RODBC)
require(dplyr)
require(ggplot2)

############################
## @knitr DeclareGlobals

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





# vignette("markdown-examples", package="markdown")



?plyr





