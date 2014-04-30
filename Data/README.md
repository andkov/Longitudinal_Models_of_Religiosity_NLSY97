
Working with NLSY97 Extract
========================================================

## Trace the origins of datasets - prepare for modeling

The folder ** [/Extracts](./Extracts)** contains the original objects downloaded from [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp). Extract is transformed into the dataset ***dsL.csv***  by manipulations of the code in [Desrive_dsL_from_Extract.R](./Derive_dsL_from_Extract.R) and stored in the folder **[/Derived](./Derived)**. Detailed description of this process is provided in the report **[Derive_dsL_from_Extract.md](./Derive_dsL_from_Extract.md)**.



## Variable-Occasion Slice : Religiosity in NLSY97 
<img link src="./figure_rmd/variables_layout.png" alt="Databox slice" style="width:700px;"/>  


<!--
pathMd <- base::file.path("./", c("README.md"))
pathHtml <- base::gsub(pattern=".md$", replacement=".html", x=pathMd)
markdown::markdownToHTML(file=pathMd, output=pathHtml)
-->
