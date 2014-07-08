---
title: "Descriptives"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 2
    fig_width: 8
    number_sections: yes
    theme: united
    toc: yes
  md_document:
    toc: yes
    toc_depth: 3
  pdf_document:
    fig_caption: no
    fig_crop: no
    fig_width: 8
    highlight: kate
    latex_engine: xelatex
    number_sections: yes
    toc: yes
    toc_depth: 3
  word_document:
    fig_width: 6.5
mainfont: Calibri
---


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->










Metrics 
===

Labeling factors and exploring scales.   
[back to Appendix][appendix]


## Data preliminaries

Initial point of departure - the [databox][databox] of the selected variables, described in the Methods chapter.  
![Figure 3.2](../../images/databox_slice.png)
This [databox][databoxStatcanvas] corresponds to the dataset **dsL** produced by [Derive_dsL_from_Extract][derive] report, given in the Appendix.     

```r
dsL<-readRDS("./Data/Derived/dsL.rds")
```
![Figure 3.3](./figure_rmd/3_Methods_Figure_3_3.png)     

Note that the variable **year** serves as a natural devided between time invariant (TIvars) and time variant (TVvars) variables. All modeling operations beging with subsetting this dataset.  For the grammer rules of operations with relevant data see [Data Manipulation Guide][manipulate].


##  Labeling Factor Levels
Review of the item reference [cards][databoxStatcanvas] shows that initially, all items were recorded on some discrete scale, either counting occasions or assigning an intiger to a category of response. However, data were saved as numerical values or  intigers

```r
require(dplyr)
ds<- dsL %>%
  dplyr::select(
        sample, id, sex, race, bmonth,byear, attendPR, relprefPR,relraisedPR,
    year,
        agemon, ageyear, famrel, attend,
        values, todo, obeyed, pray, decisions, 
        relpref, bornagain, faith, 
        calm, blue, happy, depressed, nervous,
        tv, computer, internet)               
str(ds)
```

```
'data.frame':	134745 obs. of  30 variables:
 $ sample     : int  1 1 1 1 1 1 1 1 1 1 ...
 $ id         : int  1 1 1 1 1 1 1 1 1 1 ...
 $ sex        : int  2 2 2 2 2 2 2 2 2 2 ...
 $ race       : int  4 4 4 4 4 4 4 4 4 4 ...
 $ bmonth     : int  9 9 9 9 9 9 9 9 9 9 ...
 $ byear      : int  1981 1981 1981 1981 1981 1981 1981 1981 1981 1981 ...
 $ attendPR   : int  7 7 7 7 7 7 7 7 7 7 ...
 $ relprefPR  : int  21 21 21 21 21 21 21 21 21 21 ...
 $ relraisedPR: int  21 21 21 21 21 21 21 21 21 21 ...
 $ year       : int  1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 ...
 $ agemon     : num  190 206 219 231 243 256 266 279 290 302 ...
 $ ageyear    : num  15 17 18 19 20 21 22 23 24 25 ...
 $ famrel     : num  NA NA NA NA NA NA NA NA NA NA ...
 $ attend     : num  NA NA NA 1 6 2 1 1 1 1 ...
 $ values     : num  NA NA NA NA NA 1 NA NA 0 NA ...
 $ todo       : num  NA NA NA NA NA 1 NA NA 1 NA ...
 $ obeyed     : num  NA NA NA NA NA 1 NA NA 0 NA ...
 $ pray       : num  NA NA NA NA NA 0 NA NA 0 NA ...
 $ decisions  : num  NA NA NA NA NA 1 NA NA 1 NA ...
 $ relpref    : num  NA NA NA NA NA NA NA NA 21 NA ...
 $ bornagain  : num  NA NA NA NA NA NA NA NA NA NA ...
 $ faith      : num  NA NA NA NA NA NA NA NA NA NA ...
 $ calm       : num  NA NA NA 3 NA 4 NA 4 NA 4 ...
 $ blue       : num  NA NA NA 3 NA 2 NA 1 NA 1 ...
 $ happy      : num  NA NA NA 3 NA 3 NA 4 NA 4 ...
 $ depressed  : num  NA NA NA 3 NA 2 NA 1 NA 1 ...
 $ nervous    : num  NA NA NA 3 NA 1 NA 1 NA 1 ...
 $ tv         : num  NA NA NA NA NA 2 NA NA NA NA ...
 $ computer   : num  NA NA NA NA NA 5 NA NA NA NA ...
 $ internet   : num  NA NA NA NA NA NA 1 0 1 1 ...
```

[LabelingFactorLevels.R][labels] sourced at the end of [Derive_dsL_from_Extract][derive] matches numeric values with response labels from the questionnaire and adds copies of the variables, saved as labeled factors, to **dsL**. For estimations routines such as <code>lme4</code> or graphing  functions such as <code>ggplot2</code>, the  data type (string,numeric,  factor) is a meaningful input, so a quick access to both formats frequently proves useful.  It is convenient to think that **dsL** contains only

```r
ncol(dsL)/2
```

```
[1] 30
```
variables, but each of them has a double, a labeled factor.

```r
str(dsL)
```

