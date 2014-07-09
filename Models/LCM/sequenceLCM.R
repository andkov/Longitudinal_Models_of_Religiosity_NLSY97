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
1
2,2



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