-   Basics
-   Model formula
-   Fit and Information indices
-   Random Effects (RE)
    -   Matrix of RE
    -   extracting RE for each individual
-   Fixed Effects (RE)
    -   Matrix of FE
    -   estimate of the FE
-   Prediction and Residuals
    -   Restatement of model input
    -   Adding model output
    -   Adding residual
-   Conditional values

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->










Learnging the basics of lme4 package, <code>lmer()</code> function and
S4 objects

Basics
------

Prepare data for modeling. Only the first 200 respondents will be
selected to keep illustration light.

    dsL<-readRDS("./Data/Derived/dsL.rds")
    ds<- dsL %>% dplyr::filter(id %in% c(1:200),year %in% c(2000:2011)) %>% 
      dplyr::mutate(timec=year-2000, timec2= timec^2, timec3= timec^3, 
                    agec= round( (agemon/12),0)-16) %>% 
      dplyr::select(id,year,attend, timec,timec2, timec3, agec)
    head(ds, 20)

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

Fit the model with <code>lmer</code>

    m10 <-lmer (attend ~ 
                   1  + agec + timec + timec2 + timec3
                 + agec:timec +agec:timec2 + agec:timec3
                 + (1 + timec + timec2 + timec3 | id),
                 data = ds, REML=0)

    Warning: convergence code 1 from bobyqa: bobyqa -- maximum number of function evaluations exceeded
    Warning: Model failed to converge with max|grad| = 680.408 (tol = 0.002)
    Warning: the condition has length > 1 and only the first element will be used
    Warning: Model is nearly unidentifiable: very large eigenvalue
     - Rescale variables?;Model is nearly unidentifiable: large eigenvalue ratio
     - Rescale variables?

    model<- m10

Print the basic results of the fitted model

    print(model) 

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

Or get a more detailed summary

    summary(model)

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

For a list of objects that can be extracted from the model

    str(summary(model))

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

There a number of ways one could extract the needed element from the S4
object. In addition, some of the elements might be stored in several
locations.

Model formula
-------------

    model@call # 1

    lmer(formula = attend ~ 1 + agec + timec + timec2 + timec3 + 
        agec:timec + agec:timec2 + agec:timec3 + (1 + timec + timec2 + 
        timec3 | id), data = ds, REML = 0)

    (summary(model))$call #2

    lmer(formula = attend ~ 1 + agec + timec + timec2 + timec3 + 
        agec:timec + agec:timec2 + agec:timec3 + (1 + timec + timec2 + 
        timec3 | id), data = ds, REML = 0)

Fit and Information indices
---------------------------

    # get indicies
    mInfo<-summary(model)$AICtab
    mInfo

         AIC      BIC   logLik deviance df.resid 
        6490     6595    -3226     6452     1854 

    mInfo['logLik']

    logLik 
     -3226 

Aleternatively,

    logLik<-logLik(model)
    dev<-deviance(model)
    AIC <- AIC(model) 
    BIC <- BIC(model)
    N<- model@devcomp$dims["N"] # Looks like the total number of data points ( individual-by-time)
    p<- model@devcomp$dims["p"] # Looks like the number of estimated parameters, verify
    ids<- (summary(model))$ngrps # number of units on level-2, here: individuals
    mInfo<- c("logLik"=logLik,"dev"=dev,"AIC"=AIC,"BIC"=BIC,"N"=N, "p"=p, "ids"=ids)
    mInfo

    logLik    dev    AIC    BIC    N.N    p.p ids.id 
     -3226   6452   6490   6595   1873      8    191 

Random Effects (RE)
-------------------