```
'data.frame':	134745 obs. of  60 variables:
 $ sample      : int  1 1 1 1 1 1 1 1 1 1 ...
 $ id          : int  1 1 1 1 1 1 1 1 1 1 ...
 $ sex         : int  2 2 2 2 2 2 2 2 2 2 ...
 $ race        : int  4 4 4 4 4 4 4 4 4 4 ...
 $ bmonth      : int  9 9 9 9 9 9 9 9 9 9 ...
 $ byear       : int  1981 1981 1981 1981 1981 1981 1981 1981 1981 1981 ...
 $ attendPR    : int  7 7 7 7 7 7 7 7 7 7 ...
 $ relprefPR   : int  21 21 21 21 21 21 21 21 21 21 ...
 $ relraisedPR : int  21 21 21 21 21 21 21 21 21 21 ...
 $ year        : int  1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 ...
 $ agemon      : num  190 206 219 231 243 256 266 279 290 302 ...
 $ ageyear     : num  15 17 18 19 20 21 22 23 24 25 ...
 $ famrel      : num  NA NA NA NA NA NA NA NA NA NA ...
 $ attend      : num  NA NA NA 1 6 2 1 1 1 1 ...
 $ values      : num  NA NA NA NA NA 1 NA NA 0 NA ...
 $ todo        : num  NA NA NA NA NA 1 NA NA 1 NA ...
 $ obeyed      : num  NA NA NA NA NA 1 NA NA 0 NA ...
 $ pray        : num  NA NA NA NA NA 0 NA NA 0 NA ...
 $ decisions   : num  NA NA NA NA NA 1 NA NA 1 NA ...
 $ relpref     : num  NA NA NA NA NA NA NA NA 21 NA ...
 $ bornagain   : num  NA NA NA NA NA NA NA NA NA NA ...
 $ faith       : num  NA NA NA NA NA NA NA NA NA NA ...
 $ calm        : num  NA NA NA 3 NA 4 NA 4 NA 4 ...
 $ blue        : num  NA NA NA 3 NA 2 NA 1 NA 1 ...
 $ happy       : num  NA NA NA 3 NA 3 NA 4 NA 4 ...
 $ depressed   : num  NA NA NA 3 NA 2 NA 1 NA 1 ...
 $ nervous     : num  NA NA NA 3 NA 1 NA 1 NA 1 ...
 $ tv          : num  NA NA NA NA NA 2 NA NA NA NA ...
 $ computer    : num  NA NA NA NA NA 5 NA NA NA NA ...
 $ internet    : num  NA NA NA NA NA NA 1 0 1 1 ...
 $ sampleF     : Ord.factor w/ 2 levels "Cross-Sectional"<..: 1 1 1 1 1 1 1 1 1 1 ...
 $ idF         : Factor w/ 8983 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ sexF        : Ord.factor w/ 3 levels "Male"<"Female"<..: 2 2 2 2 2 2 2 2 2 2 ...
 $ raceF       : Ord.factor w/ 4 levels "Black"<"Hispanic"<..: 4 4 4 4 4 4 4 4 4 4 ...
 $ bmonthF     : Ord.factor w/ 12 levels "Jan"<"Feb"<"Mar"<..: 9 9 9 9 9 9 9 9 9 9 ...
 $ byearF      : Factor w/ 5 levels "1980","1981",..: 2 2 2 2 2 2 2 2 2 2 ...
 $ attendPRF   : Ord.factor w/ 8 levels "Never"<"Once or Twice"<..: 7 7 7 7 7 7 7 7 7 7 ...
 $ relprefPRF  : Ord.factor w/ 33 levels "Catholic"<"Baptist"<..: 21 21 21 21 21 21 21 21 21 21 ...
 $ relraisedPRF: Ord.factor w/ 33 levels "Catholic"<"Baptist"<..: 21 21 21 21 21 21 21 21 21 21 ...
 $ yearF       : Factor w/ 15 levels "1997","1998",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ agemonF     : Factor w/ 244 levels "146","147","148",..: 45 61 74 86 98 111 121 134 145 157 ...
 $ ageyearF    : Factor w/ 21 levels "12","13","14",..: 4 6 7 8 9 10 11 12 13 14 ...
 $ famrelF     : Factor w/ 8 levels "0","1","2","3",..: NA NA NA NA NA NA NA NA NA NA ...
 $ attendF     : Ord.factor w/ 8 levels "Never"<"Once or Twice"<..: NA NA NA 1 6 2 1 1 1 1 ...
 $ valuesF     : Ord.factor w/ 2 levels "FALSE/less Religious"<..: NA NA NA NA NA 2 NA NA 1 NA ...
 $ todoF       : Ord.factor w/ 2 levels "FALSE/less Religious"<..: NA NA NA NA NA 2 NA NA 2 NA ...
 $ obeyedF     : Ord.factor w/ 2 levels "FALSE/less Religious"<..: NA NA NA NA NA 2 NA NA 1 NA ...
 $ prayF       : Ord.factor w/ 2 levels "FALSE/less Religious"<..: NA NA NA NA NA 1 NA NA 1 NA ...
 $ decisionsF  : Ord.factor w/ 2 levels "FALSE/less Religious"<..: NA NA NA NA NA 2 NA NA 2 NA ...
 $ relprefF    : Ord.factor w/ 33 levels "Catholic"<"Baptist"<..: NA NA NA NA NA NA NA NA 21 NA ...
 $ bornagainF  : Ord.factor w/ 2 levels "NO"<"YES": NA NA NA NA NA NA NA NA NA NA ...
 $ faithF      : Ord.factor w/ 5 levels "Exrtemely"<"Very"<..: NA NA NA NA NA NA NA NA NA NA ...
 $ calmF       : Ord.factor w/ 4 levels "All of the time"<..: NA NA NA NA NA NA NA NA NA NA ...
 $ blueF       : Ord.factor w/ 4 levels "All of the time"<..: NA NA NA NA NA NA NA NA NA NA ...
 $ happyF      : Ord.factor w/ 4 levels "All of the time"<..: NA NA NA NA NA NA NA NA NA NA ...
 $ depressedF  : Ord.factor w/ 4 levels "All of the time"<..: NA NA NA NA NA NA NA NA NA NA ...
 $ nervousF    : Ord.factor w/ 4 levels "All of the time"<..: NA NA NA NA NA NA NA NA NA NA ...
 $ tvF         : Ord.factor w/ 6 levels "less than 2"<..: NA NA NA NA NA 2 NA NA NA NA ...
 $ computerF   : Ord.factor w/ 6 levels "None"<"less than 1"<..: NA NA NA NA NA 5 NA NA NA NA ...
 $ internetF   : Ord.factor w/ 2 levels "No"<"Yes": NA NA NA NA NA NA 2 1 2 2 ...
```
This give a certain flexibity in assembling needed dataset quickly and have access to factor labels. One can alternate between the raw metric and labeled factor by adding "F" suffix to the end of the variable name:

```r
ds<- dsL %>%
  dplyr::filter(id==25) %>%
  dplyr::select(id,byear,year, attend,attendF)
ds
```

```
   id byear year attend            attendF
1  25  1983 1997     NA               <NA>
2  25  1983 1998     NA               <NA>
3  25  1983 1999     NA               <NA>
4  25  1983 2000      5  About twice/month
5  25  1983 2001      7 Several times/week
6  25  1983 2002      7 Several times/week
7  25  1983 2003      2      Once or Twice
8  25  1983 2004      7 Several times/week
9  25  1983 2005      5  About twice/month
10 25  1983 2006      7 Several times/week
11 25  1983 2007      5  About twice/month
12 25  1983 2008      7 Several times/week
13 25  1983 2009      7 Several times/week
14 25  1983 2010      7 Several times/week
15 25  1983 2011      7 Several times/week
```
Having quick access to factor labels will be especially useful during graph production.


## Time metrics : Age, Period, Cohort
NLSY97 sample includes individuals from five cohorts, born between 1980 and 1984.The following graphics shows how birth cohort, age of respondents, and round of observation are related in NSLY97.  
![Figure 3.1](../../images/APC_layout.png)

### Counts of respondents across age, period, and cohort

```r
ds<- dsL %>%  # chose conditions to apply in creating the dataset 
  dplyr::filter(id %in% c(1:9022)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(0,1)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(1:4)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %.%
  dplyr::mutate(age=year-byear) # define bin for age
```

#### Wide age  

```r
table(ds$byear, ds$age)
```

