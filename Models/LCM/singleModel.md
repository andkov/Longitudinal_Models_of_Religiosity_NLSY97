-   Model formula
-   Fit and Information indices
-   Random Effects (RE)
    -   Matrix of RE
    -   extracting RE for each individual
-   Fixed Effects (FE)
    -   estimate of the FE
    -   Matrix of FE
-   Prediction and Residuals
-   Conditional values
-   List of availible elements

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->











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

    modelNumber<- "m10"
    modnum<-cat(modelNumber)

    m10

    modnum <-lmer (attend ~ 
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

    model<- modnum

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

Model formula
-------------

    model@call 

    lmer(formula = attend ~ 1 + agec + timec + timec2 + timec3 + 
        agec:timec + agec:timec2 + agec:timec3 + (1 + timec + timec2 + 
        timec3 | id), data = ds, REML = 0)

Fit and Information indices
---------------------------

    # get indicies
    mInfo<-summary(model)$AICtab
    mInfo["N"]<- model@devcomp$dims["N"] # number of datapoints, verify
    mInfo["p"]<- model@devcomp$dims["p"] # number of estimated parameters, verify
    mInfo["ids"]<- (summary(model))$ngrps # number of units on level-2, here: individuals
    mInfo

         AIC      BIC   logLik deviance df.resid        N        p      ids 
        6490     6595    -3226     6452     1854     1873        8      191 

Random Effects (RE)
-------------------

### Matrix of RE

    # extract RE covariance matrix
    mREcov<-     data.frame(     summary(model)$varcor$id   ) # covariance matrix of RE
    mREcor<-  data.frame(attr(summary(model)$varcor$id,"correlation")) # corrleation matrix of RE
    mRE<-   data.frame(sd= (attr(summary(model)$varcor$id,"stddev")))
    mRE$var<- mRE$sd^2
    mRE<-mRE[c("var","sd")]
    mRE

                      var       sd
    (Intercept) 1.527e+00 1.235744
    timec       6.743e-01 0.821170
    timec2      2.767e-02 0.166350
    timec3      8.205e-05 0.009058

    mREcov

                X.Intercept.     timec     timec2     timec3
    (Intercept)    1.5270624 -0.119554  0.0002804  2.908e-04
    timec         -0.1195542  0.674320 -0.1302896  6.658e-03
    timec2         0.0002804 -0.130290  0.0276723 -1.483e-03
    timec3         0.0002908  0.006658 -0.0014833  8.205e-05

### extracting RE for each individual

    RE<- lme4:::ranef.merMod(model)$id 
    head(RE,6)

      (Intercept)   timec    timec2    timec3
    1     -0.1998 -0.1948 -0.005072  0.001247
    2     -0.8681 -0.2208  0.064432 -0.003808
    3     -0.1842 -0.6816  0.197827 -0.011676
    4     -0.7941  0.1096 -0.031264  0.002802
    5      0.1088 -0.4967  0.096427 -0.004834
    6     -0.1551  0.9127 -0.060165  0.001026

    # however
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

Fixed Effects (FE)
------------------

### estimate of the FE

    # similar ways to extract FE estimates, #3 is the fullest
    FE<- summary(model)$coefficients
    FE

                  Estimate Std. Error  t value
    (Intercept)  3.365e+00  0.2220560 15.15503
    agec        -1.332e-01  0.0748883 -1.77801
    timec       -1.320e-01  0.1641525 -0.80443
    timec2      -1.951e-02  0.0419778 -0.46471
    timec3       7.124e-04  0.0032064  0.22218
    agec:timec   3.830e-02  0.0326349  1.17370
    agec:timec2 -1.409e-03  0.0050003 -0.28168
    agec:timec3  2.016e-05  0.0002644  0.07626

### Matrix of FE

    mFE<- (summary(model)$vcov@factors$correlation) # notice that this is object of 
    mFE

    8 x 8 Matrix of class "corMatrix"
                (Intercept)    agec   timec    timec2   timec3 agec:timec agec:timec2 agec:timec3
    (Intercept)    1.000000 -0.8431 -0.0847 -0.007885  0.03823    0.49037     -0.3380      0.2233
    agec          -0.843145  1.0000 -0.1466  0.198315 -0.18560   -0.50436      0.2747     -0.1210
    timec         -0.084700 -0.1466  1.0000 -0.698075  0.45470   -0.55822      0.7563     -0.7388
    timec2        -0.007885  0.1983 -0.6981  1.000000 -0.92735    0.01546     -0.4489      0.7448
    timec3         0.038229 -0.1856  0.4547 -0.927346  1.00000    0.19911      0.2154     -0.6169
    agec:timec     0.490370 -0.5044 -0.5582  0.015461  0.19911    1.00000     -0.8654      0.5728
    agec:timec2   -0.337972  0.2747  0.7563 -0.448850  0.21543   -0.86543      1.0000     -0.8860
    agec:timec3    0.223305 -0.1210 -0.7388  0.744776 -0.61695    0.57280     -0.8860      1.0000

Prediction and Residuals
------------------------

    dsp<- data.frame(getME(model,"X")) # no Y, only predictors (with interaction terms)
    dsp$id<-getME(model,"flist")$id # first level grouping factor, individual
    dsp$y<-getME(model,"y") # response vector
    dsp$yHat<- predict(model) # predicted values
    dsp$resid<- lme4:::residuals.merMod(model)
    identical (  dsp$y-dsp$yHat, dsp$resid)

    [1] TRUE

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

Getting the standard error of residuals

    sigma<-sigma(model) # std.error of residuals <- this methods is preferred
    # however
    SDR<-sd(dsp$resid) # not the same as sigma(model) = find out why
    identical (sigma, SDR) # WHY?

    [1] FALSE

    # however, compare
    sigma

    [1] 1.068

    SDR

    [1] 0.9335

    sqrt(sigma/SDR)

    [1] 1.07

Conditional values
------------------

Predictions form fixed effects only, no individual variability is used
in calculation

    FE <- fixef(model)
    # use fixed effects estimates to find conditional predictions
    dsp$yPar<-(
      (FE["(Intercept)"])         +(FE["agec"]*dsp$agec)
      +(FE["timec"]*dsp$timec)    +(FE["agec:timec"]*dsp$agec*dsp$timec)
      +(FE["timec2"]*dsp$timec2)  +(FE["agec:timec2"]*dsp$agec*dsp$timec2)
      +(FE["timec3"]*dsp$timec3)  +(FE["agec:timec3"]*dsp$agec*dsp$timec3)
      )

List of availible elements
--------------------------

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

    mInfo # model information indices

         AIC      BIC   logLik deviance df.resid        N        p      ids 
        6490     6595    -3226     6452     1854     1873        8      191 

    mRE  # variances and standard deviations of random effects

                      var       sd
    (Intercept) 1.527e+00 1.235744
    timec       6.743e-01 0.821170
    timec2      2.767e-02 0.166350
    timec3      8.205e-05 0.009058

    mREcov # covariance matrix of Random Effects

                X.Intercept.     timec     timec2     timec3
    (Intercept)    1.5270624 -0.119554  0.0002804  2.908e-04
    timec         -0.1195542  0.674320 -0.1302896  6.658e-03
    timec2         0.0002804 -0.130290  0.0276723 -1.483e-03
    timec3         0.0002908  0.006658 -0.0014833  8.205e-05

    mREcor # correlation  matrix of Random Effects

                X.Intercept.   timec    timec2   timec3
    (Intercept)     1.000000 -0.1178  0.001364  0.02598
    timec          -0.117816  1.0000 -0.953793  0.89509
    timec2          0.001364 -0.9538  1.000000 -0.98438
    timec3          0.025983  0.8951 -0.984383  1.00000

    FE # estimates of Fixed Effects, SE, t-value

    (Intercept)        agec       timec      timec2      timec3  agec:timec agec:timec2 agec:timec3 
      3.365e+00  -1.332e-01  -1.320e-01  -1.951e-02   7.124e-04   3.830e-02  -1.409e-03   2.016e-05 

    mFE # matrix of correlations among Fixed Effects

    8 x 8 Matrix of class "corMatrix"
                (Intercept)    agec   timec    timec2   timec3 agec:timec agec:timec2 agec:timec3
    (Intercept)    1.000000 -0.8431 -0.0847 -0.007885  0.03823    0.49037     -0.3380      0.2233
    agec          -0.843145  1.0000 -0.1466  0.198315 -0.18560   -0.50436      0.2747     -0.1210
    timec         -0.084700 -0.1466  1.0000 -0.698075  0.45470   -0.55822      0.7563     -0.7388
    timec2        -0.007885  0.1983 -0.6981  1.000000 -0.92735    0.01546     -0.4489      0.7448
    timec3         0.038229 -0.1856  0.4547 -0.927346  1.00000    0.19911      0.2154     -0.6169
    agec:timec     0.490370 -0.5044 -0.5582  0.015461  0.19911    1.00000     -0.8654      0.5728
    agec:timec2   -0.337972  0.2747  0.7563 -0.448850  0.21543   -0.86543      1.0000     -0.8860
    agec:timec3    0.223305 -0.1210 -0.7388  0.744776 -0.61695    0.57280     -0.8860      1.0000

    sigma # standard deviation of residual

    [1] 1.068

    head(dsp,13) # input + output + residual + conditional

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

    modelSave<-cat(paste0(modelNumber,"S")) 

    m10S

    modS<- list(mInfo,mRE,mREcov,mREcor,FE,mFE,sigma,dsp) # model save
    str(modS)

    List of 8
     $ : Named num [1:8] 6490 6595 -3226 6452 1854 ...
      ..- attr(*, "names")= chr [1:8] "AIC" "BIC" "logLik" "deviance" ...
     $ :'data.frame':   4 obs. of  2 variables:
      ..$ var: num [1:4] 1.53 6.74e-01 2.77e-02 8.21e-05
      ..$ sd : num [1:4] 1.23574 0.82117 0.16635 0.00906
     $ :'data.frame':   4 obs. of  4 variables:
      ..$ X.Intercept.: num [1:4] 1.527062 -0.119554 0.00028 0.000291
      ..$ timec       : num [1:4] -0.11955 0.67432 -0.13029 0.00666
      ..$ timec2      : num [1:4] 0.00028 -0.13029 0.02767 -0.00148
      ..$ timec3      : num [1:4] 2.91e-04 6.66e-03 -1.48e-03 8.21e-05
     $ :'data.frame':   4 obs. of  4 variables:
      ..$ X.Intercept.: num [1:4] 1 -0.11782 0.00136 0.02598
      ..$ timec       : num [1:4] -0.118 1 -0.954 0.895
      ..$ timec2      : num [1:4] 0.00136 -0.95379 1 -0.98438
      ..$ timec3      : num [1:4] 0.026 0.895 -0.984 1
     $ : Named num [1:8] 3.365265 -0.133152 -0.13205 -0.019508 0.000712 ...
      ..- attr(*, "names")= chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
     $ :Formal class 'corMatrix' [package "Matrix"] with 6 slots
      .. ..@ sd      : num [1:8] 0.22206 0.07489 0.16415 0.04198 0.00321 ...
      .. ..@ x       : num [1:64] 1 -0.84315 -0.0847 -0.00788 0.03823 ...
      .. ..@ Dim     : int [1:2] 8 8
      .. ..@ Dimnames:List of 2
      .. .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
      .. .. ..$ : chr [1:8] "(Intercept)" "agec" "timec" "timec2" ...
      .. ..@ uplo    : chr "U"
      .. ..@ factors :List of 1
      .. .. ..$ Cholesky:Formal class 'Cholesky' [package "Matrix"] with 5 slots
      .. .. .. .. ..@ x       : num [1:64] 1 0 0 0 0 ...
      .. .. .. .. ..@ Dim     : int [1:2] 8 8
      .. .. .. .. ..@ Dimnames:List of 2
      .. .. .. .. .. ..$ : NULL
      .. .. .. .. .. ..$ : NULL
      .. .. .. .. ..@ uplo    : chr "U"
      .. .. .. .. ..@ diag    : chr "N"
     $ : num 1.07
     $ :'data.frame':   1873 obs. of  13 variables:
      ..$ X.Intercept.: num [1:1873] 1 1 1 1 1 1 1 1 1 1 ...
      ..$ agec        : num [1:1873] 3 4 5 6 7 8 9 10 11 12 ...
      ..$ timec       : num [1:1873] 0 1 2 3 4 5 6 7 8 9 ...
      ..$ timec2      : num [1:1873] 0 1 4 9 16 25 36 49 64 81 ...
      ..$ timec3      : num [1:1873] 0 1 8 27 64 125 216 343 512 729 ...
      ..$ agec.timec  : num [1:1873] 0 4 10 18 28 40 54 70 88 108 ...
      ..$ agec.timec2 : num [1:1873] 0 4 20 54 112 200 324 490 704 972 ...
      ..$ agec.timec3 : num [1:1873] 0 4 40 162 448 ...
      ..$ id          : Factor w/ 191 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
      ..$ y           : num [1:1873] 1 6 2 1 1 1 1 1 1 1 ...
      ..$ yHat        : num [1:1873] 2.77 2.43 2.12 1.83 1.58 ...
      ..$ resid       : num [1:1873] -1.766 3.569 -0.119 -0.834 -0.582 ...
      ..$ yPar        : num [1:1873] 2.97 2.83 2.72 2.63 2.56 ...
