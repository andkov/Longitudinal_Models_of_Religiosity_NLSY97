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
       + cohort + cohort:timec  #+ cohort:timec2 # + cohort:timec3
              + (1 + timec + timec2  | id),
             data = ds, REML=FALSE, 
             control=lmerControl(optCtrl=list(maxfun=20000)))
```

```
Warning: Model failed to converge with max|grad| = 0.0777238 (tol = 0.002)
```

```r
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
Formula: attend ~ 1 + timec + timec2 + timec3 + cohort + cohort:timec +      (1 + timec + timec2 | id)
   Data: ds
Control: lmerControl(optCtrl = list(maxfun = 20000))

     AIC      BIC   logLik deviance df.resid 
  1375.5   1430.0   -674.7   1349.5      479 

Scaled residuals: 
   Min     1Q Median     3Q    Max 
-3.091 -0.390 -0.082  0.328  4.574 

Random effects:
 Groups   Name        Variance Std.Dev. Corr       
 id       (Intercept) 2.600432 1.6126              
          timec       0.145531 0.3815   -0.83      
          timec2      0.000498 0.0223    0.77 -0.95
 Residual             0.577985 0.7603              
Number of obs: 492, groups: id, 41

Fixed effects:
             Estimate Std. Error t value
(Intercept)   2.64733    0.37948    6.98
timec        -0.46069    0.10910   -4.22
timec2        0.06582    0.01882    3.50
timec3       -0.00266    0.00110   -2.41
cohort        0.25885    0.13549    1.91
timec:cohort -0.03048    0.01699   -1.79

Correlation of Fixed Effects:
            (Intr) timec  timec2 timec3 cohort
timec       -0.609                            
timec2       0.262 -0.833                     
timec3      -0.144  0.703 -0.967              
cohort      -0.697  0.202  0.000  0.000       
timec:cohrt  0.463 -0.304  0.000  0.000 -0.665
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
    cohort:timec + (1 + timec + timec2 | id), data = ds, REML = FALSE, 
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
  1375.5   1430.0   -674.7   1349.5    479.0    492.0      6.0     41.0 
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
                  var      sd
(Intercept) 2.6004323 1.61259
timec       0.1455313 0.38149
timec2      0.0004985 0.02233
```

```r
mREcov
```

```
            X.Intercept.     timec     timec2
(Intercept)      2.60043 -0.513474  0.0278655
timec           -0.51347  0.145531 -0.0081042
timec2           0.02787 -0.008104  0.0004985
```

### extracting RE for each individual

```r
RE<- lme4:::ranef.merMod(model)$id 
head(RE,6)
```

```
   (Intercept)    timec    timec2
1      0.22877 -0.19267  0.008214
33    -0.04575  0.15234 -0.011696
34    -0.73325  0.04679 -0.004558
35    -2.09082  0.31074 -0.017867
37    -1.12394  0.20507 -0.013459
38    -1.13671  0.14570 -0.011178
```

```r
# however
cor(RE)  # in unadjusted RE estimates, not same as mRE
```

```
            (Intercept)   timec  timec2
(Intercept)      1.0000 -0.8442  0.8418
timec           -0.8442  1.0000 -0.9711
timec2           0.8418 -0.9711  1.0000
```

```r
var(RE)  # in unadjusted RE estimates, not same as mRE
```

```
            (Intercept)     timec     timec2
(Intercept)     2.41106 -0.455341  0.0241825
timec          -0.45534  0.120676 -0.0062409
timec2          0.02418 -0.006241  0.0003423
```

```r
mRE
```

```
                  var      sd
(Intercept) 2.6004323 1.61259
timec       0.1455313 0.38149
timec2      0.0004985 0.02233
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
    2.647335    -0.460691     0.065823    -0.002659     0.258855    -0.030483 
```

```r
FEt<- summary(model)$coefficients
FEt # contains t-values that test the terms
```

```
              Estimate Std. Error t value
(Intercept)   2.647335   0.379478   6.976
timec        -0.460691   0.109105  -4.222
timec2        0.065823   0.018817   3.498
timec3       -0.002659   0.001103  -2.411
cohort        0.258855   0.135487   1.911
timec:cohort -0.030483   0.016989  -1.794
```

### Matrix of FE

```r
mFE<- (summary(model)$vcov@factors$correlation) # notice that this is object of 
mFE
```

```
6 x 6 Matrix of class "corMatrix"
             (Intercept)   timec     timec2     timec3     cohort timec:cohort