```
      
         16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31
  1980    0    0    0    0 1691 1691 1691 1691 1691 1691 1691 1691 1691 1691 1691 1691
  1981    0    0    0 1874 1874 1874 1874 1874 1874 1874 1874 1874 1874 1874 1874    0
  1982    0    0 1841 1841 1841 1841 1841 1841 1841 1841 1841 1841 1841 1841    0    0
  1983    0 1807 1807 1807 1807 1807 1807 1807 1807 1807 1807 1807 1807    0    0    0
  1984 1770 1770 1770 1770 1770 1770 1770 1770 1770 1770 1770 1770    0    0    0    0
```

#### Wide wave  

```r
table(ds$byear,ds$year)
```

```
      
       2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  1980 1691 1691 1691 1691 1691 1691 1691 1691 1691 1691 1691 1691
  1981 1874 1874 1874 1874 1874 1874 1874 1874 1874 1874 1874 1874
  1982 1841 1841 1841 1841 1841 1841 1841 1841 1841 1841 1841 1841
  1983 1807 1807 1807 1807 1807 1807 1807 1807 1807 1807 1807 1807
  1984 1770 1770 1770 1770 1770 1770 1770 1770 1770 1770 1770 1770
```

#### Long wave  

```r
table(ds$year,ds$byear)
```

```
      
       1980 1981 1982 1983 1984
  2000 1691 1874 1841 1807 1770
  2001 1691 1874 1841 1807 1770
  2002 1691 1874 1841 1807 1770
  2003 1691 1874 1841 1807 1770
  2004 1691 1874 1841 1807 1770
  2005 1691 1874 1841 1807 1770
  2006 1691 1874 1841 1807 1770
  2007 1691 1874 1841 1807 1770
  2008 1691 1874 1841 1807 1770
  2009 1691 1874 1841 1807 1770
  2010 1691 1874 1841 1807 1770
  2011 1691 1874 1841 1807 1770
```
#### Long age  

```r
table(ds$age,ds$byear)
```

```
    
     1980 1981 1982 1983 1984
  16    0    0    0    0 1770
  17    0    0    0 1807 1770
  18    0    0 1841 1807 1770
  19    0 1874 1841 1807 1770
  20 1691 1874 1841 1807 1770
  21 1691 1874 1841 1807 1770
  22 1691 1874 1841 1807 1770
  23 1691 1874 1841 1807 1770
  24 1691 1874 1841 1807 1770
  25 1691 1874 1841 1807 1770
  26 1691 1874 1841 1807 1770
  27 1691 1874 1841 1807 1770
  28 1691 1874 1841 1807    0
  29 1691 1874 1841    0    0
  30 1691 1874    0    0    0
  31 1691    0    0    0    0
```

#### Two time metrics: rounds across ages 

```r
table(ds$age,ds$year)
```

```
    
     2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  16 1770    0    0    0    0    0    0    0    0    0    0    0
  17 1807 1770    0    0    0    0    0    0    0    0    0    0
  18 1841 1807 1770    0    0    0    0    0    0    0    0    0
  19 1874 1841 1807 1770    0    0    0    0    0    0    0    0
  20 1691 1874 1841 1807 1770    0    0    0    0    0    0    0
  21    0 1691 1874 1841 1807 1770    0    0    0    0    0    0
  22    0    0 1691 1874 1841 1807 1770    0    0    0    0    0
  23    0    0    0 1691 1874 1841 1807 1770    0    0    0    0
  24    0    0    0    0 1691 1874 1841 1807 1770    0    0    0
  25    0    0    0    0    0 1691 1874 1841 1807 1770    0    0
  26    0    0    0    0    0    0 1691 1874 1841 1807 1770    0
  27    0    0    0    0    0    0    0 1691 1874 1841 1807 1770
  28    0    0    0    0    0    0    0    0 1691 1874 1841 1807
  29    0    0    0    0    0    0    0    0    0 1691 1874 1841
  30    0    0    0    0    0    0    0    0    0    0 1691 1874
  31    0    0    0    0    0    0    0    0    0    0    0 1691
```

NSLY97 contains static (**bmonth**, **byear**) and dynamic (**agemon**, **ageyear**) indicators of age : 


```r
ds<- dsL %>% 
  dplyr::filter(id==25, year %in% c(1997:2011)) %>% 
  dplyr::select(id,byear,bmonthF,year,agemon,ageyear)
print(ds)
```

```
   id byear bmonthF year agemon ageyear
1  25  1983     Mar 1997    167      13
2  25  1983     Mar 1998    188      15
3  25  1983     Mar 1999    201      16
4  25  1983     Mar 2000    214      17
5  25  1983     Mar 2001    226      18
6  25  1983     Mar 2002    236      19
7  25  1983     Mar 2003    254      21
8  25  1983     Mar 2004    261      21
9  25  1983     Mar 2005    272      22
10 25  1983     Mar 2006    284      23
11 25  1983     Mar 2007    295      24
12 25  1983     Mar 2008    307      25
13 25  1983     Mar 2009    319      26
14 25  1983     Mar 2010    332      27
15 25  1983     Mar 2011    342      28
```

Variable **year** is used as cohort indicator. Variable **year** enumerates NLSY97 rounds, recording the calendaric year during which it took place. When transforming the metric of time, and using biological age instead of **year** as the temporal dimension, the value of age at the time of the interview will be computed as **age** = **agemon**/12  


```r
ds<- dsL %>% 
  dplyr::filter(id==25, year %in% c(1997:2011)) %>% 
  dplyr::select(id,bmonthF,byear,year, agemon,ageyear) %>%
  dplyr::mutate (age =  agemon/12)
print(ds)
```

```
   id bmonthF byear year agemon ageyear   age
1  25     Mar  1983 1997    167      13 13.92
2  25     Mar  1983 1998    188      15 15.67
3  25     Mar  1983 1999    201      16 16.75
4  25     Mar  1983 2000    214      17 17.83
5  25     Mar  1983 2001    226      18 18.83
6  25     Mar  1983 2002    236      19 19.67
7  25     Mar  1983 2003    254      21 21.17
8  25     Mar  1983 2004    261      21 21.75
9  25     Mar  1983 2005    272      22 22.67
10 25     Mar  1983 2006    284      23 23.67
11 25     Mar  1983 2007    295      24 24.58
12 25     Mar  1983 2008    307      25 25.58
13 25     Mar  1983 2009    319      26 26.58
14 25     Mar  1983 2010    332      27 27.67
15 25     Mar  1983 2011    342      28 28.50
```

## Attendance  

NLSY97 asked to report church attendance (**attend**) for the past 12 months preceding the interview date. The response card offered a choice of 7 categories ordered by magnitude.  

<img src="appendix/attend_2000.png" title="Figure caption test" alt="Figure caption test" width="3200" />

Descriptives
===


Basic descriptives reports on the selected NLSY97 items   
[back to Appendix][appendix]

