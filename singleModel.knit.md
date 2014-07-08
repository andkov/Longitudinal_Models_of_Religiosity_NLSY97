---
title: "Single model"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 2
    fig_width: 8
    toc: yes
  md_document:
    toc: yes
    toc_depth: 3
  pdf_document:
    fig_crop: no
    fig_width: 8
    highlight: haddock
    latex_engine: xelatex
    number_sections: yes
    toc: yes
    toc_depth: 3
  word_document:
    fig_width: 6.5
mainfont: Calibri
---

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->









# Model specification   
The model is of the class
![LCM_Specification](../../images/WideSpecification_Guide.png)

# Sequence specification  
![Sequence_Specification](../../images/SequenceMap_Web.png)

# Model and Data specification

```r
cat("\014") # clears console
```



```r
modelNumber<- "m7R"
numID<- 200

modnum<-cat(modelNumber)
```

```
m7R
```

```r
dsL<-readRDS("./Data/Derived/dsL.rds")
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id %in% c(1:numID)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(1)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(4)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %.% # birth year 1980:1984
  dplyr::filter(ave(!is.na(attend), id, FUN = all)) %.% # only complete trajectories
  dplyr::mutate( # create new variables
        age= year-byear, # definition of age to be used in the model    
        timec=year-2000, # metric of time is rounds of NSLY97 in years, centered at 2000
        timec2= timec^2, 
        timec3= timec^3,
#         timec= age-16, # metric of time is bilogical age in years, centered at 16
#         timec2= timec^2,
#         timec3= timec^3,# 
        cohort=byear-1980) %.% # age difference, years younger
  dplyr::select( # assemble the dataset for modeling
    id, sample, race, byear,cohort, # Time Invariant variables
    year,
    age, timec,timec2,timec3, attend)  # Time Variant variables
head(ds)
```

```
  id sample race byear cohort year age timec timec2 timec3 attend
1  1      1    4  1981      1 2000  19     0      0      0      1
2  1      1    4  1981      1 2001  20     1      1      1      6
3  1      1    4  1981      1 2002  21     2      4      8      2
4  1      1    4  1981      1 2003  22     3      9     27      1
5  1      1    4  1981      1 2004  23     4     16     64      1
6  1      1    4  1981      1 2005  24     5     25    125      1
```

```r
table(ds$byear) # the year of birth  - metric: YEAR 
```

```

1980 1981 1982 1983 1984 
 108   84  132   60  108 
```

```r
table(ds$age) # years past 16 -  metric: AGE
```

```

16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
 9 14 25 32 41 41 41 41 41 41 41 41 32 27 16  9 
```

```r
table(ds$year, ds$age) # YEAR by  AGE 
```

```
      
       16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
  2000  9  5 11  7  9  0  0  0  0  0  0  0  0  0  0  0
  2001  0  9  5 11  7  9  0  0  0  0  0  0  0  0  0  0
  2002  0  0  9  5 11  7  9  0  0  0  0  0  0  0  0  0
  2003  0  0  0  9  5 11  7  9  0  0  0  0  0  0  0  0
  2004  0  0  0  0  9  5 11  7  9  0  0  0  0  0  0  0
  2005  0  0  0  0  0  9  5 11  7  9  0  0  0  0  0  0
  2006  0  0  0  0  0  0  9  5 11  7  9  0  0  0  0  0
  2007  0  0  0  0  0  0  0  9  5 11  7  9  0  0  0  0
  2008  0  0  0  0  0  0  0  0  9  5 11  7  9  0  0  0
  2009  0  0  0  0  0  0  0  0  0  9  5 11  7  9  0  0
  2010  0  0  0  0  0  0  0  0  0  0  9  5 11  7  9  0
  2011  0  0  0  0  0  0  0  0  0  0  0  9  5 11  7  9
```

```r
length(unique(ds$id)) # total No. of respondents in dataset
```

```
[1] 41
```

```r
sum(!is.na(ds$attend)) # valid datapoints 
```

```
[1] 492
```

```r
sum(is.na(ds$attend)) # NA in the dataset 
```

```
[1] 0
```

```r
length(unique(ds$timec))
```

```
[1] 12
```

