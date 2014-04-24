rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
require(plyr)
require(scales) #For formating values in graphs
# require(reshape2) #For converting wide to long
require(ggplot2) #For graphing
require(testit) #For asserting
# require(NlsyLinks)

#####################################
## @knitr DeclareGlobals
pathExtract <- "./Data/Extracts/NLSY97_Religiosity_20042014/NLSY97_Religiosity_20042014.csv"
pathItemMapping <- "./Data/ItemMapping/ItemMap_20042014.csv"
# pathOutputSubject <- "./Data/Derived/Gen1H50Derived.rds"
# lastSurveyYear <- 2010L

# checkH40_1 <- "H0006000"
# checkH50_1 <- "H0020000"
# 
# Truncate <- function( scores, minValue, maxValue ) {
#   if( !is.na(minValue) )
#     scores[scores < minValue] <- NA
#   if( !is.na(maxValue) )
#     scores[maxValue < scores] <- NA
#   return( scores )
# }

# source("./Code/DescriptiveFxs.R")
#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsMapping <- read.csv(pathItemMapping, stringsAsFactors=F)
ds <- read.csv(pathExtract, stringsAsFactors=F)

# sum(!is.na(dsSubjectDetails$DeathDate))
#####################################
## @knitr TweakDatasets
# Excluded the variables that you don't want translated
# dsMapping <- dsMapping[dsMapping$Translate, ]

#Check all the mapped variables are in the extract
variableNameMatchedInExtract <- !is.na(match(x=dsMapping$RNumber, colnames(ds)))
testit::assert("All Mapped items should be present in the extract", 0 == sum(!variableNameMatchedInExtract))
rm(variableNameMatchedInExtract)

# dsAges <- data.frame(SubjectTag=dsSubjectDetails$SubjectTag, Mob=dsSubjectDetails$Mob )
# dsAges$At2010 <- as.numeric(difftime(time1=as.Date("2010-01-01"), time2=dsSubjectDetails$Mob, units= "days") / 365.25) # qplot(dsAges$At2010)
# dsAges$At2008 <- as.numeric(difftime(time1=as.Date("2008-01-01"), time2=dsSubjectDetails$Mob, units= "days") / 365.25) # qplot(dsAges$At2008)

#Set to missing values
for( i in seq_along(dsMapping$RNumber) ) {
  rNumber <- dsMapping[i, "RNumber"]  
  variableName <- dsMapping[i, "VariableName"]  
#   ds <- plyr::rename(ds, replace=c(rNumber=variableName))
colnames(ds)[colnames(ds)==rNumber] <- variableName
  
  #   variableClass <- dsMapping[i, "VariableClass"]
  #   cast_fx <- get(paste0("as.", variableClass))
    
  #   missingCodes <- unlist(strsplit(dsMapping[i, "MissingCodes"], split=";"))
  #   ds[, rNumber] <- ifelse(ds[, rNumber] %in% missingCodes, NA, ds[, rNumber])
  
  #   if( variableClass[1] %in% c("factor", "ordered") )
  #     ds[, rNumber] <- ReplaceNAsWithFactorLevel(ds[, rNumber])
  #   ds[, rNumber] <- cast_fx(ds[, rNumber] )
}

# ds$T3043700 <- ordered(ds$T3043700, labels=c("Weeks", "Months", "Years"))

# #####################################
# ## @knitr CreateDerivedVariables
# 
# ### Check if completed health modules
# ds$CompleteHealth40 <- !is.na(ds$H0000200)
# ds$CompleteHealth50 <- !is.na(ds$H0013201)
# 
# #############
# ### Health-50 Module items
# #############
# 
# ### H2
# ds$HeightInInchesTotal <- 12L * ds$T3024800 + ds$T3024900 # qplot(ds$HeightInInchesTotal)
# 
# ### H15
# ds$ChestPain <- ((ds[, checkH40_1] & ds$H0006300) | (ds[, checkH50_1] & ds$H0020300))
# 
# #############
# ### Smoking items
# #############
# 
# ### SK1 --Asked in 2010 (it's not in Health-50 module)
# #https://www.nlsinfo.org/sites/nlsinfo.org/files/attachments/121210/17.Smoking%20and%20Alcohol%20Use.html
# ds$Smoked100InLifetime <- (ds$T3043100 | ds$T3043200)
# table(ds$Smoked100InLifetime)
# # cbind(ds$T3043100, ds$T3043200, (ds$T3043100 | ds$T3043200))


#############
### Subsample
#############
# # http://nlsinfo.org/content/cohorts/nlsy79/intro-to-the-sample/sample-design-screening-process
# droppedPoorWhite <- (ds$R0173600 %in% c(9, 12)); sum(droppedPoorWhite)
# droppedMilitary <- (!is.na(ds$T3107600) & ds$T3107600==68); sum(droppedMilitary)
# ds$SubsampleRetained <- (!droppedPoorWhite & !droppedMilitary); sum(ds$SubsampleRetained)
# # ds$
# ds$SubsampleCrossSectional <- (ds$R0173600 %in% 1:8); sum(ds$SubsampleCrossSectional)
# # table(ds$SubsampleDropped, ds$SmokeDailyCurrently, exclude=NULL)
# # table(ds$R0173600, ds$SmokeDailyCurrently, exclude=NULL)
# # table(ds$R0173600, ds$T3107600, exclude=NULL) #201 subjects in the the military subsample were retained

#############
### Reason for Noninterview
#############
# ds$Deceased <- (!is.na(ds$T3107600) & ds$T3107600==65); sum(ds$Dead)


#####################################
## @knitr CleanDerivedVariables
# for( i in seq_along(dsMappingDerived$VariableName) ) {
#   variableName <- dsMappingDerived[i, "VariableName"]
#   testit::assert("The variable name in `dsMappingDerived` should be found in `ds`.", variableName %in% colnames(ds))
#   
#   #TODO: this might not work if truncation values aren't set.
#   minValue <- dsMappingDerived[i, "TruncateMin"]
#   maxValue <- dsMappingDerived[i, "TruncateMax"]
#   ds[, variableName] <- Truncate(ds[, variableName], minValue=minValue, maxValue=maxValue)
#   #   print(qplot(ds[, variableName], main=variableName))
#   #   rm(variableName, minValue, maxValue)
# }

#####################################
## @knitr Metadata
sapply(sapply(ds, class), FUN=function( x ){ return( x[1] ) })
# str(ds)

#####################################
## @knitr SaveDerivedData
# saveRDS(object=ds, file=pathOutputSubject, compress="xz")