## Basic demographics 
A clean dataset **dsL** contains data on


```r
dplyr::summarize(dsL,count=n_distinct(id))
```

```
  count
1  8983
```
respondents. Of them one (id = 467) was removed from the dataset due to abberant age score that seemed as a coding mistake. NLSY97 contains representative household sample and the oversample of racial minorities. 


```r
ds<- dsL %>% 
  dplyr::group_by(sampleF) %>% 
  dplyr::summarize (count=n_distinct(id))
ds
```

```
Source: local data frame [2 x 2]

          sampleF count
1 Cross-Sectional  6747
2      Oversample  2236
```



<img src="appendix/basic_demo.png" title="plot of chunk basic_demo" alt="plot of chunk basic_demo" width="3200" />

## Distribution of age variables
The age of respondents was of particular interest and was entered as a predictor of the model outcome. NSLY97 contains static and dynamic indicators of age age. Variables  byear and bmonth were recorded once in 1997 (static) and contain respondents’ birth year and birth month respectively. Two age variables were recorded continuously at each interview (dynamic): age at the time of the interview in months (**agemon**) and in years (**ageyear**).   Next graph shows how births in the NLSY97 sample  was distributed over calendric months from 1980 to 1984:

### Months of births

```
Source: local data frame [10 x 5]
Groups: bmonth, bmonthF

   bmonth bmonthF byear count born
1       1     Jan  1980   159 1980
2       2     Feb  1980   136 1980
3       3     Mar  1980   139 1980
4       4     Apr  1980   125 1980
5       5     May  1980   128 1980
6       6     Jun  1980   137 1980
7       7     Jul  1980   136 1981
8       8     Aug  1980   141 1981
9       9     Sep  1980   144 1981
10     10     Oct  1980   146 1981
```

<img src="appendix/bmonth_dist.png" title="plot of chunk bmonth_dist" alt="plot of chunk bmonth_dist" width="3200" />


### Age and cohort structure 
<img src="appendix/agemon_dist.png" title="plot of chunk agemon_dist" alt="plot of chunk agemon_dist" width="3200" />


###  Count of respondents in age bins
The amounts of respondents in in the age bin =16 is not big, so results should be interpreted with caution.
<img src="appendix/attend_race_age_binsize.png" title="plot of chunk attend_race_age_binsize" alt="plot of chunk attend_race_age_binsize" width="4000" />


```r
ds<- dsL %.%
  dplyr::mutate(ageF = as.factor(round(agemon/12 ))) %>%
  dplyr::filter(year %in% c(2000:2011), !is.na(attend),ageF %in% c(16,32),race !=3) %.%   
  dplyr::group_by(sampleF,raceF) %.%
  dplyr::summarize(count = n()) 
head(ds, 10)
```

```
Source: local data frame [5 x 3]
Groups: sampleF

          sampleF       raceF count
1 Cross-Sectional       Black   187
2 Cross-Sectional    Hispanic   153
3 Cross-Sectional Non-B/Non-H   687
4      Oversample       Black   174
5      Oversample    Hispanic   140
```


## Counts for data used in models
The following tables inspect the counts of valid responses (church attendance) across two time metircs (age and NLSY97 round) and cohort membership. 

```r
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id %in% c(1:9022)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(0,1)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(1:4)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %>% # birth year 1980:1984
  dplyr::mutate(age=round(agemon/12,0)) # define bin for age
length(unique(ds$id)) # total No. of respondents in dataset
```

```
[1] 8983
```


```r
d<- ds %>% 
  filter(!is.na(attend)) # only nonmissing datapoints
table(d$byear,d$year) # Number of respondent in each NLSY97 round 
```

```
      
       2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  1980 1423 1404 1409 1383 1319 1307 1334 1327 1327 1366 1317 1297
  1981 1617 1578 1582 1562 1477 1416 1502 1462 1472 1502 1501 1497
  1982 1656 1601 1612 1588 1529 1506 1521 1502 1507 1529 1502 1477
  1983 1672 1636 1629 1603 1506 1491 1525 1499 1512 1502 1495 1480
  1984 1650 1630 1632 1578 1484 1463 1488 1473 1459 1460 1455 1440
```

```r
table(d$byear, d$age) # Number of respondent in each age bin 
```

```
      
         16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32
  1980    0    0    0    0  702 1315 1549 1350 1414 1245 1456 1290 1406 1343 1342 1327  474
  1981    0    0    0  690 1743 1466 1780 1328 1614 1386 1687 1306 1737 1247 1753  431    0
  1982    0    0  848 1528 1766 1510 1629 1448 1699 1444 1594 1517 1491 1503  553    0    0
  1983    0  724 1815 1519 1767 1376 1681 1449 1713 1329 1765 1250 1752  410    0    0    0
  1984  879 1535 1758 1550 1580 1416 1635 1425 1530 1479 1447 1464  514    0    0    0    0
```

```r
table(d$age,d$year) # cross-section of age and round of NLSY97
```

```
    
     2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  16  879    0    0    0    0    0    0    0    0    0    0    0
  17 1495  764    0    0    0    0    0    0    0    0    0    0
  18 1796 1733  892    0    0    0    0    0    0    0    0    0
  19 1498 1489 1490  810    0    0    0    0    0    0    0    0
  20 1629 1697 1764 1656  812    0    0    0    0    0    0    0
  21  721 1356 1430 1499 1333  744    0    0    0    0    0    0
  22    0  810 1618 1706 1669 1555  916    0    0    0    0    0
  23    0    0  669 1341 1373 1398 1366  853    0    0    0    0
  24    0    0    1  702 1520 1568 1667 1602  910    0    0    0
  25    0    0    0    0  608 1248 1360 1376 1361  930    0    0
  26    0    0    0    0    0  670 1513 1603 1651 1595  917    0
  27    0    0    0    0    0    0  548 1244 1360 1398 1351  926
  28    0    0    0    0    0    0    0  585 1489 1637 1605 1584
  29    0    0    0    0    0    0    0    0  506 1270 1393 1334
  30    0    0    0    0    0    0    0    0    0  529 1500 1619
  31    0    0    0    0    0    0    0    0    0    0  504 1254
  32    0    0    0    0    0    0    0    0    0    0    0  474
```

When subsetting data to run throught the sequence of models, it would of use to see such counts. Insufficient number of observation per cell might be behind poor model estimation. For example, male blacks from the oversample may not be a good subset to fit a complex model. 

```r
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id %in% c(1:9022)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(0)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(1)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %>% # birth year 1980:1984
  dplyr::filter(sex==1) %>% # 1-Male; 2-Female
  dplyr::mutate(age=round(agemon/12,0)) # define bin for age

length(unique(ds$id)) # total No. of respondents in dataset
```

```
[1] 632
```