(Intercept)       1.0000 -0.6089  2.615e-01 -1.439e-01 -6.967e-01    4.633e-01
timec            -0.6089  1.0000 -8.327e-01  7.027e-01  2.021e-01   -3.038e-01
timec2            0.2615 -0.8327  1.000e+00 -9.674e-01 -6.765e-15   -9.909e-14
timec3           -0.1439  0.7027 -9.674e-01  1.000e+00 -1.086e-14    1.101e-13
cohort           -0.6967  0.2021 -6.765e-15 -1.086e-14  1.000e+00   -6.650e-01
timec:cohort      0.4633 -0.3038 -9.909e-14  1.101e-13 -6.650e-01    1.000e+00
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
   X.Intercept. timec timec2 timec3 cohort timec.cohort id y  yHat    resid
1             1     0      0      0      1            0  1 1 3.135 -2.13496
2             1     1      1      1      1            1  1 6 2.522  3.47750
3             1     2      4      8      1            2  1 2 2.042 -0.04215
4             1     3      9     27      1            3  1 1 1.678 -0.67797
5             1     4     16     64      1            4  1 1 1.414 -0.41399
6             1     5     25    125      1            5  1 1 1.234 -0.23425
7             1     6     36    216      1            6  1 1 1.123 -0.12281
8             1     7     49    343      1            7  1 1 1.064 -0.06370
9             1     8     64    512      1            8  1 1 1.041 -0.04096
10            1     9     81    729      1            9  1 1 1.039 -0.03864
11            1    10    100   1000      1           10  1 1 1.041 -0.04079
12            1    11    121   1331      1           11  1 1 1.031 -0.03144
13            1     0      0      0      0            0 33 2 2.602 -0.60159
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
1            1     0      0      0      1            0  1 1 3.135 -2.13496
2            1     1      1      1      1            1  1 6 2.522  3.47750
3            1     2      4      8      1            2  1 2 2.042 -0.04215
4            1     3      9     27      1            3  1 1 1.678 -0.67797
5            1     4     16     64      1            4  1 1 1.414 -0.41399
6            1     5     25    125      1            5  1 1 1.234 -0.23425
```

```r
dsp$gamma00<- ifelse( is.na(FE["(Intercept)"]),0,FE["(Intercept)"])
head(dsp)
```

```
  X.Intercept. timec timec2 timec3 cohort timec.cohort id y  yHat    resid gamma00
1            1     0      0      0      1            0  1 1 3.135 -2.13496   2.647
2            1     1      1      1      1            1  1 6 2.522  3.47750   2.647
3            1     2      4      8      1            2  1 2 2.042 -0.04215   2.647
4            1     3      9     27      1            3  1 1 1.678 -0.67797   2.647
5            1     4     16     64      1            4  1 1 1.414 -0.41399   2.647
6            1     5     25    125      1            5  1 1 1.234 -0.23425   2.647
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
    cohort:timec + (1 + timec + timec2 | id), data = ds, REML = FALSE, 
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
1            1     0      0      0      1            0  1 1 3.135 -2.13496   2.647  0.0000 0.00000  0.000000  0.2589
2            1     1      1      1      1            1  1 6 2.522  3.47750   2.647 -0.4607 0.06582 -0.002659  0.2589
3            1     2      4      8      1            2  1 2 2.042 -0.04215   2.647 -0.9214 0.26329 -0.021276  0.2589
4            1     3      9     27      1            3  1 1 1.678 -0.67797   2.647 -1.3821 0.59241 -0.071806  0.2589
5            1     4     16     64      1            4  1 1 1.414 -0.41399   2.647 -1.8428 1.05317 -0.170207  0.2589
6            1     5     25    125      1            5  1 1 1.234 -0.23425   2.647 -2.3035 1.64558 -0.332436  0.2589
   gamma11 gamma12 gamma13   yFE
1  0.00000       0       0 2.906
2 -0.03048       0       0 2.478
3 -0.06097       0       0 2.166
4 -0.09145       0       0 1.953
5 -0.12193       0       0 1.824
6 -0.15241       0       0 1.763
```

Of particular interest is variable **yFE** which has several interpretations. It is:      
  0. the sum of all estimated fixed effects (gamma00:gammaKP) in (person x timepoint) cell    
  1. the overall model solution for the interindividual  differences   
  2. the average intraindividual pattern     
  3. the prediction of the model with interindividual variability factored out, as opposed to **yHat**, generated using both fixed and random effect(s) coefficients.  

The deviations from this average trajectory will be recorded in **RE**, containing a column for each of the random effects estimated.  















