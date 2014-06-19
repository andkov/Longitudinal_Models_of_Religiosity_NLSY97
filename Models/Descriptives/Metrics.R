###################################
### Reproducible Research
###################################
# Importing the raw data from the NLS Investigator download object
###################################
# Clear memory from previous runs
base::rm(list=base::ls(all=TRUE))

#####################################
## @knitr LoadPackages
# Load the necessary packages.
base::require(base)
base::require(knitr)
base::require(markdown)
base::require(rmarkdown)
base::require(testit)
base::require(plyr)
base::require(reshape2)
base::require(stringr)
base::require(pandoc)

############################
## @knitr DeclareGlobals
# Variables, which values that DON'T change with time - time invariant (TI) variables 