```r
d<- ds %>% 
  filter(!is.na(attend)) # only nonmissing datapoints
table(d$byear,d$year) # Number of respondent in each NLSY97 round 
```

```
      
       2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  1980   89   89   92   90   80   80   80   82   82   79   79   82
  1981  139  127  137  140  113  112  127  121  121  116  123  122
  1982  127  116  125  121  107  114  115  109  112  111  110  111
  1983  115  112  112  108   96   99  102  100  100   96   93   92
  1984  104   96   99   94   84   92   87   81   88   80   93   91
```

```r
table(d$byear, d$age) # Number of respondent in each age bin 
```

```
      
        16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32
  1980   0   0   0   0  51  79 102  87  89  79  79  88  77  87  76  82  28
  1981   0   0   0  62 151 120 159 106 128 114 138 111 138  96 143  32   0
  1982   0   0  57 119 136 116 120 103 128 109 112 116 104 113  45   0   0
  1983   0  47 130 102 118  86 118  92 112  89 116  82 108  25   0   0   0
  1984  48 102  98  99  89  81 104  81  88  84  83  96  36   0   0   0   0
```

```r
table(d$age,d$year) # cross-section of age and round of NLSY97
```

```
    
     2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  16   48    0    0    0    0    0    0    0    0    0    0    0
  17  103   46    0    0    0    0    0    0    0    0    0    0
  18  125  112   48    0    0    0    0    0    0    0    0    0
  19  132   99  103   48    0    0    0    0    0    0    0    0
  20  128  141  129  104   43    0    0    0    0    0    0    0
  21   38   94  123  110   77   40    0    0    0    0    0    0
  22    0   48  124  150  119  110   52    0    0    0    0    0
  23    0    0   38  100  103   96   86   46    0    0    0    0
  24    0    0    0   41  106  129  120   96   53    0    0    0
  25    0    0    0    0   32   89  118  102   85   49    0    0
  26    0    0    0    0    0   33  101  129  116   97   52    0
  27    0    0    0    0    0    0   34   92  119  100   93   55
  28    0    0    0    0    0    0    0   28   97  131  104  103
  29    0    0    0    0    0    0    0    0   33   80  117   91
  30    0    0    0    0    0    0    0    0    0   25  104  135
  31    0    0    0    0    0    0    0    0    0    0   28   86
  32    0    0    0    0    0    0    0    0    0    0    0   28
```

Attendance
===
Mapping church attendance in time   
[back to Appendix][appendix]

# Cross-Sectional View  

The focal variable of interest is **attend**, the item measuring church attendance for the year that preceded the interview date. The questionnaire recorded the responses on the ordinal scale.

<img src="appendix/attend_2000b.png" title="Figure caption test" alt="Figure caption test" width="3200" />

Creating frequency distributions for each of the measurement wave we have:    

<img src="appendix/attend_2000_2011.png" title="plot of chunk attend_2000_2011" alt="plot of chunk attend_2000_2011" width="3200" />

Here, missing values are used in the calculation of total responses to show the natural attrition in the study. Assuming that attrition is not significantly associated with  the outcome measure, we can remove missing values from the calculation of the total and look at prevalence of response endorsements over time.     

<img src="appendix/attend_2000_2011_na.png" title="plot of chunk attend_2000_2011_na" alt="plot of chunk attend_2000_2011_na" width="3200" />

## Change in prevalences
Tracing the rate of change of prevalence in a line graph, we see more clearly which  categores increase over time (e.g. "Never"), which decline (e.g. ""About once/week), and which stay relatively stable (e.g. "About twice/month").    

<img src="appendix/attend_freq_lines.png" title="plot of chunk attend_freq_lines" alt="plot of chunk attend_freq_lines" width="3200" />

## Prevalence change and race 

Inspecting the prevalence trajectories across races.     

### Attend over race and years   
<img src="appendix/attend_freq_lines_race.png" title="plot of chunk attend_freq_lines_race" alt="plot of chunk attend_freq_lines_race" width="4000" />

### Attend over race and ages
Bin includes all respondents who were +/- 6 months from a given age expressed as an intiger.s
For example, a 16 year-old  is defined as an individual between 15.5 and 16.5 years of age at the time of the interview.   

<img src="appendix/attend_freq_lines_race_ages.png" title="plot of chunk attend_freq_lines_race_ages" alt="plot of chunk attend_freq_lines_race_ages" width="4000" />

### Race and attendance for each year
<img src="appendix/attend_race_2000.png" title="plot of chunk attend_race_2000" alt="plot of chunk attend_race_2000" width="4000" />

### Race and attendance for each age bin
<img src="appendix/attend_race_16.png" title="plot of chunk attend_race_16" alt="plot of chunk attend_race_16" width="4000" />

## Counts for data used in models
The following tables inspect the counts of valid responses (church attendance) across two time metircs (age and NLSY97 round) and cohort membership. 

```r
dsL<-readRDS("./Data/Derived/dsL.rds")
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id %in% c(1:9022)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(0,1)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(1:4)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %>% # birth year 1980:1984
  dplyr::mutate(age=year-byear) # define bin for age
length(unique(ds$id)) # total No. of respondents in dataset
```

```
[1] 8983
```


```r
d<- ds %>% 
  filter(is.na(attend)) # only nonmissing datapoints
table(d$byear,d$year) # Number of respondent in each NLSY97 round 
```

```
      
       2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  1980  268  287  282  308  372  384  357  364  364  325  374  394
  1981  257  296  292  312  397  458  372  412  402  372  373  377
  1982  185  240  229  253  312  335  320  339  334  312  339  364
  1983  135  171  178  204  301  316  282  308  295  305  312  327
  1984  120  140  138  192  286  307  282  297  311  310  315  330
```

```r
table(d$byear, d$age) # Number of respondent in each age bin 
```

```
      
        16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31
  1980   0   0   0   0 268 287 282 308 372 384 357 364 364 325 374 394
  1981   0   0   0 257 296 292 312 397 458 372 412 402 372 373 377   0
  1982   0   0 185 240 229 253 312 335 320 339 334 312 339 364   0   0
  1983   0 135 171 178 204 301 316 282 308 295 305 312 327   0   0   0
  1984 120 140 138 192 286 307 282 297 311 310 315 330   0   0   0   0
```

```r
table(d$age,d$year) # cross-section of age and round of NLSY97
```

