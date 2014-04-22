# Clear memory from previous runs
base::rm(list=base::ls(all=TRUE))

#####################################
## @knitr LoadData

###################################
# Load the necessary packages.
base::require(base)
base::require(knitr)
base::require(markdown)
base::require(testit)
base::require(plyr)
base::require(reshape2)
base::require(stringr)


###################################
# Build the reports
pathsReports <- base::file.path("./", c("README.md"))
for( pathRmd in pathsReports ) {
  pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  pathHtml <- base::gsub(pattern=".Rmd$", replacement=".html", x=pathRmd)
  knitr::knit(input=pathRmd, output=pathMd)
  markdown::markdownToHTML(file=pathMd, output=pathHtml)
}


pathMd <- base::file.path("./", c("README.md"))
pathHtml <- base::gsub(pattern=".md$", replacement=".html", x=pathMd)
markdown::markdownToHTML(file=pathMd, output=pathHtml)



# Print this *.Rmd as *.md, then turn *.md into *.html
pathRmd<-base::file.path ("./Documentation/manipulation","ImportAndClean.Rmd")
pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
pathHtml <- base::gsub(pattern=".Rmd$", replacement=".html", x=pathRmd)
knitr::knit(input=pathRmd, output=pathMd)
markdown::markdownToHTML(file=pathMd, output=pathHtml)
