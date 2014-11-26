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
source("./Models/LCM/LCModels2.R")

############################
## @knitr defineData
# numID<- 200 # highest id value (max = 9022)
numID <- 200 # highest id value (max = 9022)
### Define the data that will populate the model
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id < numID) %>%
  dplyr::filter(year %in% c(2000:2011)) %>% # 1997:2011
  dplyr::filter(sample %in% c(1)) %>% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(4)) %>% # 1-Black; 2-Hispanics; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %>% # birth year 1980:1984
  dplyr::filter(ave(!is.na(attend), id, FUN = all)) %>% # only complete trajectories
  dplyr::mutate( # compute new variables
    age= year-byear, # definition of age to be used in the model    
    timec=year-2000, # metric of time is rounds of NSLY97 in years, centered at 2000
    timec2= timec^2, 
    timec3= timec^3,
    #         timec= age-16, # metric of time is bilogical age in years, centered at 16
    #         timec2= timec^2,
    #         timec3= timec^3,# 
    cohort=byear-1980) %>% # age difference, years younger (unit - 1 cohort away)
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
# fnlme<- as.formula(call_m4F)
# model<- nlme::gls(fnlme, data=ds,method = "ML")
# modelF<-model
###################


allModels<- modelNamesLabels
# modelList1<- c(modelsR1, modelsFE)
# modelList1<- c(modelsR2, modelsR3, modelsR4) 
# allModels <-  "m0F"
# allModels <-  "m1F"
# allModels <-  "m0R1"
# allModels <-  "mFa"
# allModels <-  "mR1a"
# allModels <-   mR2i
fixedOnly <- c(mF, mFi)

