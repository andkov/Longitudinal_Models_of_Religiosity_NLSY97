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
source(file.path(getwd(),"Models/Descriptives/AesDefine.R"))
# read back the definitions
# aesDefs

############################
## @knitr LoadData
dsL<-readRDS("./Data/Derived/dsL.rds")
source(file.path(getwd(),"Models/LCM/LCModels.R"))

# a <- c("m5R") #, "m1F", "m2F", "m3F", "m4F", "m5F", "m6F", "m7F")
# for(i in a){
# modelName<- i

############################
## @knitr defineData

modelName <- "m5R"

modelCall<- paste0("call_",modelName)
numID<- 9022 # highest id value (max = 9022)
### Define the data that will populate the model
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id %in% c(1:numID)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(1)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(4)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %.% # birth year 1980:1984
#   dplyr::filter(ave(!is.na(attend), id, FUN = all)) %.% # only complete trajectories
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

# Estimate the model
f<- as.formula(modelCall)
model <-lmer (f, data = ds, REML=FALSE,
               control=lmerControl(optCtrl=list(maxfun=20000)))
summary(model)
############################
## @knitr mInfo
mInfo<-summary(model)$AICtab
mInfo["N"]<- model@devcomp$dims["N"] # number of datapoints, verify
mInfo["p"]<- model@devcomp$dims["p"] # number of estimated parameters, verify
mInfo["ids"]<- (summary(model))$ngrps # number of units on level-2, here: individuals
mInfo<- c(mInfo, modelName)
mInfo

############################
## @knitr mRE
# extract RE covariance matrix
mREcov<-  data.frame(     summary(model)$varcor$id   ) # covariance matrix of RE
mREcor<-  data.frame(attr(summary(model)$varcor$id,"correlation")) # corrleation matrix of RE
mRE<-   data.frame(sd= (attr(summary(model)$varcor$id,"stddev")))
mRE$var<- mRE$sd^2
mRE<-mRE[c("var","sd")]
mRE
mREcov

############################
## @knitr RE
RE<- lme4:::ranef.merMod(model)$id 
head(RE,6)
# however
cor(RE)  # in unadjusted RE estimates, not same as mRE
var(RE)  # in unadjusted RE estimates, not same as mRE
mRE

############################
## @knitr FE
# similar ways to extract FE estimates, #3 is the fullest
FE<- fixef(model)  
FE # vector used in predition
FEt<- summary(model)$coefficients
FEt # contains t-values that test the terms


############################
## @knitr mFE
mFE<- (summary(model)$vcov@factors$correlation) # notice that this is object of 
mFE

############################
## @knitr dsp_recover_input
# Read back when went into the model
cat("\014")
dsp<- data.frame(getME(model,"X"))
dsp$id<-getME(model,"flist")$id # first level grouping factor, individual
dsp$y<-getME(model,"y") # observed response vector
head(dsp,13)

############################
## @knitr dsp_yHat_resid
# cat("\014")
dsp$yHat<- predict(model) # predicted values
dsp$resid<- lme4:::residuals.merMod(model)
head(dsp,13)
identical ( dsp$y-dsp$yHat, dsp$resid) # check if adds up

############################
## @knitr predictFE
# cat("\014")
# dsp<- data.frame(getME(model,"X")) # read back the input 
# dsp$id<-getME(model,"flist")$id # first level grouping factor, individual
# dsp$y<-getME(model,"y") # observed response vector
# head(dsp,13)
model@call

pullMainEffect <- function (timeName){
  possibleNAEffect <- FE[timeName]
  result <- ifelse( is.na(rep(possibleNAEffect,nrow(dsp))), 0,
                    possibleNAEffect*dsp[,timeName]) 
  return(result)
}

pullInteractionEffect <- function (timeName){
  possibleNAEffect <- FE[paste0(timeName,":cohort")]
  result <- ifelse( is.na(rep(possibleNAEffect,nrow(dsp))), 0,
                    possibleNAEffect*dsp[,timeName]) 
  return(result)
}

FE<- fixef(model)
# estimates of the fixed effects 
#  gamma sub(0*) - pure time effects 
# Intercept - gamma sub(00)
dsp$gamma00 <- FE["(Intercept)"]
# Linear trend of time - gamma sub(01)
dsp$gamma01 <- pullMainEffect("timec") 
# Quadratic trend of time - gamma sub(02)
dsp$gamma02 <- pullMainEffect("timec2") 
# Cubic trend of time - gamma sub(03)
dsp$gamma03 <- pullMainEffect("timec3") 
#  gamma subs(1*) - effect of cohort(w1) on: 
#  Intercept - gamma sub(01) 
dsp$gamma10 <- FE["cohort"]
# Linear trend of time - gamma sub(11)  
dsp$gamma11 <- pullInteractionEffect("timec") 
# Quadratic trend of time - gamma sub(12)
dsp$gamma12 <- pullInteractionEffect("timec2") 
# Cubic trend of time - gamma sub(13) 
dsp$gamma13 <- pullInteractionEffect("timec3") 

# Compute the mean trajectory, without the individual variability
# gamma sub(K*) - add more predictors here if expanding sequence
f.effects<- c("gamma00","gamma01","gamma02","gamma03",
              "gamma10","gamma11","gamma12","gamma13")
dsp$yFE <- rowSums (dsp[,colnames(dsp) %in% f.effects],na.rm=TRUE)
head(dsp)

