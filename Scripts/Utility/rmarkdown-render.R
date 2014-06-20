
########## Production of reports from .Rmd files ###


pathDerive <- base::file.path("./Data/Derive_dsL_from_Extract.Rmd")
pathDatabox <- base::file.path("./Models/Descriptives/Databox.Rmd")
pathMetrics<- base::file.path("./Models/Descriptives/Metrics.Rmd")
pathLCM <- base::file.path("./Models/LCM/LCM.Rmd")

########## Define groups of reports 
descriptives<-c(pathDatabox,pathMetrics)
allreps<- c(pathDerive, pathDatabox,pathMetrics, pathLCM )
# Select  report or group of reports to build:
buildthese <- c(pathMetrics)
#####################

testit::assert("The knitr Rmd files should exist.", base::file.exists(buildthese))
# Build the reports
for( pathRmd in buildthese ) {
#   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  rmarkdown::render(input = pathRmd, 
                    output_format=c(
#                       "md_document"
#                       ,"html_document"
                      "pdf_document"
                                    ),
#                     output_file=pathMd,
                    clean=TRUE)
}

# library(extrafont)
# font_import()