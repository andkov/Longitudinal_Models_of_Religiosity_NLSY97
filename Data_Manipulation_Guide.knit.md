---
title: "Data Manipulation"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig_caption: yes
    fig_height: 4.5
    fig_width: 6.5
    highlight: textmate
    keep_md: yes
    theme: united
    toc: yes
  md_document:
    toc: yes
    variant: markdown_github
  pdf_document:
    toc: yes
---

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->




Data Manipulation
==============
Report examplifying the use of <code>dplyr</code> in data handling on the example of <code>dsL</code>.

<!-- Run this three chunks to get to the starting point -->






## Five basic functions in data handling

For a more detailed discussion of basic verbs and operations consult the [R-Studio guide][1] or internal vignette

```r
# vignette("introduction",package="dplyr")
```

The following is a brief demonstration of <code>dplyr</code> syntax using <code>dsL</code> example  

###<code>select()</code> 
selects variables into a smaller data set

```r
require(dplyr)
ds<-dsL
dim(ds)
```

```
[1] 134760     60
```

```r
ds<- select(ds,id,year, byear, attend, attendF)
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
[1] 134760      5
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
require(dplyr)
ds<- filter(dsL,sample==1, year %in% c(2000:2011))
ds<- select(ds,id, year, attend, attendF)
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