############################
## @knitr predictRE
# tau**sd - standard deviation, sqrt(tau00)
# dspCopy<- dsp
# dsp<- dspCopy
RE<- lme4:::ranef.merMod(model)$id 
RE$id=rownames(RE)
oldREnames<- c ("(Intercept)", "timec", "timec2", "timec3")
newREnames<- c("tau00sd","tau11sd", "tau22sd", "tau33sd")
for(i in 1:4)names(RE)[names(RE)==oldREnames[i]]=newREnames[i]
# head(RE)
# attach individual disturbances to dsp by id
dsp<- merge(dsp,RE, by="id" )
# head(dsp)

pullRandomEffect <- function (timeName,tauName){
  variableMissing <- !(tauName %in% colnames(dsp))
  if( variableMissing ) {
    return( rep(0, times=nrow(dsp)) )
  }
  else {
    possibleNAEffect <- dsp[,tauName]
    result <- ifelse( is.na(possibleNAEffect), 0,
                      possibleNAEffect*dsp[,timeName]) 
    return(result)
  }
}
# pullRandomEffect(timeName="timec3", tauName="tau33sd")

# and produce predictions using the time effects 
# note that tau00sd does not need transformation because it intercept ( *1)
dsp$tau11sd <- pullRandomEffect(timeName="timec", tauName="tau11sd")
dsp$tau22sd <- pullRandomEffect(timeName="timec2", tauName="tau22sd")
dsp$tau33sd <- pullRandomEffect(timeName="timec3", tauName="tau33sd")
head(dsp)


############################
## @knitr indDisturb 
r.effects<- c("tau00sd","tau11sd","tau22sd","tau33sd")
dsp$yRE <- rowSums (dsp[,colnames(dsp) %in% r.effects],na.rm=TRUE)

head(dsp)


############################
## @knitr predictions
ds<- dsp %>%
  dplyr::select(y,resid,yFE,yRE,yHat) %>%
  dplyr::mutate(
    yFERE=yFE+yRE, # predictions reconstructed manually
    residFERE= y- yFERE,
    residDif= resid- residFERE # residuals might slightly differ due to rounding
  ) 
# Check that the model solution deconstructed from fixed and random coefficient estimates (yFERE) matches the prediction produced by the built in function predict(model) or fitted(model).
all.equal(dsp$yHat1, dsp$yFERE)
head(ds,10)


############################
## @knitr residSE
sigma<-sigma(model) # std.error of scaled residuals 
SDR<-sd(dsp$resid) # st.deviation of the raw residuals, not scaled
sigma
SDR



############################
## @knitr combineResults
summary(model)
VarCorr(model)

mInfo # model information indices
head(RE,6) # random effect corrections for each (person x timepoint)
mRE  # variances and standard deviations of random effects
mREcov # covariance matrix of Random Effects
mREcor # correlation  matrix of Random Effects
FEt # estimates of Fixed Effects, SE, t-value
mFE # matrix of correlations among Fixed Effects
sigma # standard deviation of residual
head(dsp,13) # input + output + residual + conditional

# str(mFE)
# mFE@x
# mFE@Dimnames


a<- data.frame(FEt)
a$Coefficient <- rownames(a)
rowCountBeforeJoin <- nrow(a)

b<- as.data.frame(matrix(mFE@x, ncol=length(mFE@Dimnames[[1]]), byrow=TRUE, dimnames=mFE@Dimnames))
b$Coefficient <- rownames(b)

dsRE <- mRE
dsRE <- plyr::rename(dsRE, replace=c("var"="varRE", "sd"="sdRE"))
dsRE$Coefficient <- rownames(dsRE)

dsRECov <- mREcov
dsRECov <- plyr::rename(dsRECov, replace=c("X.Intercept."="intVarRE", "timec"="timecVarRE","timec2"="timec2VarRE","timec3"="timec3VarRE"),warn_missing = FALSE)
dsRECov$Coefficient <- rownames(dsRECov)

dsRECor <- mREcor
dsRECor <- plyr::rename(dsRECor, replace=c("X.Intercept."="intSDRE", "timec"="timecSDRE", "timec2"="timec2SDRE", "timec3"="timec3SDRE"),warn_missing = FALSE)
dsRECor$Coefficient <- rownames(dsRECor)

dsDaddy <- merge(x=a, y=b, by="Coefficient", all=TRUE)
dsDaddy <- merge(x=dsDaddy, y=dsRE, by="Coefficient", all=TRUE)
dsDaddy <- merge(x=dsDaddy, y=dsRECov, by="Coefficient", all=TRUE)
dsDaddy <- merge(x=dsDaddy, y=dsRECor, by="Coefficient", all=TRUE)
dsDaddy$sigma<- sigma # residual SD, must be squared to get sigma squared
dsDaddy$modelName<- modelName
testit::assert("The join shouldn't add new records.",  rowCountBeforeJoin==nrow(a))
testit::assert("The join shouldn't add new records.",  nrow(dsDaddy)==nrow(a))
testit::assert("The join shouldn't add new records.",  nrow(dsDaddy)==nrow(b))

dsmInfo<- data.frame(mInfo)
dsFERE<- dsDaddy
dsp<- data.frame(dsp)
dsp$modelName<-modelName

############################
## @knitr saveModelResults
modelName
pathdsmInfo <- file.path("./Models/LCM/models/datasets",paste0(modelName,"_mInfo.rds"))
pathdsFERE  <- file.path("./Models/LCM/models/datasets",paste0(modelName,"_FERE.rds"))
pathdsp  <- file.path("./Models/LCM/models/datasets",paste0(modelName,"_dsp.rds"))

saveRDS(object=dsmInfo, file=pathdsmInfo, compress="xz")
saveRDS(object=dsFERE, file=pathdsFERE, compress="xz")
saveRDS(object=dsp, file=pathdsp, compress="xz")

# } # end of the for loop
