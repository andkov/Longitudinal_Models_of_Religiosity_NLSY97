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











```r
cat("\014") # clears console
```



```r
modelNumber<- "m10"
numID<- 9022

modnum<-cat(modelNumber)
```

```
m10
```

```r
dsL<-readRDS("./Data/Derived/dsL.rds")
ds<- dsL %>%  # chose conditions to apply in creating ds for modeling
  dplyr::filter(id %in% c(1:numID)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(1)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(4)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %.% # 1980:1984
#   dplyr::filter(ave(!is.na(attend), id, FUN = all)) %.% # remove ids with NA
  dplyr::mutate( # create new variables
        timec=year-2000, # time centered at 2000, years since 2000
        timec2= timec^2, 
        timec3= timec^3,
        age= year-byear,
        agec= year-byear-16,
        agec2= agec^2,
        agec3= agec^3,# age centered at 16, years since 16 
        cohort=byear-1980) %.% # age difference, years younger
  dplyr::select( # assemble the dataset for modeling
    id,idF, sample, race, byear,cohort, # Time Invariant variables
    year,
    timec,timec2, timec3, attend, agec, agec2, agec3)  # Time Variant variables
head(ds, 13)
```

```
   id idF sample race byear cohort year timec timec2 timec3 attend agec agec2 agec3
1   1   1      1    4  1981      1 2000     0      0      0      1    3     9    27
2   1   1      1    4  1981      1 2001     1      1      1      6    4    16    64
3   1   1      1    4  1981      1 2002     2      4      8      2    5    25   125
4   1   1      1    4  1981      1 2003     3      9     27      1    6    36   216
5   1   1      1    4  1981      1 2004     4     16     64      1    7    49   343
6   1   1      1    4  1981      1 2005     5     25    125      1    8    64   512
7   1   1      1    4  1981      1 2006     6     36    216      1    9    81   729
8   1   1      1    4  1981      1 2007     7     49    343      1   10   100  1000
9   1   1      1    4  1981      1 2008     8     64    512      1   11   121  1331
10  1   1      1    4  1981      1 2009     9     81    729      1   12   144  1728
11  1   1      1    4  1981      1 2010    10    100   1000      1   13   169  2197
12  1   1      1    4  1981      1 2011    11    121   1331      1   14   196  2744
13  8   8      1    4  1981      1 2000     0      0      0      2    3     9    27
```

```r
table(ds$byear) # the year of birth  - metric: YEAR 
```

```

 1980  1981  1982  1983  1984 
10236 11868 11292 11496 11088 
```

```r
table(round(ds$agec,0)) # years past 16 -  metric: AGE 
```

```

   0    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15 
 924 1882 2823 3812 4665 4665 4665 4665 4665 4665 4665 4665 3741 2783 1842  853 
```

```r
table(ds$sample, ds$race)/length(unique(ds$year)) # Sample BY Race counts
```

```
   
       4
  1 4665
```

```r
cat(length(unique(ds$id))) # total No. of respondents in dataset
```

```
4665
```

```r
sum(!is.na(ds$attend)) # valid datapoints 
```

```
[1] 46085
```

```r
sum(is.na(ds$attend)) # NA in the dataset 
```

```
[1] 9895
```

```r
# Estimate the model
modnum <-lmer (attend ~ 
               1  + timec + timec2 + timec3
       + cohort + cohort:timec + cohort:timec2 + cohort:timec3
              + (1 | id),
             data = ds, REML=FALSE, 
             control=lmerControl(optCtrl=list(maxfun=20000)))
        
model<- modnum
summary(model)
```

