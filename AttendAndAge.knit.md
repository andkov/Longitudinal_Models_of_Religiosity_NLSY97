
<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->



<!-- Set the report-wide options, and point to the external code file. -->










Church attendance
=================================================

The focal variable of interest is **attend**, an item measuring church attendance in the current year. Although it was recorded on ordinal scale, 
<img src="figure_rmd/unnamed-chunk-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="565px" />
its resolution allows us to treat it as continuous for the purpose of fitting statistical models. 

```r
ds<-(subset(dsL, year==2000)) # only for year 2000
summary(as.numeric(ds$attend)) # summarize as continuous variable
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    1.0     1.0     3.0     3.4     6.0     8.0     965 
```
The basic dataset contains personal identifyer (**id**), birth year which is also used as cohort indicator (**byear**), wave of measurement (**year**) and the focal variable of interest - worship attendance (**attend**). 

```
    id byear year attend              attendF
691 47  1982 1997     NA                 <NA>
692 47  1982 1998     NA                 <NA>
693 47  1982 1999     NA                 <NA>
694 47  1982 2000      5    About twice/month
695 47  1982 2001      2        Once or Twice
696 47  1982 2002      4     About once/month
697 47  1982 2003      2        Once or Twice
698 47  1982 2004      3 Less than once/month
699 47  1982 2005      2        Once or Twice
700 47  1982 2006      2        Once or Twice
701 47  1982 2007      3 Less than once/month
702 47  1982 2008      2        Once or Twice
703 47  1982 2009      1                Never
704 47  1982 2010      1                Never
705 47  1982 2011      1                Never
```

The view lists all the data for a single subjust (id=1). There are 

```
8984
```
subjects in total.

We have data on attendance for 12 years, from 2000 to 2011. Figure 2 gives a cross-sectional frequency distribution of the data across the years. 
#### Figure 2. Relative frequency of responses for each observed wave








