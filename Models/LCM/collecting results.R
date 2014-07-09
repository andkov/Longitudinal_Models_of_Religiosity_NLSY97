cat("\014")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

############################
## @knitr LoadPackages
require(RODBC)
require(grid)
require(lattice)
require(dplyr)
require(ggplot2)
require(gridExtra)
require(lme4)
require(reshape2)

############################
## @knitr DeclareGlobals
# load common aesthetics definitions used in the reports
source("./Models/Descriptives/AesDefine.R")
# read back the definitions
# aesDefs

############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")
source("./Models/LCM/LCModels.R")




############################
## @knitr defineData
numID<- 9022 # highest id value (max = 9022)
### Define the data that will populate the model
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id %in% c(1:numID)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(1)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(4)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %.% # birth year 1980:1984
  dplyr::filter(ave(!is.na(attend), id, FUN = all)) %.% # only complete trajectories
  dplyr::mutate( # compute new variables
    age= year-byear, # definition of age to be used in the model    
    timec=year-2000, # metric of time is rounds of NSLY97 in years, centered at 2000
    timec2= timec^2, 
    timec3= timec^3,
    #         timec= age-16, # metric of time is bilogical age in years, centered at 16
    #         timec2= timec^2,
    #         timec3= timec^3,# 
    cohort=byear-1980) %.% # age difference, years younger (unit - 1 cohort away)
  dplyr::select( # assemble the dataset for modeling
    id, sample, race, byear,cohort, # Time Invariant variables
    year,
    age, timec,timec2,timec3, attend)  # Time Variant variables
head(ds)
table(ds$byear) # the year of birth  - metric: YEAR 
table(ds$age) # years past 16 -  metric: AGE
table(ds$year, ds$age) # YEAR by  AGE 
length(unique(ds$id)) # total No. of respondents in dataset
sum(!is.na(ds$attend)) # valid datapoints 
sum(is.na(ds$attend)) # NA in the dataset 
length(unique(ds$timec))

## FOR TESTING ###
# flmer<- as.formula(call_m5R1)
# model <-lmer (flmer, data = ds, REML=FALSE,
#               control=lmerControl(optCtrl=list(maxfun=20000)))
# modelR<-model
# 
# fnlme<- as.formula(call_m5F)
# model<- nlme::gls(f, data=ds,method = "ML")
# modelF<-model

###################

modelName <- "m1R1"
# list of fixed models
modelsFE <- c(  "m0F", "m1F", "m2F", "m3F", "m4F", "m5F", "m6F", "m7F",
                "mFa", "mFb", "mFc", "mFd","mFe")
modelsR1 <- c("m0R1", "m1R1", "m2R1", "m3R1", "m4R1", "m5R1", "m6R1", "m7R1",
              "mR1a", "mR1b", "mR1c", "mR1d","mR1e")
modelsR2 <- c(        "m1R2", "m2R2", "m3R2", "m4R2", "m5R2", "m6R2", "m7R2")

modelsR3 <- c(                "m2R3", "m3R3", "m4R3", "m5R3", "m6R3", "m7R3")

modelsR4 <- c(                        "m3R4", "m4R4", "m5R4", "m6R4", "m7R4")

allModels<- modelNamesLabels
modelList<- c(modelsR3,modelsR4 )

# Traditional reading in the files
getModels<- c("m7R3")
getAll<- modelList


for(i in modelList){
  modelName<- i
  pathdsmInfo <- file.path("./Models/LCM/models/datasets",paste0(i,"_mInfo.rds"))
  pathdsFERE  <- file.path("./Models/LCM/models/datasets",paste0(i,"_FERE.rds"))
  pathdsp  <- file.path("./Models/LCM/models/datasets",paste0(i,"_dsp.rds"))
  mInfoTemp<- readRDS(pathdsmInfo)
  FERETemp<- readRDS(pathdsFERE)
  dspTemp<- readRDS(pathdsp)
  
  assign(paste0(i,"_mInfo"),mInfoTemp)
  assign(paste0(i,"_FERE"),FERETemp)
  assign(paste0(i,"_dsp"),dspTemp)
  rm(list = c("mInfoTemp", "FERETemp", "dspTemp"))
}

###################
# Read in different REDS files and join them all together
pathDataDirectory <- file.path("./Models/LCM/models/datasets")
# filenamePattern <- ".+\\.rds" #All RDS files
filenamePattern <- "m.{1,}Info\\.rds" #All RDS files

retrievedFilenames <- list.files(path=pathDataDirectory, pattern=filenamePattern)
filePaths <- file.path(pathDataDirectory, retrievedFilenames)

