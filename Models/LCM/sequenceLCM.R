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
## @knitr DeclareGlobals
source("./Models/Descriptives/AesDefine.R")
pathImageDirectory <- "./Models/LCM/models/formula_images"
pathImage <- "./Models/LCM/graphs/sequenceMap/sequenceMap_wideModel.png"

vpLayout <- function(rowIndex, columnIndex) { return( viewport(layout.pos.row=rowIndex, layout.pos.col=columnIndex) ) }

PullAppropriatePng <- function( modelName ) {
  pathImage <- file.path(pathImageDirectory, paste0(modelName, ".png"))
  testit::assert("The model's equation png was not found.", file.exists(pathImage))
  p <- png::readPNG(pathImage)
  return( p )
}

BuildMosaic <- function( modelName ) {
  testit::assert(fact="The FERE object should be found in the appropriate list", modelName %in% names(lstModelOutcomes))
  dsFERE <- lstModelOutcomes[modelName][[1]]
  
#   pEquations <- png::readPNG(pathImage) #Replace this line with the one below it (toggle the comments).
  pEquations <- PullAppropriatePng(modelName=modelName)
  
  gTile <- BuildFERE(modelName=modelName, dsWide=dsFERE)
  gLine <- BuildLine(modelName=modelName)
  gBar <- BuildBar(modelName=modelName)
  
  grid.newpage()    
  #Defnie the relative proportions among the panels in the mosaic.
  layout <- grid.layout(nrow=3, ncol=2,
                        widths=unit(c(.4, .6) ,c("null", "null")),
                        heights=unit(c(.3, .2, .5), c("null", "null", "null"))
  )
  pushViewport(viewport(layout=layout))
  grid.raster(pEquations, vp=viewport(layout.pos.row=1))
  print(gTile, vp=viewport(layout.pos.row=2))
  print(gLine, vp=vpLayout(3, 1))
  print(gBar, vp=vpLayout(3, 2))
  
  popViewport(0)
}
############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")
source("./Models/LCM/LCModels.R")

lstModelOutcomes <- readRDS("./Models/LCM/models/datasets/ListOfModelOutcomes.rds")
# names(lstModelOutcomes)

# pEquations <- png::readPNG(pathImage)
############################
## @knitr TweakData

############################
## @knitr modelSpecification

############################
## @knitr TweakData

####################################### models with FIXED only #####--F
## @knitr m0F
# dsWide <- lstModelOutcomes["m0F"][[1]]; modelName <- "m0F"
BuildMosaic(modelName="m0F")

############################
## @knitr m1F
# dsWide <- lstModelOutcomes["m1F"][[1]]; modelName <- "m1F"
BuildMosaic(modelName="m1F")#             

############################
## @knitr m2F
BuildMosaic(modelName="m2F")

############################
## @knitr m3F
BuildMosaic(modelName="m3F")

############################
## @knitr m4F
BuildMosaic(modelName="m4F")

############################
## @knitr m5F
BuildMosaic(modelName="m5F")

############################
## @knitr m6F
BuildMosaic(modelName="m6F")

############################
## @knitr m7F
BuildMosaic(modelName="m7F")

########################################## models with 1 RANDOM #####--R1
## @knitr m0R1
BuildMosaic(modelName="m0R1")
# m0R1 <- readRDS("./Models/LCM/models/datasets/m0R1_dsp.rds")

## @knitr m1R1
BuildMosaic(modelName="m1R1")

############################
## @knitr m2R1
BuildMosaic(modelName="m2R1")

############################
## @knitr m3R1
BuildMosaic(modelName="m3R1")

############################
## @knitr m4R1
BuildMosaic(modelName="m4R1")

############################
## @knitr m5R1
BuildMosaic(modelName="m5R1")

############################
## @knitr m6R1
BuildMosaic(modelName="m6R1")

############################
## @knitr m7R1
BuildMosaic(modelName="m7R1")

########################################## models with 2 RANDOM #####--R2
## @knitr m1R2
BuildMosaic(modelName="m1R2")

############################
## @knitr m2R2
BuildMosaic(modelName="m2R2")

############################
## @knitr m3R2
BuildMosaic(modelName="m3R2")

############################
## @knitr m4R2
BuildMosaic(modelName="m4R2")

############################
## @knitr m5R2
BuildMosaic(modelName="m5R2")

############################
## @knitr m6R2
BuildMosaic(modelName="m6R2")

############################
## @knitr m7R2
BuildMosaic(modelName="m7R2")

########################################### models with 3 RANDOM #####--R3
## @knitr m2R3
BuildMosaic(modelName="m2R3")

############################
## @knitr m3R3
BuildMosaic(modelName="m3R3")

############################
## @knitr m4R3
BuildMosaic(modelName="m4R3")

############################
## @knitr m5R3
BuildMosaic(modelName="m5R3")

############################
## @knitr m6R3
BuildMosaic(modelName="m6R3")

############################
## @knitr m7R3
BuildMosaic(modelName="m7R3")

########################################### models with 4 RANDOM #####--R4
## @knitr m3R4
BuildMosaic(modelName="m3R4")

############################
## @knitr m4R4
BuildMosaic(modelName="m4R4")

############################
## @knitr m5R4
BuildMosaic(modelName="m5R4")

############################
## @knitr m6R4
BuildMosaic(modelName="m6R4")

############################
## @knitr m7R4
BuildMosaic(modelName="m7R4")

######################################### other RANDOM  models #####--Ro
## @knitr mR1a
BuildMosaic(modelName="mR1a")

############################
## @knitr mR1b
BuildMosaic(modelName="mR1b")

############################
## @knitr mR1c
BuildMosaic(modelName="mR1c")

############################
## @knitr mR1d
BuildMosaic(modelName="mR1d")

############################
## @knitr mR1e
BuildMosaic(modelName="mR1e")

######################################### other FIXED models #####--Fo
## @knitr mFa
BuildMosaic(modelName="mFa")

############################
## @knitr mFb
BuildMosaic(modelName="mFb")

############################
## @knitr mFc
BuildMosaic(modelName="mFc")

############################
## @knitr mFd
BuildMosaic(modelName="mFd")

############################
## @knitr mFe
BuildMosaic(modelName="mFe")
