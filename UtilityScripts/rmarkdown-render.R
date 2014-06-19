
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

testit::assert("The knitr Rmd files should exist.", base::file.exists(pathsReports))
# Build the reports
for( pathRmd in buildthese ) {
  rmarkdown::render(input = pathRmd, 
                    output_format=c( "html_document","md_document"),
                    clean=TRUE)
}
