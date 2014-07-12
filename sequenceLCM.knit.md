---
title: "Model sequence report"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 2
    fig_width: 8
    toc: yes
    keep_md: false
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











# About
The origin of the data for the model  

```r
numID<- 9022 # highest id value (max = 9022)
### Define the data that will populate the model
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id < numID) %.% # 1:9022
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
```


# Model specification  
General case of LCM and model sequence are defined  

```r
############################
```

## m0F -- Fixed only
<img src="sequence/m0F.png" title="plot of chunk m0F" alt="plot of chunk m0F" width="1344" />

## m1F 
<img src="sequence/m1F.png" title="plot of chunk m1F" alt="plot of chunk m1F" width="1344" />

## m2F 
<img src="sequence/m2F.png" title="plot of chunk m2F" alt="plot of chunk m2F" width="1344" />

## m3F 
<img src="sequence/m3F.png" title="plot of chunk m3F" alt="plot of chunk m3F" width="1344" />

## m4F 
<img src="sequence/m4F.png" title="plot of chunk m4F" alt="plot of chunk m4F" width="1344" />

## m5F 
<img src="sequence/m5F.png" title="plot of chunk m5F" alt="plot of chunk m5F" width="1344" />

## m6F 
<img src="sequence/m6F.png" title="plot of chunk m6F" alt="plot of chunk m6F" width="1344" />

## m7F 
<img src="sequence/m7F.png" title="plot of chunk m7F" alt="plot of chunk m7F" width="1344" />

## mFa --  
<img src="sequence/mFa.png" title="plot of chunk mFa" alt="plot of chunk mFa" width="1344" />

## mFb 
<img src="sequence/mFb.png" title="plot of chunk mFb" alt="plot of chunk mFb" width="1344" />


## mFc 
<img src="sequence/mFc.png" title="plot of chunk mFc" alt="plot of chunk mFc" width="1344" />

## mFf 
<img src="sequence/mFf.png" title="plot of chunk mFf" alt="plot of chunk mFf" width="1344" />

## mFd 
<img src="sequence/mFd.png" title="plot of chunk mFd" alt="plot of chunk mFd" width="1344" />


## mFe 
<img src="sequence/mFe.png" title="plot of chunk mFe" alt="plot of chunk mFe" width="1344" />

## m1R1 -- 1 Random
<img src="sequence/m1R1.png" title="plot of chunk m1R1" alt="plot of chunk m1R1" width="1344" />


## m2R1 
<img src="sequence/m2R1.png" title="plot of chunk m2R1" alt="plot of chunk m2R1" width="1344" />


## m3R1 










































































