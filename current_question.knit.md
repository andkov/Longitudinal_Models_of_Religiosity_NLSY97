---
title: "Current Question"
output:
  html_document:
    keep_md: true
---
<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->




```r
dsL<-readRDS("./Data/Derived/dsL.rds")
attcol8<-c("Never"="#4575b4",
           "Once or Twice"="#74add1",
           "Less than once/month"="#abd9e9",
           "About once/month"="#e0f3f8",
           "About twice/month"="#fee090",
           "About once/week"="#fdae61",
           "Several times/week"="#f46d43",
           "Everyday"="#d73027")
```

Creating frequency distributions for each of the measurement wave we have:  



