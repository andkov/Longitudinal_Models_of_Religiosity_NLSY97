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
## @knitr LoadSources
source("./Models/LCM/graphs/FERE graph.R") #Load the `BuildFERE()` function
source("./Models/LCM/graphs/bar graph of fit.R") #Load the `BuildBar()` function

############################
## @knitr DeclareGlobals
source("./Models/Descriptives/AesDefine.R")

vpLayout <- function(rowIndex, columnIndex) { return( viewport(layout.pos.row=rowIndex, layout.pos.col=columnIndex) ) }

############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")
source("./Models/LCM/LCModels.R")

lstModelOutcomes <- readRDS("./Models/LCM/models/datasets/ListOfModelOutcomes.rds")
names(lstModelOutcomes)
gBar <- BuildBar()
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
  #   gLin <- Line(modelName)
  
  grid.newpage()
    
  layout <- grid.layout(nrow=3, ncol=3,
                        widths=unit(c(1, 1, 2),c("inches", "null", "null")),
                        heights=unit(c(3, 1, 1), c("lines", "null", "null"))
  )
  pushViewport(viewport(layout=layout))
  print(gTile, vp=vpLayout(2, 2)) #Y ~ X1 
  print(gBar, vp=vpLayout(2, 3)) #Y ~ x2
  

popViewport(0)
}

############################
## @knitr m5F
# dsWide <- lstModelOutcomes["m5F"][[1]]
BuildMosaic(modelName="m5F")

############################
## @knitr m6F
BuildMosaic(modelName="m6F")

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


# source(./..../)
# # grid dimentions
# > unitlay <-
#   grid.layout(3, 3,
#               widths=unit(c(1, 1, 2),
#                           c("inches", "null", "null")),
#               heights=unit(c(3, 1, 1),
#                            c("lines", "null", "null")))