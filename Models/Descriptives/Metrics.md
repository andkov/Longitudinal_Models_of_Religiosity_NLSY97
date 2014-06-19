<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external code file. -->



====================================== explains how the response
categories from NLSY97 questionnaire are labeled and demonstrates
application of labeled factors in data operations and graphing.

Sections: 1. Labeling Factor Levels 2. Age-Period-Cohort structure 3.
Mapping Church Attendance 4. Selecting & Augmenting datasets for
modeling

    ## Warning: there is no package called 'pandoc'

Age-Period-Cohort Structure
---------------------------

NLSY97 sample includes individuals from five cohorts, born between 1980
and 1984.The following graphics shows how birth cohort, age of
respondents, and round of observation are related in NSLY97.
<img src="./figure_rmd/3_Methods_Figure_3_1.png" alt="Looking up items" style="width:700px ;"/>

There are several indicators of age in NSLY97 that vary in precision.
Birth cohort is the most general one, it was recorded once. Two
variables were recorded at each interview: age at the time of the
interview in months (**agemon**) and years (**ageyear**). Those are not
derivatives of each other, but, understandably, are closely related. The
variable **ageyear** records the full number of years a respondent
reached at the time of the interview. Due to difficulties of
administering the survey, time intervals between the waves could differ.

    dsLCM<-dsL[dsL$year %in% c(2000:2011),c('id',"byear","year","attend","ageyear","agemon")]
    ds<- dsLCM[dsLCM$id %in% c(25),]
    ds$age<-ds$year-ds$byear
    ds$ageALT<- ds$agemon/12
    print(ds)

    ##     id byear year attend ageyear agemon age ageALT
    ## 364 25  1983 2000      5      17    214  17  17.83
    ## 365 25  1983 2001      7      18    226  18  18.83
    ## 366 25  1983 2002      7      19    236  19  19.67
    ## 367 25  1983 2003      2      21    254  20  21.17
    ## 368 25  1983 2004      7      21    261  21  21.75
    ## 369 25  1983 2005      5      22    272  22  22.67
    ## 370 25  1983 2006      7      23    284  23  23.67
    ## 371 25  1983 2007      5      24    295  24  24.58
    ## 372 25  1983 2008      7      25    307  25  25.58
    ## 373 25  1983 2009      7      26    319  26  26.58
    ## 374 25  1983 2010      7      27    332  27  27.67
    ## 375 25  1983 2011      7      28    342  28  28.50

For example, for one person **id**=25 the age was recorded as 21 years
for both 2003 and 2004 (see **ageyear**). However, when you examine age
in months (**agemon**) you can see this is rounding issue that
disappears once a more precise scale is used. To avoid this potentially
confusing peculiarity, age in years will be either calculated as
computed as (**age** = **year** - **byear**) or as (**ageALT** =
**agemon**/12).
