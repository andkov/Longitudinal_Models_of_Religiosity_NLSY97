rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
pathReport<-  base::file.path("./Models/Descriptives/Attendance.Rmd")
library(dplyr)

  rmarkdown::render(input = pathReport, 
                    output_format=c(
#                        ,"word_document"
                       "html_document"
                       ,"md_document"
#                        "pdf_document"
                      
                    ),clean=TRUE)

