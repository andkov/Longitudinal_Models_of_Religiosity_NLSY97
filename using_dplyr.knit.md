---
title: "Metrics"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig_caption: yes
    fig_height: 4.5
    fig_width: 6.5
    highlight: textmate
    keep_md: yes
    toc: yes
  md_document:
    toc: yes
    variant: markdown_github
  pdf_document:
    toc: yes
---

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->




On using dplyr
==============
Vignettes examplifying using dplyr to handle the data selected for the study

<!-- Run this three chunks to get to the starting point -->





### Basic verbs of dplyr
Dplyr relies on five basic verb:
+ filter ()
+ arrange ()
+ select ()
+ mutate()
+ summarize()


Consult the [official vignette][1] for additional info, which you can call from R as well

```r
vignette("introduction",package="dplyr")
```








