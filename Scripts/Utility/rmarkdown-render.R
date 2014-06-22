
########## Production of reports from .Rmd files ###
require(dplyr)

pathDerive <- base::file.path("./Data/Derive_dsL_from_Extract.Rmd")
pathDatabox <- base::file.path("./Models/Descriptives/Databox.Rmd")
pathMetrics<- base::file.path("./Models/Descriptives/Metrics.Rmd")
pathLCM <- base::file.path("./Models/LCM/LCM.Rmd")
pathDataManipulation <- base::file.path("./Vignettes/Data_Manipulation_dplyr/Data_Manipulation_Guide.Rmd")
pathRemoveNA<- base::file.path("./Scripts/Questions/Removing_NA/Removing_NA_from_distributions_ggplot.Rmd")

########## Define groups of reports 
descriptives<-c(pathDatabox,pathMetrics)
allreps<- c(pathDerive, pathDatabox, pathMetrics, pathLCM, pathDataManipulation,  )
# Place report paths HERE:
buildthese <- c(pathDataManipulation)


testit::assert("The knitr Rmd files should exist.", base::file.exists(buildthese))
# Build the reports
for( pathRmd in buildthese ) {
#   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  rmarkdown::render(input = pathRmd, 
                    output_format=c(
                      "md_document"
                      ,"html_document"
#                       ,"word_document"
#                       ,"pdf_document"
                                    ),
#                     output_file=pathMd,
                    clean=TRUE)
}

# library(extrafont)
# font_import()

pathSource<- file.path("./Vignettes/dplyr/Data_Manipulation_Guide")
pathHtml<- paste0(pathSource,'.html')
pathPdf<- paste0(pathSource,".pdf")

system("pandoc -s pathHtml -o pathPdf")
