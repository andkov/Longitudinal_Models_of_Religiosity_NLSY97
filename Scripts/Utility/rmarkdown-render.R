
########## Production of reports from .Rmd files ###
require(dplyr)

pathDerive <- base::file.path("./Data/Derive_dsL_from_Extract.Rmd")

pathMetrics<- base::file.path("./Models/Descriptives/Metrics.Rmd")
pathDatabox <- base::file.path("./Models/Descriptives/Databox.Rmd")
# Vignettes
pathManipulate <- base::file.path("./Vignettes/dplyr/Data_Manipulation_Guide.Rmd")
pathFigSize <- base::file.path("./Vignettes/fig_size/fig_size.Rmd")
pathChooseSize <- base::file.path("./Vignettes/fig_size/choose_fig_size.Rmd")
# Questions
pathRemoveNA<- base::file.path("./Scripts/Questions/Removing_NA/Removing_NA_from_distributions_ggplot.Rmd")
pathRawVsSum<- base::file.path("./Scripts/Questions/Raw_vs_Summarized/Raw_vs_Summarized.Rmd")
# Models
pathLCM <- base::file.path("./Models/LCM/LCM.Rmd")

#  Define groups of reports 
descriptives<-c(pathDatabox,pathMetrics)
allreps<- c()


# Place report paths HERE ###########
buildthese <- c(pathChooseSize)##########
####################################

testit::assert("The knitr Rmd files should exist.", base::file.exists(buildthese))
# Build the reports
for( pathRmd in buildthese ) {
#   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  rmarkdown::render(input = pathRmd, 
                    output_format=c(
#                       "html_document"
#                       ,"md_document"
                      "pdf_document"
#                       ,"word_document"
                                    ),
#                     output_file=pathMd,
                    clean=TRUE)
}
 
