
############# Derive dsL from Extract ###################
# Run this code manualy, connection doesn't work yet
pathDerive <- base::file.path("./Data/Derive_dsL_from_Extract.Rmd")
pathDescriptivesList <- base::file.path("./Models/Descriptives/DescriptivesList.Rmd")

pathDescriptives <- base::file.path("./Models/Descriptives/Descriptives.Rmd")
pathLCM <- base::file.path("./Models/LCM/LCM.Rmd")
pathAAA <- base::file.path("./Models/Descriptives/AttendAndAge.Rmd")
pathDataGrooming <- base::file.path("./Models/Descriptives/DataGrooming.Rmd")

allreps<- c(pathDescriptives, pathLCM,pathAAA, pathDataGrooming )

pathsReports <-c(allreps )
testit::assert("The knitr Rmd files should exist.", base::file.exists(pathsReports))

# Build the reports
for( pathRmd in allreps ) {
  pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  pathHtml <- base::gsub(pattern=".Rmd$", replacement=".html", x=pathRmd)
#   knitr::knit(input=pathRmd, output=pathMd)
  markdown::markdownToHTML(file=pathMd, output=pathHtml)
}


