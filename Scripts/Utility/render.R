rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
pathlmmutate<- base::file.path("./Vignettes/Questions/lm_in_mutate/lm_in_mutate.Rmd")
library(dplyr)

  rmarkdown::render(input = pathlmmutate, 
                    output_format=c(
                                            "html_document"
                      #                       ,"md_document"
#                       "pdf_document"
#                       "word_document"
                    ),
                    #                     output_file=pathMd,
                    clean=TRUE)

