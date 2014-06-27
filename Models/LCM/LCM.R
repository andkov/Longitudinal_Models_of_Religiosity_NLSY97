#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr DeclareGlobals
# colors to represent 8 categories of church attendance
attcol8<-c("Never"="#4575b4",
           "Once or Twice"="#74add1",
           "Less than once/month"="#abd9e9",
           "About once/month"="#e0f3f8",
           "About twice/month"="#fee090",
           "About once/week"="#fdae61",
           "Several times/week"="#f46d43",
           "Everyday"="#d73027")

baseSize<- 14
colNA<- "#636363"

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
## @knitr LoadData
pathDir<-getwd() 
pathdsL<-file.path(pathDir,"Data/Derived/dsL.rds") # labeled factors, clean ds
pathImageOut<-file.path(pathDir,"Models/Descriptives/figure_rmd") # to store .pngs
dsL<-readRDS("./Data/Derived/dsL.rds")

# str(dsL)
attcol8<-c("Never"="#4575b4",
           "Once or Twice"="#74add1",
           "Less than once/month"="#abd9e9",
           "About once/month"="#e0f3f8",
           "About twice/month"="#fee090",
           "About once/week"="#fdae61",
           "Several times/week"="#f46d43",
           "Everyday"="#d73027")

cohortCol5<- c("1980"="#9ecae1",
               "1981"="#6baed6",
               "1982"="#4292c6",
               "1983"="#2171b5",
               "1984"="#084594")

baseSize<- 14
colNA<- "#636363"

# Variables that do not change with time, TI - time invariant
TIvars<-c("sample", "id", "sex","race", "bmonth","byear",  'attendPR', "relprefPR", "relraisedPR")

############################
## @knitr TweakData

############################
## @knitr AnalysisChunk01


############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03


#THis file contains all the models fitted in the presentation. The second portion of the code
# is the formulas for the fixed effect prediction and should be used 


