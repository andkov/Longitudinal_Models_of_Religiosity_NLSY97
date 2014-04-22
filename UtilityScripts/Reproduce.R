
###################################
### Reproducible Research
###################################
# When executed by R, this file will manipulate the original data sources (ie, ZZZZ)
# to produce a groomed dataset suitable for analysis and graphing.

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


## Will's code
# #########################################################################################################
# ####
# #### The following example comes from https://github.com/wibeasley/Wats.  Rename the paths appropriately.
# ####
# 
# 
###################################
# Declare the paths of the necessary files.

# The raw/input data files:
pathSource <- base::paste0("./Documentation/data/NLSY97_Religiosity_20042014",".csv")

# The derived/intermediate data files (which are produced by the repository's code files):
pathdsL <- "./Documentation/data/Datasets/dsL.csv"

# Code Files:
pathImportAndClean <- "./Documentation/ImportAndClean.R"
pathReproduce <- "./UtilityScripts/Reproduce.R"
# 
# #Report Files:
pathsReports <- base::file.path("./Documentation", c("ImportAndClean.Rmd"))
# 
# ###################################
# Verify the necessary path can be found.
# Report Files:
testit::assert("The knitr Rmd files should exist.", base::file.exists(pathsReports))

###################################
# Build the reports
for( pathRmd in pathsReports ) {
  pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  pathHtml <- base::gsub(pattern=".Rmd$", replacement=".html", x=pathRmd)
  knitr::knit(input=pathRmd, output=pathMd)
  markdown::markdownToHTML(file=pathMd, output=pathHtml)
}
