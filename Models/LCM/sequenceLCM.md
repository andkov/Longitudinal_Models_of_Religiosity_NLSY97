---
title: "Single model"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 2
    fig_width: 8
    toc: yes
  md_document:
    toc: yes
    toc_depth: 3
  pdf_document:
    fig_crop: no
    fig_width: 8
    highlight: haddock
    latex_engine: xelatex
    number_sections: yes
    toc: yes
    toc_depth: 3
  word_document:
    fig_width: 6.5
mainfont: Calibri
---

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->











```
 [1] "m0F"  "m0R1" "m1F"  "m1R1" "m1R2" "m2F"  "m2R1" "m2R2" "m2R3" "m3F"  "m3R1" "m3R2" "m3R3" "m3R4" "m4F"  "m4R1"
[17] "m4R2" "m4R3" "m4R4" "m5F"  "m5R1" "m5R2" "m5R3" "m5R4" "m6F"  "m6R1" "m6R2" "m6R3" "m6R4" "m7F"  "m7R1" "m7R2"
[33] "m7R3" "m7R4" "mFa"  "mFb"  "mFc"  "mFd"  "mFe"  "mR1a" "mR1b" "mR1c" "mR1d" "mR1e"
```

# Model specification

```r
############################
```


```r
BuildMosaic <- function( modelName ) {
  testit::assert(fact="The FERE object should be found in the appropriate list", modelName %in% names(lstModelOutcomes))
  dsFERE <- lstModelOutcomes[modelName][[1]]
  gTile <- BuildFERE(modelName=modelName, dsWide=dsFERE)
  #   gLin <- Line(modelName)
  
  grid.newpage()
    
  layout <- grid.layout(nrow=3, ncol=3,
                        widths=unit(c(1, 1, 2),c("inches", "null", "null")),
                        heights=unit(c(3, 1, 1), c("lines", "null", "null"))
  )
  pushViewport(viewport(layout=layout))
  print(gTile, vp=vpLayout(2, 2)) #Y ~ X1 
  print(gBar, vp=vpLayout(2, 3)) #Y ~ x2
  

popViewport(0)
}

############################
```

# m5F 

```r
# dsWide <- lstModelOutcomes["m5F"][[1]]
BuildMosaic(modelName="m5F")
```

![plot of chunk m5F](sequence/m5F.png) 

```r
############################
```

# m6F 

```r
BuildMosaic(modelName="m6F")
```

![plot of chunk m6F](sequence/m6F.png) 

```r
############################
```

# m7F 

```r
.
```

```
Error: object '.' not found
```

```r
.
```

```
Error: object '.' not found
```

```r
.
```

```
Error: object '.' not found
```

```r
############################
```
Add more here.

# m5R1 

```r
############################
```

# m6R1 

```r
############################
```

# m7R1 

```r
# source(./..../)
# # grid dimentions
# > unitlay <-
#   grid.layout(3, 3,
#               widths=unit(c(1, 1, 2),
#                           c("inches", "null", "null")),
#               heights=unit(c(3, 1, 1),
#                            c("lines", "null", "null")))
```
Add more here.

# m5R2 


# m6R2 


# m7R2 