### Matrix of RE

    str(summary(model)$varcor)

    List of 1
     $ id: num [1:4, 1:4] 1.527062 -0.119554 0.00028 0.000291 -0.119554 ...
      ..- attr(*, "dimnames")=List of 2
      .. ..$ : chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
      .. ..$ : chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
      ..- attr(*, "stddev")= Named num [1:4] 1.23574 0.82117 0.16635 0.00906
      .. ..- attr(*, "names")= chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
      ..- attr(*, "correlation")= num [1:4, 1:4] 1 -0.11782 0.00136 0.02598 -0.11782 ...
      .. ..- attr(*, "dimnames")=List of 2
      .. .. ..$ : chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
      .. .. ..$ : chr [1:4] "(Intercept)" "timec" "timec2" "timec3"
     - attr(*, "sc")= num 1.07
     - attr(*, "useSc")= logi TRUE
     - attr(*, "class")= chr "VarCorr.merMod"

    # extract RE covariance matrix
    mRE<- data.frame(summary(model)$varcor$id) 
    mRE

                X.Intercept.     timec     timec2     timec3
    (Intercept)    1.5270624 -0.119554  0.0002804  2.908e-04
    timec         -0.1195542  0.674320 -0.1302896  6.658e-03
    timec2         0.0002804 -0.130290  0.0276723 -1.483e-03
    timec3         0.0002908  0.006658 -0.0014833  8.205e-05

    mRE<- data.frame(VarCorr(model)$id)
    mRE

                X.Intercept.     timec     timec2     timec3
    (Intercept)    1.5270624 -0.119554  0.0002804  2.908e-04
    timec         -0.1195542  0.674320 -0.1302896  6.658e-03
    timec2         0.0002804 -0.130290  0.0276723 -1.483e-03
    timec3         0.0002908  0.006658 -0.0014833  8.205e-05

    mREcor<-  data.frame(attr(summary(model)$varcor$id,"correlation")) # corrleation 
    mREcor

                X.Intercept.   timec    timec2   timec3
    (Intercept)     1.000000 -0.1178  0.001364  0.02598
    timec          -0.117816  1.0000 -0.953793  0.89509
    timec2          0.001364 -0.9538  1.000000 -0.98438
    timec3          0.025983  0.8951 -0.984383  1.00000

    mREcor<- data.frame( attr(VarCorr(model)$id,"correlation"))
    mREcor

                X.Intercept.   timec    timec2   timec3
    (Intercept)     1.000000 -0.1178  0.001364  0.02598
    timec          -0.117816  1.0000 -0.953793  0.89509
    timec2          0.001364 -0.9538  1.000000 -0.98438
    timec3          0.025983  0.8951 -0.984383  1.00000

    mREsd<-   data.frame(STD=(attr(summary(model)$varcor$id,"stddev"))) 
    mREsd

                     STD
    (Intercept) 1.235744
    timec       0.821170
    timec2      0.166350
    timec3      0.009058

### extracting RE for each individual

    RE<- lme4:::ranef.merMod(model)$id 
    head(RE,5)

      (Intercept)   timec    timec2    timec3
    1     -0.1998 -0.1948 -0.005072  0.001247
    2     -0.8681 -0.2208  0.064432 -0.003808
    3     -0.1842 -0.6816  0.197827 -0.011676
    4     -0.7941  0.1096 -0.031264  0.002802
    5      0.1088 -0.4967  0.096427 -0.004834

    tail(RE,5)

        (Intercept)   timec    timec2     timec3
    196    -1.54368 -0.1687  0.054824 -0.0030731
    197    -0.09957 -0.0621  0.009258 -0.0005129
    198    -0.97355  0.2022 -0.046348  0.0027714
    199    -1.40829 -0.1739  0.040914 -0.0022034
    200     2.42073  0.5940 -0.104779  0.0053983

    mRE

                X.Intercept.     timec     timec2     timec3
    (Intercept)    1.5270624 -0.119554  0.0002804  2.908e-04
    timec         -0.1195542  0.674320 -0.1302896  6.658e-03
    timec2         0.0002804 -0.130290  0.0276723 -1.483e-03
    timec3         0.0002908  0.006658 -0.0014833  8.205e-05

    cor(RE)  # not the same as mRE, find out why

                (Intercept)   timec  timec2  timec3
    (Intercept)      1.0000  0.0319 -0.1996  0.2342
    timec            0.0319  1.0000 -0.9257  0.8486
    timec2          -0.1996 -0.9257  1.0000 -0.9817
    timec3           0.2342  0.8486 -0.9817  1.0000

    var(RE)  # not the same as mRE, find out why

                (Intercept)     timec     timec2     timec3
    (Intercept)    1.487037  0.019434 -0.0233827  0.0014309
    timec          0.019434  0.249575 -0.0444308  0.0021240
    timec2        -0.023383 -0.044431  0.0092298 -0.0004726
    timec3         0.001431  0.002124 -0.0004726  0.0000251

