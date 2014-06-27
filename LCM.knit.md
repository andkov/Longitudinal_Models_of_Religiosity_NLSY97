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












Latent Curve Modeling 
=================================================
This report analyzes a sequence of multilevel latent curve models of church attendance in NLSY97.

### Data

The preparation of this dataset is described in the report [Derive_dsL_from_Extract][derive]. For the scales and factor levels, refer to [Metrics][metrics] report, which relies on the script  [LabelingFactorLevels.R][labels] sourced at the end of [Derive_dsL_from_Extract][3].

A basic LCM in this sequence relies on four variables from **dsL** dataset: identifyer (**id**), birth year which is also used as cohort indicator (**byear**), wave of measurement (**year**), and the variable of interest - worship attendance (**attend**). 

```
   id byear year attend
1  47  1982 2000      5
2  47  1982 2001      2
3  47  1982 2002      4
4  47  1982 2003      2
5  47  1982 2004      3
6  47  1982 2005      2
7  47  1982 2006      2
8  47  1982 2007      3
9  47  1982 2008      2
10 47  1982 2009      1
11 47  1982 2010      1
12 47  1982 2011      1
```


The focal variable of interest is **attend**, an item measuring church attendance in the current year. Although it was recorded on an ordinal scale, the integers used to record the response (1 through 8) are treated as measurements on the continuous scale when fitted in these statistical models. For elaboraton on metrics of church attendance and time, see [Attendance][attend] report.


Service variables computed  and time effects are added, encoded as  weights of the Lambda matrix








