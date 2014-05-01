#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr DeclareGlobals


############################
## @knitr LoadPackages
require(RODBC)
require(plyr)
require(ggplot2)



############################
## @knitr LoadData
pathDir<-getwd() 
pathdsL<-file.path(pathDir,"Data/Derived/dsL.csv")
pathImageOut<-file.path(pathDir,"Models/Descriptives/figure_rmd")

dsL<-read.csv(file=pathdsL,header=T,sep=",")

# str(dsL)

# Variables that do not change with time, TI - time invariant
TIvars<-c("sample", "id", "sex","race", "bmonth","byear",  'attendPR', "relprefPR", "relraisedPR")


############################
## @knitr TweakData
# Assigns labels to categorical variables
source(file.path(pathDir,"Manipulation/LabelingFactorLevels.R"))

## dsL into...
dsLCM<-dsL[,c('id',"byear","year","attend")]
dsLCM<-dsLCM[which(dsLCM$year %in% 2000:2011),]

# dsLCM<-mutate(dsLCM,timec=year-2000) # creates centered variable
# dsLCM<-mutate(dsLCM,age=year-byear) # computes age in years at time of interview
# dsLCM<-mutate(dsLCM,linear+1)
# dsLCM<-mutate(dsLCM,quadratic=linear^2)
# dsLCM<-mutate(dsLCM,cubic=linear^3)

ds<-dsLCM

p<-ggplot(subset(ds,year==2000), aes(x=attend))
p<-p+geom_bar()
p<-p+coord_flip()
p<-p+xlab("Church attendance") 
p<-p+ylab("Count")
p



##...dsLCM

############################
## @knitr AnalysisChunk01

############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03



############################
## @knitr TweakData
