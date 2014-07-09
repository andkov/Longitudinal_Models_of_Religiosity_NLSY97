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

############################
## @knitr DeclareGlobals
source(file.path(getwd(),"Models/Descriptives/AesDefine.R"))
############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")
source(file.path(getwd(),"Models/LCM/LCModels.R"))

############################
## @knitr TweakData

############################
## @knitr modelSpecification
.
.
.
############################
## @knitr m5F
source(./..../)
# grid dimentions
> unitlay <-
  grid.layout(3, 3,
              widths=unit(c(1, 1, 2),
                          c("inches", "null", "null")),
              heights=unit(c(3, 1, 1),
                           c("lines", "null", "null")))



############################
## @knitr m6F

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