Fixed Effects (RE)
------------------

### Matrix of FE

    str(summary(model)$vcov)

    Formal class 'dpoMatrix' [package "Matrix"] with 5 slots
      ..@ x       : num [1:64] 4.93e-02 -1.40e-02 -3.09e-03 -7.35e-05 2.72e-05 ...
      ..@ Dim     : int [1:2] 8 8
      ..@ Dimnames:List of 2
      .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
      .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
      ..@ uplo    : chr "U"
      ..@ factors :List of 2
      .. ..$ Cholesky   :Formal class 'Cholesky' [package "Matrix"] with 5 slots
      .. .. .. ..@ x       : num [1:64] 0.222 0 0 0 0 ...
      .. .. .. ..@ Dim     : int [1:2] 8 8
      .. .. .. ..@ Dimnames:List of 2
      .. .. .. .. ..$ : NULL
      .. .. .. .. ..$ : NULL
      .. .. .. ..@ uplo    : chr "U"
      .. .. .. ..@ diag    : chr "N"
      .. ..$ correlation:Formal class 'corMatrix' [package "Matrix"] with 6 slots
      .. .. .. ..@ sd      : num [1:8] 0.22206 0.07489 0.16415 0.04198 0.00321 ...
      .. .. .. ..@ x       : num [1:64] 1 -0.84315 -0.0847 -0.00788 0.03823 ...
      .. .. .. ..@ Dim     : int [1:2] 8 8
      .. .. .. ..@ Dimnames:List of 2
      .. .. .. .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
      .. .. .. .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
      .. .. .. ..@ uplo    : chr "U"
      .. .. .. ..@ factors :List of 1
      .. .. .. .. ..$ Cholesky:Formal class 'Cholesky' [package "Matrix"] with 5 slots
      .. .. .. .. .. .. ..@ x       : num [1:64] 1 0 0 0 0 ...
      .. .. .. .. .. .. ..@ Dim     : int [1:2] 8 8
      .. .. .. .. .. .. ..@ Dimnames:List of 2
      .. .. .. .. .. .. .. ..$ : NULL
      .. .. .. .. .. .. .. ..$ : NULL
      .. .. .. .. .. .. ..@ uplo    : chr "U"
      .. .. .. .. .. .. ..@ diag    : chr "N"

    mFE<- (summary(model)$vcov@factors$correlation) # notice that this is object of class corMatrix
    str(mFE)

    Formal class 'corMatrix' [package "Matrix"] with 6 slots
      ..@ sd      : num [1:8] 0.22206 0.07489 0.16415 0.04198 0.00321 ...
      ..@ x       : num [1:64] 1 -0.84315 -0.0847 -0.00788 0.03823 ...
      ..@ Dim     : int [1:2] 8 8
      ..@ Dimnames:List of 2
      .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
      .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
      ..@ uplo    : chr "U"
      ..@ factors :List of 1
      .. ..$ Cholesky:Formal class 'Cholesky' [package "Matrix"] with 5 slots
      .. .. .. ..@ x       : num [1:64] 1 0 0 0 0 ...
      .. .. .. ..@ Dim     : int [1:2] 8 8
      .. .. .. ..@ Dimnames:List of 2
      .. .. .. .. ..$ : NULL
      .. .. .. .. ..$ : NULL
      .. .. .. ..@ uplo    : chr "U"
      .. .. .. ..@ diag    : chr "N"

### estimate of the FE

    # similar ways to extract FE estimates, #3 is the fullest
    FE1<- fixef(model) #1 
    FE2<- getME(model, "beta") # 2
    FE3<- summary(model)$coefficients # 3
    coefs<- FE1

Prediction and Residuals
------------------------

