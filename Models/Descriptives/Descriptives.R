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

dsDSR<-dsL # take these variables from dsL

ds<-dsDSR

##...dsDSR

############################
## @knitr AnalysisChunk01


# focvar<-"sample"
# p<-ggplot(subset(ds,year==1997), aes(x=focvar))+geom_bar()
# pathImage<-file.path(pathImageOut,paste0("focvar","_","1997",".png"))
# png(filename = pathImage,
#     width =4, height =5.5, units="in", res=400)
# plot(p)
# dev.off()
# 
# 
# focvar<-"sex"
# p<-ggplot(subset(ds,year==1997), aes(x=focvar))+geom_bar()
# pathImage<-file.path(pathImageOut,paste0(focvar,"_","1997",".png"))
# png(filename = pathImage,
#     width =4, height =5.5, units="in", res=400)
# plot(p)
# dev.off()





############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03

# Descriptives <- base::file.path("./Models/Descriptives/Descriptives.Rmd")
# pathsReports <-c(Descriptives)
# # Build the reports
# for( pathRmd in pathsReports ) {
#   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
#   pathHtml <- base::gsub(pattern=".Rmd$", replacement=".html", x=pathRmd)
#   knitr::knit(input=pathRmd, output=pathMd)
#   markdown::markdownToHTML(file=pathMd, output=pathHtml)
# }
