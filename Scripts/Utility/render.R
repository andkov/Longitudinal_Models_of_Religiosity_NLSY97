rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
pathReport<-   base::file.path("./Models/Appendix.Rmd")
library(dplyr)

  rmarkdown::render(input = pathReport, 
                    output_format=c(
                      "pdf_document"
#                       ,"word_document"
#                       "md_document"
#                     ,"html_document"
                      
                    ),clean=TRUE)