### Restatement of model input

First, recover information that went into the model

    # dsP - P for predicted
    dsp<-data.frame(model@frame) # original vars used by the model (no interaction terms)
    head(dsp,13)

       attend agec timec timec2 timec3 id
    1       1    3     0      0      0  1
    2       6    4     1      1      1  1
    3       2    5     2      4      8  1
    4       1    6     3      9     27  1
    5       1    7     4     16     64  1
    6       1    8     5     25    125  1
    7       1    9     6     36    216  1
    8       1   10     7     49    343  1
    9       1   11     8     64    512  1
    10      1   12     9     81    729  1
    11      1   13    10    100   1000  1
    12      1   14    11    121   1331  1
    13      2    2     0      0      0  2

Another way, which includes interaction terms, but no outcome

    dsp<- data.frame(getME(model,"X")) # no Y, only predictors (with interaction terms)
    head(dsp,13)

       X.Intercept. agec timec timec2 timec3 agec.timec agec.timec2 agec.timec3
    1             1    3     0      0      0          0           0           0
    2             1    4     1      1      1          4           4           4
    3             1    5     2      4      8         10          20          40
    4             1    6     3      9     27         18          54         162
    5             1    7     4     16     64         28         112         448
    6             1    8     5     25    125         40         200        1000
    7             1    9     6     36    216         54         324        1944
    8             1   10     7     49    343         70         490        3430
    9             1   11     8     64    512         88         704        5632
    10            1   12     9     81    729        108         972        8748
    11            1   13    10    100   1000        130        1300       13000
    12            1   14    11    121   1331        154        1694       18634
    13            1    2     0      0      0          0           0           0

We can add response vector and the grouping factor for the second level
(individual)

    dsp$id<-getME(model,"flist")$id # first level grouping factor, individual
    dsp$y<-getME(model,"y") # response vector
    head(dsp,13)

       X.Intercept. agec timec timec2 timec3 agec.timec agec.timec2 agec.timec3 id y
    1             1    3     0      0      0          0           0           0  1 1
    2             1    4     1      1      1          4           4           4  1 6
    3             1    5     2      4      8         10          20          40  1 2
    4             1    6     3      9     27         18          54         162  1 1
    5             1    7     4     16     64         28         112         448  1 1
    6             1    8     5     25    125         40         200        1000  1 1
    7             1    9     6     36    216         54         324        1944  1 1
    8             1   10     7     49    343         70         490        3430  1 1
    9             1   11     8     64    512         88         704        5632  1 1
    10            1   12     9     81    729        108         972        8748  1 1
    11            1   13    10    100   1000        130        1300       13000  1 1
    12            1   14    11    121   1331        154        1694       18634  1 1
    13            1    2     0      0      0          0           0           0  2 2

### Adding model output

There are several way to extract the predictions made by the model

    # model outcome, predicted values
    yHat1<- fitted(model) # 1
    yHat2<- predict(model) # 2
    yHat3<- getME(model,"mu") # 3

    identical(yHat1,yHat2)

    [1] TRUE

    identical(as.numeric(yHat2),yHat3)

    [1] TRUE

    dsp$yHat<- predict(model)
    head(dsp,13)

       X.Intercept. agec timec timec2 timec3 agec.timec agec.timec2 agec.timec3 id y  yHat
    1             1    3     0      0      0          0           0           0  1 1 2.766
    2             1    4     1      1      1          4           4           4  1 6 2.431
    3             1    5     2      4      8         10          20          40  1 2 2.119
    4             1    6     3      9     27         18          54         162  1 1 1.834
    5             1    7     4     16     64         28         112         448  1 1 1.582
    6             1    8     5     25    125         40         200        1000  1 1 1.367
    7             1    9     6     36    216         54         324        1944  1 1 1.196
    8             1   10     7     49    343         70         490        3430  1 1 1.074
    9             1   11     8     64    512         88         704        5632  1 1 1.009
    10            1   12     9     81    729        108         972        8748  1 1 1.007
    11            1   13    10    100   1000        130        1300       13000  1 1 1.078
    12            1   14    11    121   1331        154        1694       18634  1 1 1.228
    13            1    2     0      0      0          0           0           0  2 2 2.231