```
    
     2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  16  120    0    0    0    0    0    0    0    0    0    0    0
  17  135  140    0    0    0    0    0    0    0    0    0    0
  18  185  171  138    0    0    0    0    0    0    0    0    0
  19  257  240  178  192    0    0    0    0    0    0    0    0
  20  268  296  229  204  286    0    0    0    0    0    0    0
  21    0  287  292  253  301  307    0    0    0    0    0    0
  22    0    0  282  312  312  316  282    0    0    0    0    0
  23    0    0    0  308  397  335  282  297    0    0    0    0
  24    0    0    0    0  372  458  320  308  311    0    0    0
  25    0    0    0    0    0  384  372  339  295  310    0    0
  26    0    0    0    0    0    0  357  412  334  305  315    0
  27    0    0    0    0    0    0    0  364  402  312  312  330
  28    0    0    0    0    0    0    0    0  364  372  339  327
  29    0    0    0    0    0    0    0    0    0  325  373  364
  30    0    0    0    0    0    0    0    0    0    0  374  377
  31    0    0    0    0    0    0    0    0    0    0    0  394
```

```r
table(d$attend,useNA="always")
```

```

 <NA> 
18123 
```

Such view allows to see quickly whether each cell contains enough observations to offer stability for estimated solutions. 


```r
ds<- dsL %>%  # chose conditions to apply in creating dataset for modeling
  dplyr::filter(id %in% c(1:9022)) %.% # 1:9022
  dplyr::filter(year %in% c(2000:2011)) %.% # 1997:2011
  dplyr::filter(sample %in% c(0)) %.% # 0-Oversample; 1-Cross-Sectional
  dplyr::filter(race %in% c(1)) %.% # 1-Black; 2-Hispanis; 3-Mixed; 4-White
  dplyr::filter(byear %in% c(1980:1984)) %>% # birth year 1980:1984
  dplyr::filter(sex==1) %>% # 1-Male; 2-Female
  dplyr::mutate(age=round(agemon/12,0)) # define bin for age
length(unique(ds$id)) # total No. of respondents in dataset
```

```
[1] 632
```


```r
d<- ds %>% 
  filter(!is.na(attend)) # only nonmissing datapoints
table(d$byear,d$year) # Number of respondent in each NLSY97 round 
```

```
      
       2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  1980   89   89   92   90   80   80   80   82   82   79   79   82
  1981  139  127  137  140  113  112  127  121  121  116  123  122
  1982  127  116  125  121  107  114  115  109  112  111  110  111
  1983  115  112  112  108   96   99  102  100  100   96   93   92
  1984  104   96   99   94   84   92   87   81   88   80   93   91
```

```r
table(d$byear, d$age) # Number of respondent in each age bin 
```

```
      
        16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32
  1980   0   0   0   0  51  79 102  87  89  79  79  88  77  87  76  82  28
  1981   0   0   0  62 151 120 159 106 128 114 138 111 138  96 143  32   0
  1982   0   0  57 119 136 116 120 103 128 109 112 116 104 113  45   0   0
  1983   0  47 130 102 118  86 118  92 112  89 116  82 108  25   0   0   0
  1984  48 102  98  99  89  81 104  81  88  84  83  96  36   0   0   0   0
```

```r
table(d$age,d$year) # cross-section of age and round of NLSY97
```

```
    
     2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011
  16   48    0    0    0    0    0    0    0    0    0    0    0
  17  103   46    0    0    0    0    0    0    0    0    0    0
  18  125  112   48    0    0    0    0    0    0    0    0    0
  19  132   99  103   48    0    0    0    0    0    0    0    0
  20  128  141  129  104   43    0    0    0    0    0    0    0
  21   38   94  123  110   77   40    0    0    0    0    0    0
  22    0   48  124  150  119  110   52    0    0    0    0    0
  23    0    0   38  100  103   96   86   46    0    0    0    0
  24    0    0    0   41  106  129  120   96   53    0    0    0
  25    0    0    0    0   32   89  118  102   85   49    0    0
  26    0    0    0    0    0   33  101  129  116   97   52    0
  27    0    0    0    0    0    0   34   92  119  100   93   55
  28    0    0    0    0    0    0    0   28   97  131  104  103
  29    0    0    0    0    0    0    0    0   33   80  117   91
  30    0    0    0    0    0    0    0    0    0   25  104  135
  31    0    0    0    0    0    0    0    0    0    0   28   86
  32    0    0    0    0    0    0    0    0    0    0    0   28
```



# Longitudinal View

Graphs above shows change in the cross-sectional distribution of responses over the years. Modeling the change in these response frequencies is handled well by Markov  models.  LCM, however, works with longitudinal data, modeling the trajectory of each individual and treating attendance as a continuous outcome.   

To demonstrate mapping of individual trajectories to time, let's select a  dataset that would include personal identifyer (**id**), cohort indicator (**byear**), wave of measurement (**year**) and the focal variable of interest - worship attendance (**attend**).    


```r
ds<- dsL %>%  dplyr::filter(year %in% c(2000:2011), id==47) %>%
              dplyr:: select(id, byear, year, attend, attendF)
print(ds)
```

```
   id byear year attend              attendF
1  47  1982 2000      5    About twice/month
2  47  1982 2001      2        Once or Twice
3  47  1982 2002      4     About once/month
4  47  1982 2003      2        Once or Twice
5  47  1982 2004      3 Less than once/month
6  47  1982 2005      2        Once or Twice
7  47  1982 2006      2        Once or Twice
8  47  1982 2007      3 Less than once/month
9  47  1982 2008      2        Once or Twice
10 47  1982 2009      1                Never
11 47  1982 2010      1                Never
12 47  1982 2011      1                Never
```

The view above lists attendance data for subjust with id = 47. Mapping his attendance to time we have  .  

<img src="appendix/attend_line_1id.png" title="plot of chunk attend_line_1id" alt="plot of chunk attend_line_1id" width="3200" />

where vertical dimension maps the outcome value and the horizontal maps the time. There will be a trajecory for each of the respondents. Each of such trajectories imply a story, a life scenario. Why one person grows in his religious involvement, while other declines, or never develops an interest in the first place? To demostrate how interpretations of trajectories can vary among individuals consider the following example.     

## Attendance over waves 
Attendance trajectories of subjects with **id**s  4, 25, 35, and 47 are plotted in the next graph     

<img src="appendix/attend_line_4id_years.png" title="plot of chunk attend_line_4id_years" alt="plot of chunk attend_line_4id_years" width="3200" />

The respondent  **id** = 35 reported attending no worship services in any of the years, while respodent **id** = 25 seemed to frequent it, indicating weekly attendance in 8 out of the 12 years. Individual **id** = 47 started as a fairly regular attendee of religious services in 2000 (5 = "about twice a month"), then gradually declined his involvement to nill in 2009 and on. Respondent **id** = 4, on the other hand started off with a rather passive involvement, reporting  attended church only "Once or twice"  in 2000,  maintained a low level of participation throughout the years, only to surge his attendance in 2011.  Latent curve models will describe intraindividual trajectories of change, while summarizinig the interindividual similarities and trends.    

### Changing the metric of time  
Previous research in religiousity indicated that age might be one of the primary factors explaining interindividual differences in church attendance. To examine the role of age, we change the metric of time from waves of measurement, as in the previous graph, to biological age. Consult [Metrics][metrics] report for details on measurement of age. 

