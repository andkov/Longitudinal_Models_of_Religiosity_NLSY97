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
dsL<-read.csv(file=pathdsL,header=T,sep=",")

# Variables that do not change with time, TI - time invariant
TIvars<-c("sample", "id", "sex","race", "bmonth","byear",  'attendPR', "relprefPR", "relraisedPR")

############################
## @knitr TweakData
## dsL into...
dsDSR<-dsL[,c('id',"byear","year","attend","ageyear","agemon")] # take these variables from dsL
dsDSR<-dsDSR[which(dsDSR$year %in% 2000:2011),] # keep records for these years

dsDSR<-mutate(dsDSR,timec=year-2000) # center time
dsDSR<-mutate(dsDSR,ageyearmon=(agemon/12))
dsDSR<-mutate(dsDSR,linear=(0:(length(unique(dsDSR$year))-1))) # increse by 1 every year
dsDSR<-mutate(dsDSR,quadratic=linear^2) 
dsDSR<-mutate(dsDSR,cubic=linear^3)

##...dsDSR

############################
## @knitr AnalysisChunk01
ds<-dsDSR

ggplot(ds, aes(x=byear))+geom_bar(binwidth=1)

############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03


