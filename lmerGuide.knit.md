---
title: "lmer guide"
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










Learnging the basics of lme4 package, <code>lmer()</code> function and S4 objects

## Basics 
Prepare data for modeling. 
Only the first 200 respondents will be selected to keep illustration light.

```r
dsL<-readRDS("./Data/Derived/dsL.rds")
ds<- dsL %>% dplyr::filter(id %in% c(1:200),year %in% c(2000:2011)) %>% 
  dplyr::mutate(timec=year-2000, timec2= timec^2, timec3= timec^3, 
                agec= round( (agemon/12),0)-16) %>% 
  dplyr::select(id,year,attend, timec,timec2, timec3, agec)
head(ds, 20)
```

```
   id year attend timec timec2 timec3 agec
1   1 2000      1     0      0      0    3
2   1 2001      6     1      1      1    4
3   1 2002      2     2      4      8    5
4   1 2003      1     3      9     27    6
5   1 2004      1     4     16     64    7
6   1 2005      1     5     25    125    8
7   1 2006      1     6     36    216    9
8   1 2007      1     7     49    343   10
9   1 2008      1     8     64    512   11
10  1 2009      1     9     81    729   12
11  1 2010      1    10    100   1000   13
12  1 2011      1    11    121   1331   14
13  2 2000      2     0      0      0    2
14  2 2001      2     1      1      1    3
15  2 2002      1     2      4      8    4
16  2 2003      1     3      9     27    5
17  2 2004      2     4     16     64    6
18  2 2005      2     5     25    125    8
19  2 2006     NA     6     36    216   NA
20  2 2007     NA     7     49    343   NA
```

Fit the model with <code>lmer</code>

```r
m10 <-lmer (attend ~ 
               1  + agec + timec + timec2 + timec3
             + agec:timec +agec:timec2 + agec:timec3
             + (1 + timec + timec2 + timec3 | id),
             data = ds, REML=0)
```

```
Warning: convergence code 1 from bobyqa: bobyqa -- maximum number of function evaluations exceeded
Warning: Model failed to converge with max|grad| = 680.408 (tol = 0.002)
Warning: the condition has length > 1 and only the first element will be used
Warning: Model is nearly unidentifiable: very large eigenvalue
 - Rescale variables?;Model is nearly unidentifiable: large eigenvalue ratio
 - Rescale variables?
```

```r
model<- m10
```

Print the basic results of  the fitted model

```r
print(model) 
```

```
Linear mixed model fit by maximum likelihood  ['lmerMod']
Formula: attend ~ 1 + agec + timec + timec2 + timec3 + agec:timec + agec:timec2 +  
    agec:timec3 + (1 + timec + timec2 + timec3 | id)
   Data: ds
     AIC      BIC   logLik deviance df.resid 
    6490     6595    -3226     6452     1854 
Random effects:
 Groups   Name        Std.Dev. Corr             
 id       (Intercept) 1.23574                   
          timec       0.82117  -0.12            
          timec2      0.16635   0.00 -0.95      
          timec3      0.00906   0.03  0.90 -0.98
 Residual             1.06840                   
Number of obs: 1873, groups: id, 191
Fixed Effects:
(Intercept)         agec        timec       timec2       timec3   agec:timec  agec:timec2  agec:timec3  
   3.37e+00    -1.33e-01    -1.32e-01    -1.95e-02     7.12e-04     3.83e-02    -1.41e-03     2.02e-05  
```

Or get a more detailed summary

```r
summary(model)
```

```
Linear mixed model fit by maximum likelihood  ['lmerMod']
Formula: attend ~ 1 + agec + timec + timec2 + timec3 + agec:timec + agec:timec2 +  
    agec:timec3 + (1 + timec + timec2 + timec3 | id)
   Data: ds

     AIC      BIC   logLik deviance df.resid 
    6490     6595    -3226     6452     1854 

Scaled residuals: 
   Min     1Q Median     3Q    Max 
-3.559 -0.442 -0.097  0.375  4.992 

Random effects:
 Groups   Name        Variance Std.Dev. Corr             
 id       (Intercept) 1.53e+00 1.23574                   
          timec       6.74e-01 0.82117  -0.12            
          timec2      2.77e-02 0.16635   0.00 -0.95      
          timec3      8.21e-05 0.00906   0.03  0.90 -0.98
 Residual             1.14e+00 1.06840                   
Number of obs: 1873, groups: id, 191

Fixed effects:
             Estimate Std. Error t value
(Intercept)  3.37e+00   2.22e-01   15.16
agec        -1.33e-01   7.49e-02   -1.78
timec       -1.32e-01   1.64e-01   -0.80
timec2      -1.95e-02   4.20e-02   -0.46
timec3       7.12e-04   3.21e-03    0.22
agec:timec   3.83e-02   3.26e-02    1.17
agec:timec2 -1.41e-03   5.00e-03   -0.28
agec:timec3  2.02e-05   2.64e-04    0.08

Correlation of Fixed Effects:
            (Intr) agec   timec  timec2 timec3 agc:tm agc:t2
agec        -0.843                                          
timec       -0.085 -0.147                                   
timec2      -0.008  0.198 -0.698                            
timec3       0.038 -0.186  0.455 -0.927                     
agec:timec   0.490 -0.504 -0.558  0.015  0.199              
agec:timec2 -0.338  0.275  0.756 -0.449  0.215 -0.865       
agec:timec3  0.223 -0.121 -0.739  0.745 -0.617  0.573 -0.886
```

For a list of objects that can be extracted from the model

```r
str(summary(model))
```

