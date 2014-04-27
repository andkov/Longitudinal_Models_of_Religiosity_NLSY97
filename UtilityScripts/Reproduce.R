
###################################
### Reproducible Research
###################################
# When executed by R, this file will manipulate the original data sources (ie, ZZZZ)
# to produce a groomed dataset (dsL) suitable for analysis and graphing. 

###################################
# Clear memory from previous runs
base::rm(list=base::ls(all=TRUE))

###################################
# Verify the working directory has been set correctly.  Much of the code assumes the working directory is the repository's root directory.
# In the following line, rename `RAnalysisSkeleton` to your repository.
if( base::basename(base::getwd()) != "Longitudinal_Models_of_Religiosity_NLSY97" ) {
  base::stop("The working directory should be set to the root of the package/repository.  ",
       "It's currently set to `", base::getwd(), "`.")
}
###################################
# Install the necessary packages.
pathInstallPackages <- "./UtilityScripts/InstallPackages.R"
if( !file.exists(pathInstallPackages)) {
  base::stop("The file `", pathInstallPackages, "` was not found.  Make sure the working directory is set to the root of the repository.")
}
base::source(pathInstallPackages, local=new.env()) 

base::rm(pathInstallPackages)
###################################
# Load the necessary packages.
base::require(base)
base::require(knitr)
base::require(markdown)
base::require(testit)

# ###################################
# # Declare the paths of the necessary files.
# 
# # The raw/input data files:
# dsL <- "./Data/Datasets/CountyMonthBirthRate2014Version.csv"
# 
# # Code Files:
# pathManipulateCensus <- "./UtilityScripts/IsolateCensusPopsForGfr.R"
# pathCalculateGfr <- "./UtilityScripts/CalculateGfr.R"
# 
# #Report Files:
# pathsReports <- base::file.path("./vignettes", c("MbrFigures.Rmd", "OkFertilityWithIntercensalEstimates.Rmd"))
# 
# ###################################
# # Verify the necessary path can be found.
# 
# # The raw/input data files:
# testit::assert("The 10 census files from 199x should exist.", base::file.exists(pathCensus199x))
# testit::assert("The 200x census file should exist.", base::file.exists(pathCensus200x))
# testit::assert("The county FIPS values should exist.", base::file.exists(pathCountyFips))
# 
# # Code Files:
# testit::assert("The file that restructures the census data should exist.", base::file.exists(pathManipulateCensus))
# testit::assert("The file that calculates the GFR should exist.", base::file.exists(pathCalculateGfr))
# 
# #Report Files:
# testit::assert("The knitr Rmd files should exist.", base::file.exists(pathsReports))
# 
