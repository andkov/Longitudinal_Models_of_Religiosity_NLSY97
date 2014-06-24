
########## Production of reports from .Rmd files ###
require(dplyr)

pathDerive <- base::file.path("./Data/Derive_dsL_from_Extract.Rmd")

pathMetrics<- base::file.path("./Models/Descriptives/Metrics.Rmd")
pathDatabox <- base::file.path("./Models/Descriptives/Databox.Rmd")

pathManipulate <- base::file.path("./Vignettes/dplyr/Data_Manipulation_Guide.Rmd")
pathFigSize <- base::file.path("./Vignettes/fig_size/fig_size.Rmd")

pathRemoveNA<- base::file.path("./Scripts/Questions/Removing_NA/Removing_NA_from_distributions_ggplot.Rmd")
pathRawVsSum<- base::file.path("./Scripts/Questions/Raw_vs_Summarized/Raw_vs_Summarized.Rmd")

pathLCM <- base::file.path("./Models/LCM/LCM.Rmd")

#  Define groups of reports 
descriptives<-c(pathDatabox,pathMetrics)
allreps<- c(pathDerive, pathManipulate,pathMetrics, pathLCM, pathRemoveNA )


# Place report paths HERE ###########
buildthese <- c(pathMetrics,pathManipulate)##########
####################################

testit::assert("The knitr Rmd files should exist.", base::file.exists(buildthese))
# Build the reports
for( pathRmd in buildthese ) {
#   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  rmarkdown::render(input = pathRmd, 
                    output_format=c(
                      "html_document"
                      ,"md_document"
#                       ,"pdf_document"
#                       ,"word_document"
                                    ),
#                     output_file=pathMd,
                    clean=TRUE)
}
 