dsInfo <- readRDS(filePaths[1])
for( i in 1:length(filePaths) ) {
  # To debug, change the '6' to some number to isolate the problem: for( i in 2:6 ) {
  # message("About to read", filePaths[i], "\\")
  dsInfoSingle <- readRDS(filePaths[i])
  dsInfo <- plyr::join(x=dsInfo, y=dsInfoSingle, by="Coefficient", type="left", match="all")
  rm(dsInfoSingle)
}





############################################
### graph for fixed effects
ds<- m7R3_FERE
keepvars<- c("Estimate", "Std.Error", "t.value","varRE", "sdRE","intVarRE", "timecVarRE", "timec2VarRE", #"timec3VarRE", 
             "sigma")
# head(ds)
ds<- ds %>% dplyr::select( Estimate, Std.Error, t.value,varRE, sdRE,intVarRE, timecVarRE, timec2VarRE, 
#                            timec3VarRE, 
sigma )
head(ds)

library(ggplot2)
library(reshape2)       # for melt(...)
library(RColorBrewer)   # for brewer.pal(...)


c
d <- melt(cbind(id=colnames(ds),ds),id="id")
colors <- brewer.pal(11,"Spectral")

ggplot(d, aes(x=id, y=variable, fill=value)) + 
  geom_tile()+
  geom_text(aes(label=round(value,4),color=factor(sign(value))))+
  scale_x_discrete(expand=c(0,0))+scale_y_discrete(expand=c(0,0))+
  labs(x="variable",y="variable")+
  scale_fill_gradient2(low=colors[10],mid=colors[6],high=colors[2],
                       midpoint=0, 
                       limits=c(-max(d$value),max(d$value)))+
  scale_color_manual(guide="none",values=c("red","blue"))+
  coord_fixed()





# the rows must be ordered:
row.order.FERE<- c("(Intercept)",  "timec", "timec2", "timec3", "cohort", "timec:cohort", "timec2:cohort", "timec3:cohort")
# the same order should be in the correlation matrix


#############################################
### graph of comparative fit
ds<-dsInfo
head(ds)
dsLong<- reshape2::melt(ds,id.vars=c('Coefficient'))
head(dsLong)





###############################################
### graph of prediction

bgColour<-gray(.95)   # background color
indLineSz<-.08        # individual line size
indLineAl<-.06        # individual line alpha


require(ggplot2)
ds<- m7R1_dsp %>% dplyr::filter(id %in% c(1:500))
head(ds)
p<- ggplot2::ggplot(ds, aes(x=timec, y=attend, group=id))
# geoms
p<- p + geom_line(aes(x=timec,y=yHat),colour="red",alpha=indLineAl,size=indLineSz)
p<- p + geom_line(aes(y=yFE), fill=NA)
# p<- p + geom_line(aes(y=gamma00),fill=NA, color="black",size=2)
# p<- p + geom_line(aes(y=gamma01),fill=NA, color="red", size=2)
# p<- p + geom_line(aes(y=gamma02),fill=NA, color="green", size=2)
# p<- p + geom_line(aes(y=gamma03),fill=NA, color="blue", size=2)
# p<- p + geom_line(aes(y=gamma10),fill=NA, color="black", size=1, linetype="dashed")
# p<- p + geom_line(aes(y=gamma11),fill=NA, color="red", size=1, linetype="dashed")
# p<- p + geom_line(aes(y=gamma12),fill=NA, color="green", size=1, linetype="dashed")
# p<- p + geom_line(aes(y=gamma13),fill=NA, color="blue",  size=1, linetype="dashed")
# scales
p<- p + scale_x_continuous(breaks=seq(0,10, 1),limits=c(0,10)) 
p<- p + scale_y_continuous(breaks=seq(0, 8, 1),limits=c(.5,8.5)) 
# themes, guide, and annotations
p <- p + ggplot2::theme_bw()
p <- p + ggplot2::theme_bw(base_size=baseSize)
p <- p + ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = 12)) 
p <- p + ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80"))
p <- p + ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))
p <- p + theme(text = element_text(size =25), panel.background=element_rect(fill=bgColour,colour=NA))
p<- p + ggplot2::theme(legend.position=c(.95,.90),legend.direction="vertical")
p<- p + ggplot2::theme(legend.background = element_rect(fill=NA))
p<- p + ggplot2::theme(legend.text = element_text(size = 15),legend.title.align =(-3.3))
p<- p + ggplot2::theme(panel.grid = element_line(linetype = 1,size=rel(3)))
p <- p + labs(title="How often have you attended a worship service (2000)?", 
              x="Church attendance", 
              y="Count")
p