```
Linear mixed model fit by maximum likelihood  ['lmerMod']
Formula: attend ~ 1 + timec + timec2 + timec3 + cohort + cohort:timec +      cohort:timec2 + cohort:timec3 + (1 | id)
   Data: ds
Control: lmerControl(optCtrl = list(maxfun = 20000))

     AIC      BIC   logLik deviance df.resid 
  157715   157802   -78848   157695    46075 

Scaled residuals: 
   Min     1Q Median     3Q    Max 
-4.851 -0.509 -0.083  0.392  5.414 

Random effects:
 Groups   Name        Variance Std.Dev.
 id       (Intercept) 2.35     1.53    
 Residual             1.35     1.16    
Number of obs: 46085, groups: id, 4517

Fixed effects:
               Estimate Std. Error t value
(Intercept)    2.813304   0.049591    56.7
timec         -0.081250   0.024026    -3.4
timec2         0.012100   0.005245     2.3
timec3        -0.000539   0.000314    -1.7
cohort         0.211204   0.019986    10.6
timec:cohort  -0.073501   0.009607    -7.7
timec2:cohort  0.006828   0.002100     3.3
timec3:cohort -0.000218   0.000126    -1.7

Correlation of Fixed Effects:
            (Intr) timec  timec2 timec3 cohort tmc:ch tmc2:c
timec       -0.443                                          
timec2       0.352 -0.959                                   
timec3      -0.299  0.898 -0.984                            
cohort      -0.828  0.365 -0.291  0.247                     
timec:cohrt  0.368 -0.831  0.797 -0.747 -0.440              
timec2:chrt -0.293  0.796 -0.830  0.817  0.350 -0.959       
timec3:chrt  0.248 -0.745  0.817 -0.830 -0.297  0.898 -0.984
```



```r
summary(model) 
```

```
Linear mixed model fit by maximum likelihood  ['lmerMod']
Formula: attend ~ 1 + timec + timec2 + timec3 + cohort + cohort:timec +      cohort:timec2 + cohort:timec3 + (1 | id)
   Data: ds
Control: lmerControl(optCtrl = list(maxfun = 20000))

     AIC      BIC   logLik deviance df.resid 
  157715   157802   -78848   157695    46075 

Scaled residuals: 
   Min     1Q Median     3Q    Max 
-4.851 -0.509 -0.083  0.392  5.414 

Random effects:
 Groups   Name        Variance Std.Dev.
 id       (Intercept) 2.35     1.53    
 Residual             1.35     1.16    
Number of obs: 46085, groups: id, 4517

Fixed effects:
               Estimate Std. Error t value
(Intercept)    2.813304   0.049591    56.7
timec         -0.081250   0.024026    -3.4
timec2         0.012100   0.005245     2.3
timec3        -0.000539   0.000314    -1.7
cohort         0.211204   0.019986    10.6
timec:cohort  -0.073501   0.009607    -7.7
timec2:cohort  0.006828   0.002100     3.3
timec3:cohort -0.000218   0.000126    -1.7

Correlation of Fixed Effects:
            (Intr) timec  timec2 timec3 cohort tmc:ch tmc2:c
timec       -0.443                                          
timec2       0.352 -0.959                                   
timec3      -0.299  0.898 -0.984                            
cohort      -0.828  0.365 -0.291  0.247                     
timec:cohrt  0.368 -0.831  0.797 -0.747 -0.440              
timec2:chrt -0.293  0.796 -0.830  0.817  0.350 -0.959       
timec3:chrt  0.248 -0.745  0.817 -0.830 -0.297  0.898 -0.984
```


## Model formula

```r
model@call 
```

```
lmer(formula = attend ~ 1 + timec + timec2 + timec3 + cohort + 
    cohort:timec + cohort:timec2 + cohort:timec3 + (1 | id), 
    data = ds, REML = FALSE, control = lmerControl(optCtrl = list(maxfun = 20000)))
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
  157715   157802   -78847   157695    46075    46085        8     4517 
```

## Random Effects (RE)

### Matrix of RE

```r
# extract RE covariance matrix
mREcov<-     data.frame(     summary(model)$varcor$id   ) # covariance matrix of RE
mREcor<-  data.frame(attr(summary(model)$varcor$id,"correlation")) # corrleation matrix of RE
mRE<-   data.frame(sd= (attr(summary(model)$varcor$id,"stddev")))
mRE$var<- mRE$sd^2
mRE<-mRE[c("var","sd")]
mRE
```

```
             var    sd
(Intercept) 2.35 1.533
```

```r
mREcov
```

```
            X.Intercept.
(Intercept)         2.35
```

### extracting RE for each individual

```r
RE<- lme4:::ranef.merMod(model)$id 
head(RE,6)
```

```
   (Intercept)
1      -1.1420
8       0.1760
9       0.8665
10      2.2624
29      0.3509
31     -1.2067
```

```r
# however
cor(RE)  # not the same as mRE, find out why
```

```
            (Intercept)
(Intercept)           1
```

