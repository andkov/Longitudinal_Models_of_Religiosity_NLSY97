
########## Production of reports from .Rmd files ###
require(dplyr)


# ./Models/Descriptives
pathRaceYearsBars<- base::file.path("./Models/Descriptives/temporal_animations/attend_race_years.Rmd")
pathRaceYearsLines<- base::file.path("./Models/Descriptives/temporal_animations/attend_race_years_Lines.Rmd")
pathRaceAges<- base::file.path("./Models/Descriptives/temporal_animations/attend_race_ages.Rmd")
pathRaceAgesLines<- base::file.path("./Models/Descriptives/temporal_animations/attend_race_ages_Lines.Rmd")


#  Define groups of reports 
all<- c(pathRaceYearsBars,pathRaceYearsLines,pathRaceAges,pathRaceAgesLines )


# Place report paths HERE ###########
buildthese <- (pathRaceAges)##########
####################################

testit::assert("The knitr Rmd files should exist.", base::file.exists(buildthese))
# Build the reports
for( pathRmd in buildthese ) {
#   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  rmarkdown::render(input = pathRmd, 
                    output_format=c(
#                        "pdf_document"
#                       ,"word_document"
#                       "md_document"
                      "html_document"

                                    ),
#                     output_file=pathMd,
                    clean=TRUE)
}
 
 
