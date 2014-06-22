#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr DeclareGlobals
# colors to represent 8 categories of church attendance
attcol8<-c("#4575b4","#74add1","#abd9e9", "#e0f3f8", "#fee090", "#fdae61" ,"#f46d43", "#d73027")

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

# Variables that do not change with time, TI - time invariant
TIvars<-c("sample", "id", "sex","race", "bmonth","byear",  'attendPR', "relprefPR", "relraisedPR")

############################
## @knitr TweakData

dsL<- dsLF[dsLF$sample==1,]
## keepyears is defined in the  .Rmd file

# Select a few variables for current model or graph

# dsLCM<-dsLCM[which(dsLCM$year %in% keepyears),]
# dsLCM<-dsL[,c('id',"byear","year","attend","ageyear")]
# 

# dsLCM<-mutate(dsLCM,timec=year-2000) # creates centered variable
# dsLCM<-mutate(dsLCM,age=year-byear) # computes age in years at time of interview
# dsLCM<-mutate(dsLCM,linear+1)
# dsLCM<-mutate(dsLCM,quadratic=linear^2)
# dsLCM<-mutate(dsLCM,cubic=linear^3)

## For this report keep only these years
keepyears<- c(2000:2011)
ds<-dsLF[which(dsL$year %in% keepyears),]

############################
## @knitr AnalysisChunk01


############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03


#THis file contains all the models fitted in the presentation. The second portion of the code
# is the formulas for the fixed effect prediction and should be used 


