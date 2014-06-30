rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
pathReport<-   base::file.path("./Data/Derive_dsL_from_Extract.Rmd")
library(dplyr)

  rmarkdown::render(input = pathReport, 
                    output_format=c(
#                       "word_document"
                      "md_document"
                     ,"html_document"
#                       "pdf_document"
                      
                    ),clean=TRUE)