for(i in allModels){
  modelName<- "m6R2"
  message("Running model ", modelName, " in singleModel_brief.R at ", Sys.time())
  modelCall<- paste0("call_",modelName)
    f<- as.formula(modelCall)
  isRandomModel <- !(modelName %in% fixedOnly)
  if( isRandomModel ){
    ########################################################################################
    # if model is estimated by lmer() - with random effects
    model <-lmer (f, data = ds, REML=FALSE, control=lmerControl(optCtrl=list(maxfun=20000)))
    
    ###########################
    # @knitr solveModel_lmer
    
    ## mInfo ##
    # model<- modelR
    mInfo<-summary(model)$AICtab
    mInfo["N"]<- model@devcomp$dims["N"] # number of datapoints, verify
    mInfo["p"]<- model@devcomp$dims["p"] # number of estimated parameters, verify
    mInfo["ids"]<- (summary(model))$ngrps # number of units on level-2, here: individuals
    # mInfo<- c(mInfo, "modelName"=modelName)
    dsmInfo<-data.frame(mInfo)
    dsmInfo<- plyr::rename(dsmInfo,replace= c("mInfo"=modelName))
    dsmInfo$Coefficient <- rownames(dsmInfo)
    dsmInfo # model information 
    
    ## dsFERE ##
    # model<- modelR
    FE<- fixef(model) # summary of fixed effects
    FEt<- summary(model)$coefficients # estimates of Fixed Effects, SE, t-value
    mFE<- (summary(model)$vcov@factors$correlation) # matrix of correlations among Fixed Effects
    mRE<-   data.frame(sd= (attr(summary(model)$varcor$id,"stddev"))) 
    mRE$var<- mRE$sd^2
    mRE<-mRE[c("var","sd")] # variances and standard deviations of random effects
    mREcov<-  data.frame(     summary(model)$varcor$id   ) # covariance matrix of RE
    mREcor<-  data.frame(attr(summary(model)$varcor$id,"correlation")) # corrleation matrix of RE
    sigma<- sigma(model) # standard deviation of residual
    
    a<- data.frame(FEt)
    a$Coefficient <- rownames(a)
    a<- plyr::rename(a,replace= c("Std..Error"="Std.Error"))
    rowCountBeforeJoin <- nrow(a)
    
    mFE<- (summary(model)$vcov@factors$correlation)
    b<- as.data.frame(matrix(mFE@x, ncol=length(mFE@Dimnames[[1]]), byrow=TRUE, dimnames=mFE@Dimnames))
    b$Coefficient <- rownames(b)
    
    dsRE <- mRE
    dsRE <- plyr::rename(dsRE, replace=c("var"="varRE", "sd"="sdRE"))
    dsRE$Coefficient <- rownames(dsRE)
    
    dsRECov <- mREcov
    ## - change here: if variables do not exist, create them anyway and populate with zeros
    dsRECov <- plyr::rename(dsRECov, replace=c("X.Intercept."="intVarRE", "timec"="timecVarRE","timec2"="timec2VarRE","timec3"="timec3VarRE"),warn_missing = FALSE)
    dsRECov$Coefficient <- rownames(dsRECov)
    
    dsRECor <- mREcor
    ## - change here: if variables do not exist, create them anyway and populate with zeros
    dsRECor <- plyr::rename(dsRECor, replace=c("X.Intercept."="intSDRE", "timec"="timecSDRE", "timec2"="timec2SDRE", "timec3"="timec3SDRE"),warn_missing = FALSE)
    dsRECor$Coefficient <- rownames(dsRECor)
    
    dsFERE <- merge(x=a, y=b, by="Coefficient", all=TRUE)
    dsFERE <- merge(x=dsFERE, y=dsRE, by="Coefficient", all=TRUE)
    dsFERE <- merge(x=dsFERE, y=dsRECov, by="Coefficient", all=TRUE)
    dsFERE <- merge(x=dsFERE, y=dsRECor, by="Coefficient", all=TRUE)
    dsFERE$sigma<- sigma # residual SD, must be squared to get sigma squared
    # dsFERE$modelName<- modelName
    testit::assert("The join shouldn't add new records.",  rowCountBeforeJoin==nrow(a))
    testit::assert("The join shouldn't add new records.",  nrow(dsFERE)==nrow(a))
    testit::assert("The join shouldn't add new records.",  nrow(dsFERE)==nrow(b))
    dsFERE$sigma<- sigma # residual SD, must be squared to get sigma squared
    # dsFERE$modelName<-modelName
    head(dsFERE)
    
    ## dsp ## - deconstructing predictions
    
    # model<- modelR
    dsp<- data.frame(getME(model,"X")) # get the model frame
    dsp$id<-getME(model,"flist")$id # first level grouping factor, individual
    dsp$y<-getME(model,"y") # observed response vector
    dsp$yHat<- predict(model) # predicted values
    dsp$resid<- lme4:::residuals.merMod(model)
    head(dsp,13)
    
    # Deconstructed effects 
    # Fixed Effects 
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
    # note that tau00sd does not need transformation because it alwyas 1 
    dsp$tau11sd <- pullRandomEffect(timeName="timec", tauName="tau11sd")
    dsp$tau22sd <- pullRandomEffect(timeName="timec2", tauName="tau22sd")
    dsp$tau33sd <- pullRandomEffect(timeName="timec3", tauName="tau33sd")
    head(dsp)
    
    r.effects<- c("tau00sd","tau11sd","tau22sd","tau33sd")
    dsp$yRE <- rowSums (dsp[,colnames(dsp) %in% r.effects],na.rm=TRUE)
    head(dsp)
    
    # Check that the model solution deconstructed from fixed and random coefficient estimates (yFERE) matches the prediction produced by the built in function predict(model) or fitted(model).
    d<- dsp %>%
      dplyr::select(y,resid,yFE,yRE,yHat) %>%
      dplyr::mutate(
        yFERE=yFE+yRE, # predictions reconstructed manually
        residFERE= y- yFERE,
        residDif= resid- residFERE # residuals might slightly differ due to rounding
      ) 
    head(d,10)
    all.equal(dsp$yHat1, dsp$yFERE)
    dsp$modelName<-modelName
    
    dsp<- data.frame(dsp)    
  }
  else{
    ###########################################################################################
    ############################
    ## @knitr solveModel_gls
    # if model is estimaged with nlme::gls - fixed effects, but with correlated residuals/uniqual variances
    model<- nlme::gls(f, data=ds,method = "ML")
    
    ## mInfo ##
    # model<- modelF
    AIC<- AIC(model)
    BIC<- BIC(model)
    logLik<- summary(model)$logLik
    deviance<- -2*logLik
    df.resid<- NA
    N<- summary(model)$dims$N
    p<- summary(model)$dims$p
    ids<- length(unique(ds$id))
    df.resid<- N-p
    
    mInfo<- data.frame("AIC" = AIC, "BIC" = BIC, "logLik" = logLik, "deviance"=deviance,
                       "df.resid"=df.resid, "N"=N, "p"=p, "ids"=ids)
    t<- t(mInfo)
    rownames(t)<-colnames(mInfo)
    dsmInfo<- data.frame(new=t)
    colnames(dsmInfo)<- c(modelName)
    dsmInfo$Coefficient <- rownames(dsmInfo)
    dsmInfo
    
    ## dsFERE
    # model<- modelF
    FEt<- summary(model)$tTable
    mFE<- (summary(model)$corBeta)
    sigma<-model$sigma # std.error of scaled residuals 
        
    a<- data.frame(FEt)
    a$Coefficient <- rownames(a)
    
    b<- as.data.frame(mFE)
    b$Coefficient <- rownames(b)
        
    #TODO: finsh you rarchitect how files are created and retrieve, 
    #  please don't keep using this hack that adds the `timec` row to an Anova table (intentionally) missing that variable
    missingTime <- !("timec" %in% a$Coefficient)
    if( missingTime ) {
      blankRowA <- a[1, ]
      blankRowA[1, seq_len(ncol(a))] <- NA
      blankRowA[1, "Coefficient"] <- "timec"
      a <- plyr::rbind.fill(a, blankRowA)
      rownames(a) <- a$Coefficient
      
      blankRowB <- b[1, ]
      blankRowB[1, seq_len(ncol(b))] <- NA
      blankRowB[1, "Coefficient"] <- "timec"
      b <- plyr::rbind.fill(b, blankRowB)
      b$timec <- NA
      b[b$Coefficient=="timec", "timec"] <- 1
      rownames(b) <- b$Coefficient
      # b <- b[, c("(Intercept)", "timec", "Coefficient")]
    }
        
    rowCountBeforeJoin <- nrow(a)
    
    dsRE <- data.frame( row.names=rownames(b),VarRE=rep(0,nrow(b)))
    dsRE$Coefficient <- rownames(dsRE)
    
    dsRECov <- data.frame( row.names=rownames(b),intVarRE=rep(0,nrow(b)))
    dsRECov$Coefficient <- rownames(dsRECov)
    
    dsRECor <- data.frame( row.names=rownames(b),intSDRE=rep(0,nrow(b)))
    dsRECor$Coefficient <- rownames(dsRECor)
    
    dsFERE <- merge(x=a, y=b, by="Coefficient", all=TRUE)
    dsFERE <- merge(x=dsFERE, y=dsRE, by="Coefficient", all=TRUE)
    dsFERE <- merge(x=dsFERE, y=dsRECov, by="Coefficient", all=TRUE)
    dsFERE <- merge(x=dsFERE, y=dsRECor, by="Coefficient", all=TRUE)
    dsFERE$sigma<- sigma # residual SD, must be squared to get sigma squared
    # dsFERE$modelName<- modelName
    testit::assert("The join shouldn't add new records.",  rowCountBeforeJoin==nrow(a))
    testit::assert("The join shouldn't add new records.",  nrow(dsFERE)==nrow(a))
    testit::assert("The join shouldn't add new records.",  nrow(dsFERE)==nrow(b))
    
    dsFERE<- dsFERE
    head(dsFERE)     
    
    ## dsp ## - deconstructing predictions
    # modelF<-model
    # model<-modelF
    #TODO: my guess is it's better/safer to start with a (trimmed/narrowed ds), then merge the dsp variables of yHad and residual
    # dsNarrow <- ds[, c("id", "timec")]
    
    dsp<-(lm(f, data=ds))$model
    dsp$id<- ds$id
    dsp$timec <- ds$timec
    dsp$yHat<- fitted(model)
    dsp$resid<- residuals(model)
    head(dsp,13)    
    
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
    
    FE<- summary(model)$coefficients
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
    # note that tau00sd stays here just to create the column
    dsp$tau00sd <- 0
    dsp$tau11sd <- pullRandomEffect(timeName="timec", tauName="tau11sd")
    dsp$tau22sd <- pullRandomEffect(timeName="timec2", tauName="tau22sd")
    dsp$tau33sd <- pullRandomEffect(timeName="timec3", tauName="tau33sd")
  } # close else
  
  #TODO: fix this hack
  missingTimeInDsp <- !("timec" %in% colnames(dsp))
  if( missingTimeInDsp ) {
#     dsTimeOnly <- ds[]
    #TODO: the 'timec' variable needs to be merged into the dsp dataset, using the ds dataset.
    #  However, there's not a good set of variables to match on.
    dsp$timec <- NA_real_
  }
  head(dsp)
  
  ###########################################################################################
  ## @knitr saveModelResults
  modelName
  pathdsmInfo <- file.path("./Models/LCM/models/datasets",paste0(modelName,"_mInfo.rds"))
  pathdsFERE  <- file.path("./Models/LCM/models/datasets",paste0(modelName,"_FERE.rds"))
  pathdsp  <- file.path("./Models/LCM/models/datasets",paste0(modelName,"_dsp.rds"))
  
  saveRDS(object=dsmInfo, file=pathdsmInfo, compress="xz")
  saveRDS(object=dsFERE, file=pathdsFERE, compress="xz")
  saveRDS(object=dsp, file=pathdsp, compress="xz")

} # end of the for loop
