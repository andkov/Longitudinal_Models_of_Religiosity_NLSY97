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
  dplyr::filter(id < numID) %.% # 1:9022
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

# # Traditional reading in the files
# getModels<- c("m7R3")
# getAll<- modelList
# 
# 
# for(i in allModels){
#   modelName<- i
#   pathdsmInfo <- file.path("./Models/LCM/models/datasets",paste0(i,"_mInfo.rds"))
#   pathdsFERE  <- file.path("./Models/LCM/models/datasets",paste0(i,"_FERE.rds"))
#   pathdsp  <- file.path("./Models/LCM/models/datasets",paste0(i,"_dsp.rds"))
#   mInfoTemp<- readRDS(pathdsmInfo)
#   FERETemp<- readRDS(pathdsFERE)
#   dspTemp<- readRDS(pathdsp)
#   
#   assign(paste0(i,"_mInfo"),mInfoTemp)
#   assign(paste0(i,"_FERE"),FERETemp)
#   assign(paste0(i,"_dsp"),dspTemp)
#   rm(list = c("mInfoTemp", "FERETemp", "dspTemp"))
# }

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

###################
# Read in different REDS files 
pathDataDirectory <- file.path("./Models/LCM/models/datasets")
# filenamePattern <- ".+\\.rds" #All RDS files
filenamePattern <- "m.{1,}FERE\\.rds" #All RDS files
retrievedFilenames <- list.files(path=pathDataDirectory, pattern=filenamePattern)

# dsFERE <- readRDS(filePaths[1])

# requireFieldsEvenIfNA <- c("sdRE", "timec", "intVarRE", "timecVarRE", "timec2VarRE", "timec3VarRE")

lst_ds <- NULL
for( i in seq_along(retrievedFilenames) ) {
  filePath <- filePaths <- file.path(pathDataDirectory, retrievedFilenames[i])
  dsFERESingle <- readRDS(filePath)
  
  dsFERESingle <- plyr::rename(dsFERESingle, replace=c("Value"="Estimate"), warn_missing=FALSE)
  
  #TODO: convert this into a loop
  if( !("sdRE" %in% colnames(dsFERESingle)) ) dsFERESingle$sdRE <- NA
  if( !("timec" %in% colnames(dsFERESingle)) ) dsFERESingle$timec <- NA
  if( !("intVarRE" %in% colnames(dsFERESingle)) ) dsFERESingle$intVarRE <- NA
  if( !("timecVarRE" %in% colnames(dsFERESingle)) ) dsFERESingle$timecVarRE <- NA
  if( !("timec2VarRE" %in% colnames(dsFERESingle)) ) dsFERESingle$timec2VarRE <- NA
  if( !("timec3VarRE" %in% colnames(dsFERESingle)) ) dsFERESingle$timec3VarRE <- NA
  #   for( requiredField in requireFieldsEvenIfNA ) {
  #     if( !(requireField %in% colnames(dsFERESingle)) )
  #       dsFERESingle[[requireField]] <- NA
  #   }
  
  lst_ds[[i]] <- dsFERESingle
  
  rm(dsFERESingle)
}
#names(lst_ds) <- gsub(pattern="(.+)\\.rds", replacement="\\1", x=retrievedFilenames)
names(lst_ds) <- gsub(pattern="(.+)\\_FERE.rds", replacement="\\1", x=retrievedFilenames)

saveRDS(lst_ds, file="./Models/LCM/models/datasets/ListOfModelOutcomes.rds", compress="xz")

# lst_ds["m4R1_FERE"]
# modelNames

