require(nlme)
require(dplyr)
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
head(ds)

m <- nlme::gls(attend ~ 1 + timec + timec2 + timec3, data=ds)
summary(m)
# model performance 
m$logLik 
m$BIC
m$AIC
# fixed effects 
m$coefficients
m$tTable
# correlation matrix of betas
m$corBeta
m$varBeta # covariance 

m$fitted 
m$residuals
m$sigma


n<- lm( attend ~ 1 + timec + timec2 + timec3, data=ds)
summary(n)
n<-str(summary(n))
n$model