```r
ds<- dsL %>% dplyr::filter(id %in% c(4,25,35,47),year %in% c(2000:2011)) %>% 
  dplyr::select(idF,byear,bmonth,year,ageyear,agemon) %.%
  dplyr::mutate(time=year-2000, age=agemon/12)
print(ds[ds$idF==25,])
```

```
   idF byear bmonth year ageyear agemon time   age
13  25  1983      3 2000      17    214    0 17.83
14  25  1983      3 2001      18    226    1 18.83
15  25  1983      3 2002      19    236    2 19.67
16  25  1983      3 2003      21    254    3 21.17
17  25  1983      3 2004      21    261    4 21.75
18  25  1983      3 2005      22    272    5 22.67
19  25  1983      3 2006      23    284    6 23.67
20  25  1983      3 2007      24    295    7 24.58
21  25  1983      3 2008      25    307    8 25.58
22  25  1983      3 2009      26    319    9 26.58
23  25  1983      3 2010      27    332   10 27.67
24  25  1983      3 2011      28    342   11 28.50
```

## Attendance over ages  
Plotting individual trajectories, with age as the metric of time.  

<img src="appendix/attend_line_4id_age3.png" title="plot of chunk attend_line_4id_age3" alt="plot of chunk attend_line_4id_age3" width="3200" />

Data Manipulation Guide
===

Demonstrating the language of data manipulation in <code>dplyr</code> packages using  **dsL** as an example   
[back to Appendix][appendix]



<!-- Run this three chunks to get to the starting point -->







## Five basic functions in data handling

For a more detailed discussion of basic verbs and operations consult the [R-Studio guide][1] or internal [vignette][2]

```r
vignette("introduction",package="dplyr")
```

The following is a brief demonstration of <code>dplyr</code> syntax using **dsL** dataset as an example. I attach prefix <code>dplyr::</code> to avoid possible conflicts with <code>plyr</code> package on which <code>ggplot2</code> package relies. I recommend such practice in all <code>dplyr</code>  expressions in sharable publications.  

One of the innovations in <code>dplyr</code> is the ability to chain phrases in the data manipulationsentence. The operator <code>%>%</code> (or <code>%.%</code>), accomplishes this, turning <code>x %>% f(y)</code> into <code>f(x, y) </code>.   


###<code>select()</code> 
selects variables into a smaller data set

```r
ds<-dsL
dim(ds)
```

```
[1] 134745     60
```

```r
ds<- dsL %>%
  dplyr::select(id,year, byear, attend, attendF)
head(ds,13)
```

```
   id year byear attend         attendF
1   1 1997  1981     NA            <NA>
2   1 1998  1981     NA            <NA>
3   1 1999  1981     NA            <NA>
4   1 2000  1981      1           Never
5   1 2001  1981      6 About once/week
6   1 2002  1981      2   Once or Twice
7   1 2003  1981      1           Never
8   1 2004  1981      1           Never
9   1 2005  1981      1           Never
10  1 2006  1981      1           Never
11  1 2007  1981      1           Never
12  1 2008  1981      1           Never
13  1 2009  1981      1           Never
```

```r
dim(ds)
```

```
[1] 134745      5
```

###<code>filter()</code> 
Removes observations that do not meet criteria. The following code selects observation based on the type of sample    


```
  sample         sampleF
1      1 Cross-Sectional
2      0      Oversample
```
and only between years 2000 and 2011, as only during those years the outcome of interest <code>attend</code> was recorded. 

```r
ds<- dsL %>%
  dplyr::filter(sample==1, year %in% c(2000:2011))%>%
  dplyr::select(id, year, attend, attendF)
head(ds,13)
```

```
   id year attend         attendF
1   1 2000      1           Never
2   1 2001      6 About once/week
3   1 2002      2   Once or Twice
4   1 2003      1           Never
5   1 2004      1           Never
6   1 2005      1           Never
7   1 2006      1           Never
8   1 2007      1           Never
9   1 2008      1           Never
10  1 2009      1           Never
11  1 2010      1           Never
12  1 2011      1           Never
13  2 2000      2   Once or Twice
```


###<code>arrange()</code> 
Sorts observations

```r
ds<- dsL %>%
  dplyr::filter(sample==1, year %in% c(2000:2011)) %>%
  dplyr::select(id, year, attend) %>%
  dplyr::arrange(year, desc(id))
head(ds,13)
```

```
     id year attend
1  9022 2000      1
2  9021 2000      2
3  9020 2000      2
4  9018 2000      4
5  9017 2000      6
6  9012 2000      5
7  9011 2000      6
8  9010 2000      1
9  9009 2000      2
10 9008 2000      6
11 8992 2000     NA
12 8991 2000      3
13 8987 2000      6
```

```r
ds<- dplyr::arrange(ds, id, year)
head(ds, 13)
```

```
   id year attend
1   1 2000      1
2   1 2001      6
3   1 2002      2
4   1 2003      1
5   1 2004      1
6   1 2005      1
7   1 2006      1
8   1 2007      1
9   1 2008      1
10  1 2009      1
11  1 2010      1
12  1 2011      1
13  2 2000      2
```


###<code>mutate()</code> 

Creates additional variables from the values of existing.

```r
ds<- dsL %>%
  dplyr::filter(sample==1, year %in% c(2000:2011)) %>%
  dplyr::select(id, byear, year, attend) %>%
  dplyr::mutate(age = year-byear, 
                timec = year-2000,
                linear= timec,
                quadratic= linear^2,
                cubic= linear^3)
head(ds,13)
```

```
   id byear year attend age timec linear quadratic cubic
1   1  1981 2000      1  19     0      0         0     0
2   1  1981 2001      6  20     1      1         1     1
3   1  1981 2002      2  21     2      2         4     8
4   1  1981 2003      1  22     3      3         9    27
5   1  1981 2004      1  23     4      4        16    64
6   1  1981 2005      1  24     5      5        25   125
7   1  1981 2006      1  25     6      6        36   216
8   1  1981 2007      1  26     7      7        49   343
9   1  1981 2008      1  27     8      8        64   512
10  1  1981 2009      1  28     9      9        81   729
11  1  1981 2010      1  29    10     10       100  1000
12  1  1981 2011      1  30    11     11       121  1331
13  2  1982 2000      2  18     0      0         0     0
```

###<code>summarize()</code> 
collapses data into a single value computed according to the aggregate functions.



```r
require(dplyr)
ds<- dsL %>%
  dplyr::filter(sample==1) %>%
  dplyr::summarize(N= n_distinct(id))
ds
```

```
     N
1 6747
```
Other functions one could use with <code>summarize()</code> include:

From <code>base</code>   

+ <code> min() </code>   
+ <code> max() </code>   
+ <code> mean() </code>   
+ <code> sum() </code>   
+ <code> sd() </code>   
+ <code> median() </code>   
+ <code> IQR()  </code>   

