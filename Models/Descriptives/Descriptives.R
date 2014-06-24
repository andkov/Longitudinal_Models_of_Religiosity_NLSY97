#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr DeclareGlobals
# Palett for attendance
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
require(dplyr)
require(ggplot2)


############################
## @knitr LoadData
pathDir<- getwd()
pathImageOut<-file.path(pathDir,"Models/Descriptives/figure_rmd") # to store .pngs
dsL<-readRDS("./Data/Derived/dsL.rds")
# dsL<- dsL[dsL$sample==1,] # select only the cross-sample
# str(dsL)

# Variables that do not change with time, TI - time invariant
TIvars<-c("sample", "id", "sex","race", "bmonth","byear",  'attendPR', "relprefPR", "relraisedPR")


############################
## @knitr TweakData



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


# Run this code manualy, connection doesn't work yet
Descriptives <- base::file.path("./Models/Descriptives/Descriptives.Rmd")
pathsReports <-c(Descriptives)
# Build the reports
for( pathRmd in pathsReports ) {
  pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  pathHtml <- base::gsub(pattern=".Rmd$", replacement=".html", x=pathRmd)
  markdown::markdownToHTML(file=pathMd, output=pathHtml)
}