```r
# Estimate the model
modnum <-lmer (attend ~ 
               1  + timec + timec2 + timec3
       + cohort + cohort:timec # + cohort:timec2 + cohort:timec3
              + (1 + timec  | id),
             data = ds, REML=FALSE, 
             control=lmerControl(optCtrl=list(maxfun=20000)))
        
model<- modnum
```

# Model results

# Basic elements of the S4 object

The full model summary can be accessed by command:

```r
summary(model) 
```

```
Linear mixed model fit by maximum likelihood  ['lmerMod']
Formula: attend ~ 1 + timec + timec2 + timec3 + cohort + cohort:timec +      (1 + timec | id)
   Data: ds
Control: lmerControl(optCtrl = list(maxfun = 20000))

     AIC      BIC   logLik deviance df.resid 
    1394     1436     -687     1374      482 

Scaled residuals: 
   Min     1Q Median     3Q    Max 
-2.629 -0.491 -0.078  0.376  4.441 

Random effects:
 Groups   Name        Variance Std.Dev. Corr 
 id       (Intercept) 1.7088   1.307         
          timec       0.0267   0.164    -0.72
 Residual             0.6445   0.803         
Number of obs: 492, groups: id, 41

Fixed effects:
             Estimate Std. Error t value
(Intercept)   2.46533    0.37385    6.59
timec        -0.43522    0.10080   -4.32
timec2        0.06582    0.01953    3.37
timec3       -0.00266    0.00116   -2.28
cohort        0.35213    0.15044    2.34
timec:cohort -0.04354    0.01930   -2.26

Correlation of Fixed Effects:
            (Intr) timec  timec2 timec3 cohort
timec       -0.518                            
timec2       0.181 -0.857                     
timec3      -0.154  0.803 -0.984              
cohort      -0.785  0.274  0.000  0.000       
timec:cohrt  0.576 -0.374  0.000  0.000 -0.733
```

After studying 

```r
str(summary(model)$vcov@x)
str(summary(model)$varcor)
```
we can spot a few complex elements that would be particularly useful

str(summary(model)$varcor)


## Model formula

```r
model@call 
```

```
lmer(formula = attend ~ 1 + timec + timec2 + timec3 + cohort + 
    cohort:timec + (1 + timec | id), data = ds, REML = FALSE, 
    control = lmerControl(optCtrl = list(maxfun = 20000)))
```

## Fit and Information indices


```r
# get indicies
mInfo<-summary(model)$AICtab
mInfo["N"]<- model@devcomp$dims["N"] # number of datapoints, verify
mInfo["p"]<- model@devcomp$dims["p"] # number of estimated parameters, verify
mInfo["ids"]<- (summary(model))$ngrps # number of units on level-2, here: individuals
mInfo
```

```
     AIC      BIC   logLik deviance df.resid        N        p      ids 
    1394     1436     -687     1374      482      492        6       41 
```

## Random Effects (RE)

### Matrix of RE

```r
# extract RE covariance matrix
mREcov<-  data.frame(     summary(model)$varcor$id   ) # covariance matrix of RE
mREcor<-  data.frame(attr(summary(model)$varcor$id,"correlation")) # corrleation matrix of RE
mRE<-   data.frame(sd= (attr(summary(model)$varcor$id,"stddev")))
mRE$var<- mRE$sd^2
mRE<-mRE[c("var","sd")]
mRE
```

```
                var     sd
(Intercept) 1.70881 1.3072
timec       0.02674 0.1635
```

```r
mREcov
```

```
            X.Intercept.    timec
(Intercept)       1.7088 -0.15385
timec            -0.1538  0.02674
```

### extracting RE for each individual

```r
RE<- lme4:::ranef.merMod(model)$id 
head(RE,6)
```

```
   (Intercept)     timec
1       0.1427 -0.110025
33      0.4208 -0.013628
34     -0.7968  0.016958
35     -1.8115  0.120826
37     -0.6598  0.026282
38     -0.7993  0.004015
```

```r
# however
cor(RE)  # in unadjusted RE estimates, not same as mRE
```

```
            (Intercept)  timec
(Intercept)       1.000 -0.706
timec            -0.706  1.000
```

```r
var(RE)  # in unadjusted RE estimates, not same as mRE
```

```
            (Intercept)    timec
(Intercept)      1.5796 -0.13589
timec           -0.1359  0.02345
```