```r
var(RE)  # not the same as mRE, find out why
```

```
            (Intercept)
(Intercept)       2.196
```

## Fixed Effects (FE)


### estimate of the FE

```r
# similar ways to extract FE estimates, #3 is the fullest
FE<- summary(model)$coefficients
FE
```

```
                Estimate Std. Error t value
(Intercept)    2.8133042  0.0495912  56.730
timec         -0.0812498  0.0240260  -3.382
timec2         0.0121004  0.0052447   2.307
timec3        -0.0005387  0.0003142  -1.715
cohort         0.2112036  0.0199862  10.567
timec:cohort  -0.0735007  0.0096071  -7.651
timec2:cohort  0.0068283  0.0021003   3.251
timec3:cohort -0.0002179  0.0001259  -1.730
```

### Matrix of FE

```r
mFE<- (summary(model)$vcov@factors$correlation) # notice that this is object of 
mFE
```

```
8 x 8 Matrix of class "corMatrix"
              (Intercept)   timec  timec2  timec3  cohort timec:cohort timec2:cohort timec3:cohort
(Intercept)        1.0000 -0.4427  0.3522 -0.2990 -0.8275       0.3681       -0.2926        0.2481
timec             -0.4427  1.0000 -0.9589  0.8978  0.3652      -0.8311        0.7960       -0.7447
timec2             0.3522 -0.9589  1.0000 -0.9840 -0.2907       0.7972       -0.8304        0.8165
timec3            -0.2990  0.8978 -0.9840  1.0000  0.2468      -0.7466        0.8174       -0.8300
cohort            -0.8275  0.3652 -0.2907  0.2468  1.0000      -0.4396        0.3499       -0.2970
timec:cohort       0.3681 -0.8311  0.7972 -0.7466 -0.4396       1.0000       -0.9588        0.8977
timec2:cohort     -0.2926  0.7960 -0.8304  0.8174  0.3499      -0.9588        1.0000       -0.9840
timec3:cohort      0.2481 -0.7447  0.8165 -0.8300 -0.2970       0.8977       -0.9840        1.0000
```

## Prediction and Residuals


```r
dsp<- data.frame(getME(model,"X")) # no Y, only predictors (with interaction terms)
dsp$id<-getME(model,"flist")$id # first level grouping factor, individual
dsp$y<-getME(model,"y") # response vector
dsp$yHat<- predict(model) # predicted values
dsp$resid<- lme4:::residuals.merMod(model)
identical (  dsp$y-dsp$yHat, dsp$resid)
```

```
[1] TRUE
```

```r
head(dsp,13)
```

```
   X.Intercept. timec timec2 timec3 cohort timec.cohort timec2.cohort timec3.cohort id y  yHat   resid
1             1     0      0      0      1            0             0             0  1 1 1.882 -0.8825
2             1     1      1      1      1            1             1             1  1 6 1.746  4.2541
3             1     2      4      8      1            2             4             8  1 2 1.643  0.3574
4             1     3      9     27      1            3             9            27  1 1 1.568 -0.5682
5             1     4     16     64      1            4            16            64  1 1 1.518 -0.5179
6             1     5     25    125      1            5            25           125  1 1 1.487 -0.4874
7             1     6     36    216      1            6            36           216  1 1 1.472 -0.4720
8             1     7     49    343      1            7            49           343  1 1 1.467 -0.4672
9             1     8     64    512      1            8            64           512  1 1 1.469 -0.4685
10            1     9     81    729      1            9            81           729  1 1 1.471 -0.4714
11            1    10    100   1000      1           10           100          1000  1 1 1.471 -0.4712
12            1    11    121   1331      1           11           121          1331  1 1 1.464 -0.4635
13            1     0      0      0      1            0             0             0  8 2 3.200 -1.2005
```

Getting the standard error of residuals

```r
sigma<-sigma(model) # std.error of residuals <- this methods is preferred
# however
SDR<-sd(dsp$resid) # not the same as sigma(model) = find out why
identical (sigma, SDR) # WHY?
```

```
[1] FALSE
```

```r
# however, compare
sigma
```

```
[1] 1.164
```

```r
SDR
```

```
[1] 1.109
```

```r
sqrt(sigma/SDR)
```

```
[1] 1.024
```

## Conditional values
Predictions form fixed effects only, no individual variability is used in calculation





