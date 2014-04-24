
Working with NLSY97 Extract
========================================================

## Trace the origins of datasets - prepare for modeling

This folder contains the original objects downloaded from [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp) [/Extracts](./Extracts). It is transformed into the dataset ***dsL.csv***  by manipulations of the code in [Desrive_dsL_from_Extract.R](./Desrive_dsL_from_Extract.R) Detailed description of this process are provided in [Desrive_dsL_from_Extract](./Desrive_dsL_from_Extract.Rmd)

## Variable-Occasion Slice (**VO**) 
<img link src="./figure_rmd/variables_layout.png" alt="Databox slice" style="width:700px;"/>  

<!--
pathMd <- base::file.path("./", c("README.md"))
pathHtml <- base::gsub(pattern=".md$", replacement=".html", x=pathMd)
markdown::markdownToHTML(file=pathMd, output=pathHtml)
-->

