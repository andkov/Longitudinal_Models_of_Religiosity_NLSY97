#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr LoadPackages
require(RODBC)
require(plyr)

############################
## @knitr DeclareGlobals
pathDir<-getwd()
pathdsL<-file.path(pathDir,"Data/Derived/dsL.csv")
dsL<-read.csv(file=pathdsL,header=T,sep=",")

############################
## @knitr LoadData


############################
## @knitr TweakData

dsLCM<-dsL[,c('id',"byear","year","attend")]
dsLCM<-dsLCM[which(dsLCM$year %in% 2000:2011),]

dsLCM<-mutate(dsLCM,timec=year-2000) # creates centered variable
dsLCM<-mutate(dsLCM,age=year-byear) # computes age in years at time of interview
dsLCM<-mutate(dsLCM,linear=0:11)
dsLCM<-mutate(dsLCM,quadratic=linear^2)
dsLCM<-mutate(dsLCM,cubic=linear^3)


############################
## @knitr AnalysisChunk01

############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03