```r
mRE
```

```
                var     sd
(Intercept) 1.70881 1.3072
timec       0.02674 0.1635
```

## Fixed Effects (FE)


### estimate of the FE

```r
# similar ways to extract FE estimates, #3 is the fullest
FE<- fixef(model)  
FE # vector used in predition
```

```
 (Intercept)        timec       timec2       timec3       cohort timec:cohort 
    2.465330    -0.435217     0.065823    -0.002659     0.352132    -0.043539 
```

```r
FEt<- summary(model)$coefficients
FEt # contains t-values that test the terms
```

```
              Estimate Std. Error t value
(Intercept)   2.465330   0.373848   6.594
timec        -0.435217   0.100799  -4.318
timec2        0.065823   0.019526   3.371
timec3       -0.002659   0.001165  -2.283
cohort        0.352132   0.150438   2.341
timec:cohort -0.043539   0.019297  -2.256
```

### Matrix of FE

```r
mFE<- (summary(model)$vcov@factors$correlation) # notice that this is object of 
mFE
```

```
6 x 6 Matrix of class "corMatrix"
             (Intercept)   timec     timec2     timec3     cohort timec:cohort
(Intercept)       1.0000 -0.5177  1.814e-01 -1.542e-01 -7.852e-01    5.758e-01
timec            -0.5177  1.0000 -8.566e-01  8.032e-01  2.740e-01   -3.736e-01
timec2            0.1814 -0.8566  1.000e+00 -9.844e-01 -1.246e-15    2.880e-14
timec3           -0.1542  0.8032 -9.844e-01  1.000e+00  6.962e-16   -2.875e-14
cohort           -0.7852  0.2740 -1.246e-15  6.962e-16  1.000e+00   -7.334e-01
timec:cohort      0.5758 -0.3736  2.880e-14 -2.875e-14 -7.334e-01    1.000e+00
```


## Model output

```r
# Read back when went into the model
cat("\014")
```



```r
dsp<- data.frame(getME(model,"X"))
dsp$id<-getME(model,"flist")$id # first level grouping factor, individual
dsp$y<-getME(model,"y") # observed response vector
head(dsp,13)
```

```
   X.Intercept. timec timec2 timec3 cohort timec.cohort id y
1             1     0      0      0      1            0  1 1
2             1     1      1      1      1            1  1 6
3             1     2      4      8      1            2  1 2
4             1     3      9     27      1            3  1 1
5             1     4     16     64      1            4  1 1
6             1     5     25    125      1            5  1 1
7             1     6     36    216      1            6  1 1
8             1     7     49    343      1            7  1 1
9             1     8     64    512      1            8  1 1
10            1     9     81    729      1            9  1 1
11            1    10    100   1000      1           10  1 1
12            1    11    121   1331      1           11  1 1
13            1     0      0      0      0            0 33 2
```

### Prediction and Residuals


```r
cat("\014")
```



```r
dsp$yHat<- predict(model) # predicted values
dsp$resid<- lme4:::residuals.merMod(model)
head(dsp,13)
```

```
   X.Intercept. timec timec2 timec3 cohort timec.cohort id y   yHat     resid
1             1     0      0      0      1            0  1 1 2.9601 -1.960132
2             1     1      1      1      1            1  1 6 2.4345  3.565485
3             1     2      4      8      1            2  1 2 2.0246 -0.024587
4             1     3      9     27      1            3  1 1 1.7144 -0.714391
5             1     4     16     64      1            4  1 1 1.4880 -0.487971
6             1     5     25    125      1            5  1 1 1.3294 -0.329369
7             1     6     36    216      1            6  1 1 1.2226 -0.222628
8             1     7     49    343      1            7  1 1 1.1518 -0.151792
9             1     8     64    512      1            8  1 1 1.1009 -0.100904
10            1     9     81    729      1            9  1 1 1.0540 -0.054006
11            1    10    100   1000      1           10  1 1 0.9951  0.004858
12            1    11    121   1331      1           11  1 1 0.9084  0.091646
13            1     0      0      0      0            0 33 2 2.8862 -0.886172
```

```r
identical ( dsp$y-dsp$yHat, dsp$resid) # check if adds up
```

