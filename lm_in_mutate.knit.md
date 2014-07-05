---
title: "lm() in mutate()"
author: "Andriy Koval"
date: "Tuesday, June 24, 2014"
output:
  pdf_document:
    toc: yes
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 2
  word_document:
    fig_height: 3
    fig_width: 6.5
---


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->










Data for a single person

```r
ds<- dsL %>% dplyr::filter(id==1,year %in% c(2000:2011)) %>% dplyr::select(id,year,attend) %>%
  mutate(time=year-2000)
print(ds)
```












