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

############################
## @knitr DeclareGlobals
source("./Models/Descriptives/AesDefine.R")

############################
## @knitr LoadSources
source("./Models/LCM/graphs/FERE graph.R") #Load the `BuildFERE()` function

############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")
source("./Models/LCM/LCModels.R")

lstModelOutcomes <- readRDS("./Models/LCM/models/datasets/ListOfModelOutcomes.rds")
names(lstModelOutcomes)
############################
## @knitr TweakData

############################
## @knitr modelSpecification

############################
## @knitr assemble


BuildMosaic <- function( modelName ) {
  testit::assert(fact="The FERE object should be found in the appropriate list", modelName %in% names(lstModelOutcomes))
  dsFERE <- lstModelOutcomes[modelName][[1]]
  gTile <- BuildFERE(modelName=modelName, dsWide=dsFERE)
#   gBar <- Bar(modelName)
#   gLin <- Line(modelName)
#   
#   #   grid.layout(3, 3,
#   #               widths=unit(c(1, 1, 2),
#   #                           c("inches", "null", "null")),
#   #               heights=unit(c(3, 1, 1),
#   #                            c("lines", "null", "null")))
#   mosaic[1, 3] <- gTile
#   mosaic[1, 4] <- gBar
}

############################
## @knitr m5F
modelName <- "m5F"
# dsWide <- lstModelOutcomes[modelName][[1]]
BuildMosaic(modelName=modelName)

############################
## @knitr m6F
modelName <- "m6F"
dsWide <- lstModelOutcomes[modelName]

############################
## @knitr m7F
.
.
.

############################
## @knitr m5R1

############################
## @knitr m6R1

############################
## @knitr m7R1

.
.
.

############################
## @knitr m5R1

############################
## @knitr m6R1

############################
## @knitr m7R1


source(./..../)
# grid dimentions
> unitlay <-
  grid.layout(3, 3,
              widths=unit(c(1, 1, 2),
                          c("inches", "null", "null")),
              heights=unit(c(3, 1, 1),
                           c("lines", "null", "null")))