### Adding residual

    dsp$resid<- lme4:::residuals.merMod(model) # individual residual (id and time)
    head(dsp,13)

       X.Intercept. agec timec timec2 timec3 agec.timec agec.timec2 agec.timec3 id y  yHat     resid
    1             1    3     0      0      0          0           0           0  1 1 2.766 -1.766010
    2             1    4     1      1      1          4           4           4  1 6 2.431  3.568956
    3             1    5     2      4      8         10          20          40  1 2 2.119 -0.119025
    4             1    6     3      9     27         18          54         162  1 1 1.834 -0.834349
    5             1    7     4     16     64         28         112         448  1 1 1.582 -0.581892
    6             1    8     5     25    125         40         200        1000  1 1 1.367 -0.367016
    7             1    9     6     36    216         54         324        1944  1 1 1.196 -0.195566
    8             1   10     7     49    343         70         490        3430  1 1 1.074 -0.073873
    9             1   11     8     64    512         88         704        5632  1 1 1.009 -0.008749
    10            1   12     9     81    729        108         972        8748  1 1 1.007 -0.007492
    11            1   13    10    100   1000        130        1300       13000  1 1 1.078 -0.077881
    12            1   14    11    121   1331        154        1694       18634  1 1 1.228 -0.228184
    13            1    2     0      0      0          0           0           0  2 2 2.231 -0.230870

    identical (  dsp$y-dsp$yHat, dsp$resid)

    [1] TRUE

Getting the standard error of residuals

    getME(model,"sigma") # standard error of residuals, same sigma(model)

    [1] 1.068

    sigma(model) # std.error of residuals <- this methods is preferred

    [1] 1.068

    # however
    sd(dsp$resid) # not the same as sigma(model) = find out why

    [1] 0.9335

    identical (sigma(model),sd(dsp$resid)) # WHY?

    [1] FALSE

Conditional values
------------------

Predictions form fixed effects only, no individual variability is used
in calculation

    # create object "coefs" for easy reference
    coefs <- fixef(model)
    # use fixed effects estimates to find conditional predictions??
    dsp$yPar<-(
      (coefs["(Intercept)"])         +(coefs["agec"]*dsp$agec)
      +(coefs["timec"]*dsp$timec)    +(coefs["agec:timec"]*dsp$agec*dsp$timec)
      +(coefs["timec2"]*dsp$timec2)  +(coefs["agec:timec2"]*dsp$agec*dsp$timec2)
      +(coefs["timec3"]*dsp$timec3)  +(coefs["agec:timec3"]*dsp$agec*dsp$timec3)
    )
    head(dsp,13)

       X.Intercept. agec timec timec2 timec3 agec.timec agec.timec2 agec.timec3 id y  yHat     resid  yPar
    1             1    3     0      0      0          0           0           0  1 1 2.766 -1.766010 2.966
    2             1    4     1      1      1          4           4           4  1 6 2.431  3.568956 2.829
    3             1    5     2      4      8         10          20          40  1 2 2.119 -0.119025 2.719
    4             1    6     3      9     27         18          54         162  1 1 1.834 -0.834349 2.631
    5             1    7     4     16     64         28         112         448  1 1 1.582 -0.581892 2.562
    6             1    8     5     25    125         40         200        1000  1 1 1.367 -0.367016 2.512
    7             1    9     6     36    216         54         324        1944  1 1 1.196 -0.195566 2.477
    8             1   10     7     49    343         70         490        3430  1 1 1.074 -0.073873 2.458
    9             1   11     8     64    512         88         704        5632  1 1 1.009 -0.008749 2.453
    10            1   12     9     81    729        108         972        8748  1 1 1.007 -0.007492 2.462
    11            1   13    10    100   1000        130        1300       13000  1 1 1.078 -0.077881 2.486
    12            1   14    11    121   1331        154        1694       18634  1 1 1.228 -0.228184 2.525
    13            1    2     0      0      0          0           0           0  2 2 2.231 -0.230870 3.099