```
List of 16
 $ methTitle   : chr "Linear mixed model fit by maximum likelihood "
 $ objClass    : atomic [1:1] lmerMod
  ..- attr(*, "package")= chr "lme4"
 $ devcomp     :List of 2
  ..$ cmp : Named num [1:10] 888.9 83.4 1631.4 506.6 2138 ...
  .. ..- attr(*, "names")= chr [1:10] "ldL2" "ldRX2" "wrss" "ussq" ...
  ..$ dims: Named int [1:12] 1873 1873 8 1865 10 764 1 1 0 0 ...
  .. ..- attr(*, "names")= chr [1:12] "N" "n" "p" "nmp" ...
 $ isLmer      : logi TRUE
 $ useScale    : logi TRUE
 $ logLik      :Class 'logLik' : -3226 (df=19)
 $ family      : NULL
 $ link        : NULL
 $ ngrps       : Named num 191
  ..- attr(*, "names")= chr "id"
 $ coefficients: num [1:8, 1:3] 3.365265 -0.133152 -0.13205 -0.019508 0.000712 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
  .. ..$ : chr [1:3] "Estimate" "Std. Error" "t value"
 $ sigma       : num 1.07
 $ vcov        :Formal class 'dpoMatrix' [package "Matrix"] with 5 slots
  .. ..@ x       : num [1:64] 4.93e-02 -1.40e-02 -3.09e-03 -7.35e-05 2.72e-05 ...
  .. ..@ Dim     : int [1:2] 8 8
  .. ..@ Dimnames:List of 2
  .. .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
  .. .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
  .. ..@ uplo    : chr "U"
  .. ..@ factors :List of 2
  .. .. ..$ Cholesky   :Formal class 'Cholesky' [package "Matrix"] with 5 slots
  .. .. .. .. ..@ x       : num [1:64] 0.222 0 0 0 0 ...
  .. .. .. .. ..@ Dim     : int [1:2] 8 8
  .. .. .. .. ..@ Dimnames:List of 2
  .. .. .. .. .. ..$ : NULL
  .. .. .. .. .. ..$ : NULL
  .. .. .. .. ..@ uplo    : chr "U"
  .. .. .. .. ..@ diag    : chr "N"
  .. .. ..$ correlation:Formal class 'corMatrix' [package "Matrix"] with 6 slots
  .. .. .. .. ..@ sd      : num [1:8] 0.22206 0.07489 0.16415 0.04198 0.00321 ...
  .. .. .. .. ..@ x       : num [1:64] 1 -0.84315 -0.0847 -0.00788 0.03823 ...
  .. .. .. .. ..@ Dim     : int [1:2] 8 8
  .. .. .. .. ..@ Dimnames:List of 2
  .. .. .. .. .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
  .. .. .. .. .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
  .. .. .. .. ..@ uplo    : chr "U"
  .. .. .. .. ..@ factors :List of 1
  .. .. .. .. .. ..$ Cholesky:Formal class 'Cholesky' [package "Matrix"] with 5 slots
  .. .. .. .. .. .. .. ..@ x       : num [1:64] 1 0 0 0 0 ...
  .. .. .. .. .. .. .. ..@ Dim     : int [1:2] 8 8
  .. .. .. .. .. .. .. ..@ Dimnames:List of 2
  .. .. .. .. .. .. .. .. ..$ : NULL
  .. .. .. .. .. .. .. .. ..$ : NULL
  .. .. .. .. .. .. .. ..@ uplo    : chr "U"
  .. .. .. .. .. .. .. ..@ diag    : chr "N"
 $ varcor      :List of 1
  ..$ id: num [1:4, 1:4] 1.527062 -0.119554 0.00028 0.000291 -0.119554 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
  .. .. ..$ : chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
  .. ..- attr(*, "stddev")= Named num [1:4] 1.23574 0.82117 0.16635 0.00906
  .. .. ..- attr(*, "names")= chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
  .. ..- attr(*, "correlation")= num [1:4, 1:4] 1 -0.11782 0.00136 0.02598 -0.11782 ...
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
  .. .. .. ..$ : chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
  ..- attr(*, "sc")= num 1.07
  ..- attr(*, "useSc")= logi TRUE
  ..- attr(*, "class")= chr "VarCorr.merMod"
 $ AICtab      : Named num [1:5] 6490 6595 -3226 6452 1854
  ..- attr(*, "names")= chr [1:5] "AIC" "BIC" "logLik" "deviance" ...
 $ call        : language lmer(formula = attend ~ 1 + agec + timec + timec2 + timec3 + agec:timec + agec:timec2 + agec:timec3 + (1 + timec +      timec2 + timec3 | id), data = ds, REML = 0)
 $ residuals   : Named num [1:1873] -1.653 3.34 -0.111 -0.781 -0.545 ...
  ..- attr(*, "names")= chr [1:1873] "1" "2" "3" "4" ...
 - attr(*, "class")= chr "summary.merMod"
```



There a number of ways one could extract the needed element from the S4 object. In addition, some of the elements might be stored in several locations.   

## Model formula

```r
model@call # 1
```

```
lmer(formula = attend ~ 1 + agec + timec + timec2 + timec3 + 
    agec:timec + agec:timec2 + agec:timec3 + (1 + timec + timec2 + 
    timec3 | id), data = ds, REML = 0)
```

```r
(summary(model))$call #2
```

```
lmer(formula = attend ~ 1 + agec + timec + timec2 + timec3 + 
    agec:timec + agec:timec2 + agec:timec3 + (1 + timec + timec2 + 
    timec3 | id), data = ds, REML = 0)
```

## Fit and Information indices


```r
# get indicies
mInfo<-summary(model)$AICtab
mInfo
```

```
     AIC      BIC   logLik deviance df.resid 
    6490     6595    -3226     6452     1854 
```

```r
mInfo['logLik']
```

```
logLik 
 -3226 
```

Aleternatively,


























