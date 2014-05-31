
Working with NLSY97 Extract
========================================================

## Trace the origins of datasets - prepare for modeling

The folder [Extracts](./Extracts) contains the original objects downloaded from [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp). The downloaded extract file is transformed into the dataset ***dsL***  by manipulations of the code in [Desrive_dsL_from_Extract.R](./Derive_dsL_from_Extract.R) sourced by the report [Desrive_dsL_from_Extract](./Derive_dsL_from_Extract.md), which narrates the reproducibility instructions. As the result of running this report, a clean, unlabeled dataset is stored in the folder [/Derived](./Derived). 



## Databox  Variable-Occasion Slice : Religiosity in NLSY97 
<img link src="./figure_rmd/variables_layout.png" alt="Databox slice" style="width:700px;"/>  

To review original questionnaire cards of NLSY97 as well as descriptive statistics for the selected variables see the [Interactive version](http://statcanvas.net/thesis/databox/index.html)


Folder [ItemMapping](./ItemMapping) contains files for assigning value labels to the variables in ***dsL***.

Folder [figure_rmd](./figure_rmd) hosts the images used by knitr reports nested in this folder.

<!--
pathMd <- base::file.path("./", c("README.md"))
pathHtml <- base::gsub(pattern=".md$", replacement=".html", x=pathMd)
markdown::markdownToHTML(file=pathMd, output=pathHtml)
-->

