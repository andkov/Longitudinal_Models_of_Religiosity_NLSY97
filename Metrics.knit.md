---
title: "Metrics"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 2
    fig_width: 8
    theme: united
    toc: yes
  md_document:
    toc: yes
    toc_depth: 3
  pdf_document:
    fig_caption: no
    fig_crop: no
    fig_width: 8
    latex_engine: xelatex
    number_sections: yes
    toc: yes
    toc_depth: 3
  word_document:
    fig_width: 6.5
mainfont: Calibri
---



<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->










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

## Religiosity  

NLSY97 asked to report church attendance (**attend**) for the past 12 months preceding the interview date. The response card offered a choice of 7 categories ordered by magnitude.  

<img src="figure_rmd/Metrics/attend_2000.png" title="Figure caption test" alt="Figure caption test" width="3200" />

The records of church attendance begin in 2000, when the respondents were between 13 and 17 years of age. Although prior to 2000, there was another measure of religiosity   