```
[1] TRUE
```

## Conditional values
The fixed effects  collectivelly define a trajectory that summarises differences among individuals. Uusing the values of the estimated parameters, we reconstruct the trjecectory from which the individual trajectories vary, according to the estimated random effects, if present in the model.

The columns named as fixed effect coefficients (gamma00:gammaKP), contain  predicted trajectories of the outcome (y), computed using only the correspodning term (gamma coefficient x predictor(s), if present). Thus, collumn *gamma00* contains the predicted trajectory of church attendance cumputed using only the grand mean (gamma00) of the current model specification. 


```r
cat("\014")
```



```r
head(dsp)
```

```
  X.Intercept. timec timec2 timec3 cohort timec.cohort id y  yHat    resid
1            1     0      0      0      1            0  1 1 2.960 -1.96013
2            1     1      1      1      1            1  1 6 2.435  3.56549
3            1     2      4      8      1            2  1 2 2.025 -0.02459
4            1     3      9     27      1            3  1 1 1.714 -0.71439
5            1     4     16     64      1            4  1 1 1.488 -0.48797
6            1     5     25    125      1            5  1 1 1.329 -0.32937
```

```r
dsp$gamma00<- ifelse( is.na(FE["(Intercept)"]),0,FE["(Intercept)"])
head(dsp)
```

```
  X.Intercept. timec timec2 timec3 cohort timec.cohort id y  yHat    resid gamma00
1            1     0      0      0      1            0  1 1 2.960 -1.96013   2.465
2            1     1      1      1      1            1  1 6 2.435  3.56549   2.465
3            1     2      4      8      1            2  1 2 2.025 -0.02459   2.465
4            1     3      9     27      1            3  1 1 1.714 -0.71439   2.465
5            1     4     16     64      1            4  1 1 1.488 -0.48797   2.465
6            1     5     25    125      1            5  1 1 1.329 -0.32937   2.465
```

The effects that were not present in the model will be substituted with zeros. 

```r
# cat("\014")
# dsp<- data.frame(getME(model,"X")) # read back the input 
# dsp$id<-getME(model,"flist")$id # first level grouping factor, individual
# dsp$y<-getME(model,"y") # observed response vector
# head(dsp,13)

model@call
```

```
lmer(formula = attend ~ 1 + timec + timec2 + timec3 + cohort + 
    cohort:timec + (1 + timec | id), data = ds, REML = FALSE, 
    control = lmerControl(optCtrl = list(maxfun = 20000)))
```

```r
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
```

```
  X.Intercept. timec timec2 timec3 cohort timec.cohort id y  yHat    resid gamma00 gamma01 gamma02   gamma03 gamma10
1            1     0      0      0      1            0  1 1 2.960 -1.96013   2.465  0.0000 0.00000  0.000000  0.3521
2            1     1      1      1      1            1  1 6 2.435  3.56549   2.465 -0.4352 0.06582 -0.002659  0.3521
3            1     2      4      8      1            2  1 2 2.025 -0.02459   2.465 -0.8704 0.26329 -0.021276  0.3521
4            1     3      9     27      1            3  1 1 1.714 -0.71439   2.465 -1.3056 0.59241 -0.071806  0.3521
5            1     4     16     64      1            4  1 1 1.488 -0.48797   2.465 -1.7409 1.05317 -0.170207  0.3521
6            1     5     25    125      1            5  1 1 1.329 -0.32937   2.465 -2.1761 1.64558 -0.332436  0.3521
   gamma11 gamma12 gamma13   yFE
1  0.00000       0       0 2.817
2 -0.04354       0       0 2.402
3 -0.08708       0       0 2.102
4 -0.13062       0       0 1.902
5 -0.17415       0       0 1.785
6 -0.21769       0       0 1.737
```

Of particular interest is variable **yFE** which has several interpretations. It is:      
  0. the sum of all estimated fixed effects (gamma00:gammaKP) in (person x timepoint) cell    
  1. the overall model solution for the interindividual  differences   
  2. the average intraindividual pattern     
  3. the prediction of the model with interindividual variability factored out, as opposed to **yHat**, generated using both fixed and random effect(s) coefficients.  

The deviations from this average trajectory will be recorded in **RE**, containing a column for each of the random effects estimated.  















