Descriptive statistics
=================================================
This report tracks down the creation of graphs for basic descriptive statistics in the NLSY97 religiosity data as defined by the extract NLSY97_Religiosity_20042014.  


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->




<!-- Set the report-wide options, and point to the external code file. -->

```r
require(knitr)
getwd()
```

```
## [1] "C:/Users/inspirion/Documents/GitHub/Longitudinal_Models_of_Religiosity_NLSY97"
```

```r
opts_chunk$set(
  results='show', 
  message = TRUE,
  comment = NA, 
  tidy = FALSE,
  fig.height = 4, 
  fig.width = 5.5, 
  out.width = "550px",
  fig.path = 'figure_rmd/',     
  dev = "png",
#   fig.path = 'figure_pdf/',     
#   dev = "pdf",
  dpi = 400
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Models/Descriptives/Descriptives.R") # the file to which knitr calls for the chunks
```







First we load the data, specifically the dataset **dsL**, obtained by the report [Derive_dsL_from_Extract](./Data/Derive_dsL_from_Extract.md). 

## Figure 1 : View of initial **dsL** dataset
<img link src="./figure_rmd/dsL_view.png" alt="View of dsL" style="width:900px;"/>  

## Figure 2 : **dsL** reexpressed as a Cattell's datacube slice
<img link src="./figure_rmd/variables_layout.png" alt="Databox slice" style="width:800px;"/>


```
'data.frame':	134760 obs. of  30 variables:
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
 $ agemon     : int  190 206 219 231 243 256 266 279 290 302 ...
 $ ageyear    : int  15 17 18 19 20 21 22 23 24 25 ...
 $ famrel     : int  NA NA NA NA NA NA NA NA NA NA ...
 $ attend     : int  NA NA NA 1 6 2 1 1 1 1 ...
 $ values     : int  NA NA NA NA NA 1 NA NA 0 NA ...
 $ todo       : int  NA NA NA NA NA 1 NA NA 1 NA ...
 $ obeyed     : int  NA NA NA NA NA 1 NA NA 0 NA ...
 $ pray       : int  NA NA NA NA NA 0 NA NA 0 NA ...
 $ decisions  : int  NA NA NA NA NA 1 NA NA 1 NA ...
 $ relpref    : int  NA NA NA NA NA NA NA NA 21 NA ...
 $ bornagain  : int  NA NA NA NA NA NA NA NA NA NA ...
 $ faith      : int  NA NA NA NA NA NA NA NA NA NA ...
 $ calm       : int  NA NA NA 3 NA 4 NA 4 NA 4 ...
 $ blue       : int  NA NA NA 3 NA 2 NA 1 NA 1 ...
 $ happy      : int  NA NA NA 3 NA 3 NA 4 NA 4 ...
 $ depressed  : int  NA NA NA 3 NA 2 NA 1 NA 1 ...
 $ nervous    : int  NA NA NA 3 NA 1 NA 1 NA 1 ...
 $ tv         : int  NA NA NA NA NA 2 NA NA NA NA ...
 $ computer   : int  NA NA NA NA NA 5 NA NA NA NA ...
 $ internet   : int  NA NA NA NA NA NA 1 0 1 1 ...
```



```
'data.frame':	134760 obs. of  30 variables:
 $ sample     : Factor w/ 2 levels "Cross-Sectional",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ id         : int  1 1 1 1 1 1 1 1 1 1 ...
 $ sex        : Factor w/ 3 levels "Male","Female",..: 2 2 2 2 2 2 2 2 2 2 ...
 $ race       : Factor w/ 4 levels "Black","Hispanic",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ bmonth     : Factor w/ 12 levels "Jan","Feb","Mar",..: 9 9 9 9 9 9 9 9 9 9 ...
 $ byear      : int  1981 1981 1981 1981 1981 1981 1981 1981 1981 1981 ...
 $ attendPR   : Factor w/ 8 levels "Never","Once or Twice",..: 7 7 7 7 7 7 7 7 7 7 ...
 $ relprefPR  : Factor w/ 33 levels "Catholic","Baptist",..: 21 21 21 21 21 21 21 21 21 21 ...
 $ relraisedPR: Factor w/ 33 levels "Catholic","Baptist",..: 21 21 21 21 21 21 21 21 21 21 ...
 $ year       : int  1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 ...
 $ agemon     : int  190 206 219 231 243 256 266 279 290 302 ...
 $ ageyear    : int  15 17 18 19 20 21 22 23 24 25 ...
 $ famrel     : int  NA NA NA NA NA NA NA NA NA NA ...
 $ attend     : Factor w/ 8 levels "Never","Once or Twice",..: NA NA NA 1 6 2 1 1 1 1 ...
 $ values     : int  NA NA NA NA NA 1 NA NA 0 NA ...
 $ todo       : int  NA NA NA NA NA 1 NA NA 1 NA ...
 $ obeyed     : int  NA NA NA NA NA 1 NA NA 0 NA ...
 $ pray       : int  NA NA NA NA NA 0 NA NA 0 NA ...
 $ decisions  : int  NA NA NA NA NA 1 NA NA 1 NA ...
 $ relpref    : Factor w/ 33 levels "Catholic","Baptist",..: NA NA NA NA NA NA NA NA 21 NA ...
 $ bornagain  : int  NA NA NA NA NA NA NA NA NA NA ...
 $ faith      : int  NA NA NA NA NA NA NA NA NA NA ...
 $ calm       : int  NA NA NA 3 NA 4 NA 4 NA 4 ...
 $ blue       : int  NA NA NA 3 NA 2 NA 1 NA 1 ...
 $ happy      : int  NA NA NA 3 NA 3 NA 4 NA 4 ...
 $ depressed  : int  NA NA NA 3 NA 2 NA 1 NA 1 ...
 $ nervous    : int  NA NA NA 3 NA 1 NA 1 NA 1 ...
 $ tv         : int  NA NA NA NA NA 2 NA NA NA NA ...
 $ computer   : int  NA NA NA NA NA 5 NA NA NA NA ...
 $ internet   : int  NA NA NA NA NA NA 1 0 1 1 ...
```


<img src="figure_rmd/sample_1997.png" title="plot of chunk sample_1997" alt="plot of chunk sample_1997" width="550px" />


<img src="figure_rmd/sex_1997.png" title="plot of chunk sex_1997" alt="plot of chunk sex_1997" width="550px" />




