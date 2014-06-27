---
title: "Descriptives"
author: "Andriy Koval"
date: "Tuesday, June 24, 2014"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 2
    fig_width: 8
    toc: yes
  pdf_document:
    fig_width: 8
    latex_engine: xelatex
    toc: yes
  word_document:
    fig_width: 6.5
mainfont: Calibri
---


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->











There are total of 

```r
cat(length(unique(dsL$id)))
```

```
8984
```
respondents. 


```r
ds<- dsL %>% group_by(sampleF) %>% summarize (count=n_distinct(id))
ds
```

```
Source: local data frame [2 x 2]

          sampleF count
1 Cross-Sectional  6748
2      Oversample  2236
```

Basic demographics is given in Figure 4.# 

```
ymax not defined: adjusting position using y instead
ymax not defined: adjusting position using y instead
```

<img src="figure_rmd/Descriptives/01_basic_demo.png" title="plot of chunk 01_basic_demo" alt="plot of chunk 01_basic_demo" width="3200" />

Respondents’ age was of particular interest and was entered as a predictor of church attendance.  NSLY97 contains static and dynamic indicators of age age. Variables  byear and bmonth were recorded once in 1997 (static) and contain respondents’ birth year and birth month respectively. Two age variables were recorded continuously at each interview (dynamic): age at the time of the interview in months agemon and in years ageyear.   Figure 4.2 shows how births in the NLSY97 sample (static age) was distributed over calendric months from 1980 to 1984:





