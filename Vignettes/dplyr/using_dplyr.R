#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr LoadPackages
require(RODBC)
require(dplyr)
require(ggplot2)

############################
## @knitr DeclareGlobals

############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")
############################
## @knitr TweakData

############################
## @knitr AnalysisChunk01

############################
## @knitr AnalysisChunk02

############################
## @knitr AnalysisChunk03

ignette on using dplyr 








??dplyr



# p<- ggplot(ds, aes(x=factor(year), fill=attendF))
# p<- p+ geom_bar(position="fill")
# p<- p+ scale_fill_manual(values = attcol8,
#                          name="Response category" )
# p<- p+ scale_y_continuous("Prevalence: proportion of total",
#                           limits=c(0, 1),
#                           breaks=c(.1,.2,.3,.4,.5,.6,.7,.8,.9,1))
# p<- p+ scale_x_discrete("Waves of measurement",
#                         limits=as.character(c(2000:2011)))
# p<- p+ labs(title=paste0("In the past year, how often have you attended a worship service?"))
# # p<- p+ geom_text(aes(y=attendF), vjust=1.5, colour="white")
# p
# 

