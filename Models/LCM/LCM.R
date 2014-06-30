#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr LoadPackages
require(RODBC)
require(ggplot2)
require(plyr)
require(reshape2)
require(lme4) #Load the library necessary for multilevel models
require(colorspace) #Load the library necessary for creating tightly-controlled palettes.
require(Hmisc)
require(lattice)

############################
## @knitr DeclareGlobals
source(file.path(getwd(),"Models/Descriptives/AesDefine.R"))
############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")
############################
## @knitr TweakData

############################
## @knitr AnalysisChunk01

ds<- dsL







############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03