Native to <code>dplyr</code>    

+ <code> n() </code>  -  number of observations in the current group   
+ <code> n_distinct(x) </code>  -    count the number of unique values in x.    
+ <code> first(x) </code>  -  similar to <code>x[ 1 ]</code> + control over <code>NA</code>      
+ <code> last(x) </code>  -  similar to <code>x[length(x)] </code> + control over <code>NA</code>      
+ <code> nth(x, n)  </code>  -  similar to<code> x[n] </code>  + control over <code>NA</code>     

## Grouping and Combining 
The function <code>group_by()</code> is used to identify groups in split-apply-combine (SAC) procedure: it splits the initial data into smaller datasets (according to all possible interactions between the levels of supplied variables). It is these smaller datasets that <code>summarize()</code> will individually collapse into a single computed value according to its formula.  

```r
ds<- dsL %>%
  dplyr::filter(sample==1, year %in% c(2000:2011)) %>%
  dplyr::select(id, year, attendF) %>%
  dplyr::group_by(year,attendF) %>%
  dplyr::summarise(count = n()) %>%
  dplyr::mutate(total = sum(count),
              percent= count/total)
head(ds,10)
```

```
Source: local data frame [10 x 5]
Groups: year

   year              attendF count total  percent
1  2000                Never  1580  6747 0.234178
2  2000        Once or Twice  1304  6747 0.193271
3  2000 Less than once/month   775  6747 0.114866
4  2000     About once/month   362  6747 0.053653
5  2000    About twice/month   393  6747 0.058248
6  2000      About once/week  1101  6747 0.163184
7  2000   Several times/week   463  6747 0.068623
8  2000             Everyday    36  6747 0.005336
9  2000                   NA   733  6747 0.108641
10 2001                Never  1626  6747 0.240996
```

To verify :

```r
dplyr::summarize( filter(ds, year==2000), should.be.one=sum(percent))
```

```
Source: local data frame [1 x 2]

  year should.be.one
1 2000             1
```


## Base subsetting
Generally, we can compose any desired dataset by using matrix calls. The general formula is of the form:
**ds**[  _rowCond_  ,  _colCond_  ], where **ds** is a dataframe, and  _rowCond_ and _colCond_ are conditions for including rows and columns of the new dataset, respectively. One can also call a variable by attaching <code> $ </code> followed variable name to the name of the dataset:    <code>**ds**_$variableName_</code>. 

```r
ds<-dsL[dsL$year %in% c(2000:2011),c('id',"byear","year","agemon","attendF","ageyearF")]
print(ds[ds$id==1,]) 
```

```
   id byear year agemon         attendF ageyearF
4   1  1981 2000    231           Never       19
5   1  1981 2001    243 About once/week       20
6   1  1981 2002    256   Once or Twice       21
7   1  1981 2003    266           Never       22
8   1  1981 2004    279           Never       23
9   1  1981 2005    290           Never       24
10  1  1981 2006    302           Never       25
11  1  1981 2007    313           Never       26
12  1  1981 2008    325           Never       27
13  1  1981 2009    337           Never       28
14  1  1981 2010    350           Never       29
15  1  1981 2011    360           Never       29
```

The following is a list of operatiors that can be used in these calls. 
<ul>
<li>basic math operators: <code>+</code>, <code>-</code>, <code>*</code>, <code>/</code>, <code>%%</code>, <code>^</code></li>
<li>math functions: <code>abs</code>, <code>acos</code>, <code>acosh</code>, <code>asin</code>, <code>asinh</code>, <code>atan</code>, <code>atan2</code>,
<code>atanh</code>, <code>ceiling</code>, <code>cos</code>, <code>cosh</code>, <code>cot</code>, <code>coth</code>, <code>exp</code>, <code>floor</code>,
<code>log</code>, <code>log10</code>, <code>round</code>, <code>sign</code>, <code>sin</code>, <code>sinh</code>, <code>sqrt</code>, <code>tan</code>, <code>tanh</code></li>
<li>logical comparisons: <code>&lt;</code>, <code>&lt;=</code>, <code>!=</code>, <code>&gt;=</code>, <code>&gt;</code>, <code>==</code>, <code>%in%</code></li>
<li>boolean operations: <code>&amp;</code>, <code>&amp;&amp;</code>, <code>|</code>, <code>||</code>, <code>!</code>, <code>xor</code></li>
<li>basic aggregations: <code>mean</code>, <code>sum</code>, <code>min</code>, <code>max</code>, <code>sd</code>, <code>var</code></li>
</ul>

<code>dplyr</code> can translate all of these into SQL. For more of on <code>dplyr</code> and SQL compatibility consult another built-in [vignette][3]

```r
vignette("database",package="dplyr")
```

## Base Reference

The following unary and binary operators are defined for <code> base</code>. They are listed in precedence groups, from highest to lowest.


+ <code> :: :::   </code> -  access variables in a namespace  
+ <code> $ @      </code> - component / slot extraction   
+ <code> [ [[	    </code> - indexing  
+ <code> ^	      </code>  - exponentiation (right to left)   
+ <code> - +	 </code>  - unary minus and plus   
+ <code> :	 </code>  - sequence operator   
+ <code> %any%	 </code>  - special operators (including %% and %/%)   
+ <code> * /	 </code>  - multiply, divide   
+ <code> + -	 </code>  - (binary) add, subtract   
+ <code> < > <= >= == !=	 </code>  - ordering and comparison   
+ <code> !	 </code>  - negation   
+ <code> & &&	 </code>  - and   
+ <code> | ||	 </code>  - or   
+ <code> ~	 </code>  - as in formulae   
+ <code> -> ->>	 </code>  - rightwards assignment   
+ <code> <- <<-	 </code>  - assignment (right to left)   
+ <code> =	 </code>  - assignment (right to left)   
+ <code> ?	 </code>  - help (unary and binary)   

## Joining data with dplyr  

While <code>merge</code> works just fine , joining data frames with <code>dplyr</code> might offer some additional conveniences:   

+ rows are kept in existing order
+ much faster
+ tells you what keys you're merging by (if you don't supply)
+ also work with database tables.

dplyr implements the four most useful joins from SQL:  

+ <code>inner_join</code> - similar to <code>merge(..., all.x=F, all.y=F)</code>   
+ <code>ileft_join</code> - similar to <code>merge(..., all.x=T, all.y=F)</code>   
+ <code>isemi_join</code> - no equivalent in <code>merge()</code> unless y includes only join fields       
+ <code>ianti_join</code> - no equivalent in <code>merge()</code>, this is all x without a match in y  


lmer syntax and S4 architecture
===  

Locating model estimation results in S4 objects produced by of <code>lmer()</code> calls of *lme4* package.
[back to Appendix][appendix]


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






































