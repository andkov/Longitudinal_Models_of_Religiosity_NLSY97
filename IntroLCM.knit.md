---
title: "Introduction to LCM"
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
    highlight: tango
    latex_engine: xelatex
    number_sections: yes
    toc: yes
    toc_depth: 3
  word_document:
    fig_width: 6.5
mainfont: Calibri
fontsize: 14pt
---


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->










We can retrieve data for a single person using <code>id</code>

```r
ds<- dsL %>% 
  dplyr::filter(id==7499,year %in% c(2000:2011)) %>% 
  dplyr::mutate(time=year-2000) %>%
  dplyr::select(id,year,attendF,attend, time) 
print(ds)
```

```
     id year              attendF attend time
1  7499 2000   Several times/week      7    0
2  7499 2001      About once/week      6    1
3  7499 2002        Once or Twice      2    2
4  7499 2003        Once or Twice      2    3
5  7499 2004                Never      1    4
6  7499 2005                Never      1    5
7  7499 2006                Never      1    6
8  7499 2007                Never      1    7
9  7499 2008                Never      1    8
10 7499 2009                Never      1    9
11 7499 2010        Once or Twice      2   10
12 7499 2011 Less than once/month      3   11
```


<img src="figure_rmd/IntroLCM/unnamed-chunk-3.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="3200" />

Alternatively, we can enter data manually, if we want to work with artificial trajectories

```r
    id=rep(1,12) 
    year=seq(2000,2011,1)
    attend= c(6,7,7,6,4,3,2,1,1,1,2,2)
    attendF=ordered(attend,
            levels= unique(dsL$attend,is.na=T),
            labels=levels(dsL$attendF))
    time= year - 2000
ds<-data.frame(id,year,attendF, attend, time)
print(ds)
```





The simplest possible model that can be fit to these data is the intercept-only model:  

\[{y_{ti}} = {\beta _0} + {\varepsilon _{ti}}\]  

which implies that the data can be represented with a straight, zero-slope line:







