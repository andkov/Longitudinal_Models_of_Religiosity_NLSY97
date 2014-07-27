#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr LoadPackages
require(RODBC)
require(grid)
require(lattice)
require(dplyr)
require(ggplot2)
require(gridExtra)
require(lme4)
require(reshape2)
require(testit)
require(png)

############################
## @knitr LoadSources
source("./Models/LCM/graphs/FERE graph.R") #Load the `BuildFERE()` function
source("./Models/LCM/graphs/bar graph of fit.R") #Load the `BuildBar()` function
source("./Models/LCM/graphs/line graph of trajectories.R") #Load the `BuildLine()` function

############################
## @knitr @loadRDS
modelName<- "m0R3"  
# Read in different REDS files and join them all together
pathDataDirectory <- file.path("./Models/LCM/models/datasets")
# filenamePattern <- ".+\\.rds" #All RDS files
filenamePattern <- "m.{1,}Info\\.rds" #All RDS files

retrievedFilenames <- list.files(path=pathDataDirectory, pattern=filenamePattern)
filePaths <- file.path(pathDataDirectory, retrievedFilenames)

dsInfo <- readRDS(filePaths[1])
for( i in 1:length(filePaths) ) {
  # To debug, change the '6' to some number to isolate the problem: for( i in 2:6 ) {
  # message("About to read", filePaths[i], "\\")
  dsInfoSingle <- readRDS(filePaths[i])
  dsInfo <- plyr::join(x=dsInfo, y=dsInfoSingle, by="Coefficient", type="left", match="all")
  rm(dsInfoSingle)
}




