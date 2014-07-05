
########## Production of reports from .Rmd files ###
require(dplyr)

pathDerive <- base::file.path("./Data/Derive_dsL_from_Extract.Rmd")
# ./Models/Descriptives
pathMetrics<- base::file.path("./Models/Descriptives/Metrics.Rmd")
pathDescriptives<- base::file.path("./Models/Descriptives/Descriptives.Rmd")
pathAttendance<- base::file.path("./Models/Descriptives/Attendance.Rmd")
pathDatabox <- base::file.path("./Models/Descriptives/Databox.Rmd")
# ./Models/LCM
pathLCM <- base::file.path("./Models/LCM/LCM.Rmd")

# ./Vignettes
pathManipulate <- base::file.path("./Vignettes/dplyr/Data_Manipulation_Guide.Rmd")
pathFigSize <- base::file.path("./Vignettes/fig_size/fig_size.Rmd")
pathChooseSize <- base::file.path("./Vignettes/fig_size/choose_fig_size.Rmd")
pathChooseSize <- base::file.path("./Vignettes/Questions/create_TOC_in_md/create_TOC_in_md.Rmd")
#./Vignettes/Questions
pathRemoveNA<- base::file.path("./Vignettes/Questions/Removing_NA/Removing_NA_from_distributions_ggplot.Rmd")
pathRawVsSum<- base::file.path("./Vignettes/Questions/Raw_vs_Summarized/Raw_vs_Summarized.Rmd")
pathlmmutate<- base::file.path("./Vignettes/Questions/lm_in_mutate/lm_in_mutate.Rmd")


#  Define groups of reports 
Vignettes<- c(pathManipulate)
Descriptives<- c( pathMetrics,pathDescriptives, pathAttendance)


# Place report paths HERE ###########
buildthese <- (pathDerive) ##########
####################################

testit::assert("The knitr Rmd files should exist.", base::file.exists(buildthese))
# Build the reports
for( pathRmd in buildthese ) {
#   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  rmarkdown::render(input = pathRmd, 
                    output_format=c(
                       "pdf_document"
                      ,"word_document"
                      ,"md_document"
                      ,"html_document"

                                    ),
#                     output_file=pathMd,
                    clean=TRUE)
}
 
 
