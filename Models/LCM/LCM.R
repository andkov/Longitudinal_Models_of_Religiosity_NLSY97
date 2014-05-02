#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr DeclareGlobals
attcol8<-c("#4575b4","#74add1","#abd9e9", "#e0f3f8", "#fee090", "#fdae61" ,"#f46d43", "#d73027")

############################
## @knitr LoadPackages
require(RODBC)
require(plyr)
require(ggplot2)




############################
## @knitr LoadData
pathDir<-getwd() 
pathdsL<-file.path(pathDir,"Data/Derived/dsL.rds") # labeled factors, clean ds
pathImageOut<-file.path(pathDir,"Models/Descriptives/figure_rmd") # to store .pngs
dsL<-readRDS("./Data/Derived/dsL.rds")

# Variables that do not change with time, TI - time invariant
TIvars<-c("sample", "id", "sex","race", "bmonth","byear",  'attendPR', "relprefPR", "relraisedPR")

############################
## @knitr TweakData


dsLCM<-dsL[,c('id',"byear","year","attend","ageyear")]
dsLCM<-dsLCM[which(dsLCM$year %in% 2000:2011),]

# dsLCM<-mutate(dsLCM,timec=year-2000) # creates centered variable
# dsLCM<-mutate(dsLCM,age=year-byear) # computes age in years at time of interview
# dsLCM<-mutate(dsLCM,linear+1)
# dsLCM<-mutate(dsLCM,quadratic=linear^2)
# dsLCM<-mutate(dsLCM,cubic=linear^3)

ds<- dsLCM
############################
## @knitr AnalysisChunk01


############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03


