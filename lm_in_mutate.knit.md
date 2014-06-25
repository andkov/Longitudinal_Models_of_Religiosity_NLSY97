---
title: "lm() in mutate()"
author: "Andriy Koval"
date: "Tuesday, June 24, 2014"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 3
---


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->










Data for a single person

```r
ds<- dsL %>% dplyr::filter(id==47,year %in% c(2000:2011)) %>% dplyr::select(id,year,attend) 
print(ds)
```

```
   id year attend
1  47 2000      5
2  47 2001      2
3  47 2002      4
4  47 2003      2
5  47 2004      3
6  47 2005      2
7  47 2006      2
8  47 2007      3
9  47 2008      2
10 47 2009      1
11 47 2010      1
12 47 2011      1
```

<img src="./lm_in_mutate_files/figure-html/unnamed-chunk-3.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="2800" />


add a straight line to represent possible predition line, in this case a straight line

```r
linear<- predict(lm(attend ~ year, ds))
ds<- ds %>% dplyr::mutate(linear=linear)
print(ds)
```

```
   id year attend linear
1  47 2000      5 3.7564
2  47 2001      2 3.4977
3  47 2002      4 3.2389
4  47 2003      2 2.9802
5  47 2004      3 2.7214
6  47 2005      2 2.4627
7  47 2006      2 2.2040
8  47 2007      3 1.9452
9  47 2008      2 1.6865
10 47 2009      1 1.4277
11 47 2010      1 1.1690
12 47 2011      1 0.9103
```

```r
p<-p+ geom_line(aes(y=linear),color="red", size=.5)
p
```

<img src="./lm_in_mutate_files/figure-html/unnamed-chunk-4.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="2800" />
Or adding the curvarture the  quadratic terms




