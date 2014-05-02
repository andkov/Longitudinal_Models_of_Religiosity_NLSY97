
############# Derive dsL from Extract ###################
# Run this code manualy, connection doesn't work yet
pathDerive <- base::file.path("./Data/Derive_dsL_from_Extract.Rmd")
pathDescriptives <- base::file.path("./Models/Descriptives/Descriptives.Rmd")
pathLCM <- base::file.path("./Models/LCM/LCM.Rmd")

allreps<- c(pathDerive, pathDescriptives,pathLCM )

pathsReports <-c(pathDerive)
testit::assert("The knitr Rmd files should exist.", base::file.exists(pathsReports))

# Build the reports
for( pathRmd in pathsReports ) {
  pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  pathHtml <- base::gsub(pattern=".Rmd$", replacement=".html", x=pathRmd)
#   knitr::knit(input=pathRmd, output=pathMd)
  markdown::markdownToHTML(file=pathMd, output=pathHtml)
}


