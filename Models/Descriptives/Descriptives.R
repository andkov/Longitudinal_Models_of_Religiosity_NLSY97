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
pathDir<-"../"
pathdsL<-file.path(pathDir,"Data/Derived/dsL.csv")
dsL<-read.csv(file=pathdsL,header=T,sep=",")

str(dsL)


# Variables that do not change with time, TI - time invariant
TIvars<-c("sample", "id", "sex","race", "bmonth","byear",  'attendPR', "relprefPR", "relraisedPR")
labelSex<-c("")

############################
## @knitr TweakData
## dsL into...
dsDSR<-dsL # take these variables from dsL

ds<-dsDSR

##...dsDSR

############################
## @knitr AnalysisChunk01

# sample
ggplot(ds, aes(x=factor(sample)))+geom_bar(binwidth=1)
# sex
ggplot(ds, aes(x=factor(sex)))+geom_bar(binwidth=1)
# race
ggplot(ds, aes(x=factor(race)))+geom_bar(binwidth=1)
# bmonth
ggplot(ds, aes(x=factor(bmonth)))+geom_bar(binwidth=1)
# years
ggplot(ds, aes(x=factor(bmonth)))+geom_bar(binwidth=1)

############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03


