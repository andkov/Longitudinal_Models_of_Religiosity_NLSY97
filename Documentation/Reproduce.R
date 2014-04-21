
###################################
### Reproducible Research
###################################
# When executed by R, this file will manipulate the original data sources (ie, ZZZZ)
# to produce a groomed dataset suitable for analysis and graphing.



###################################
# Clear memory from previous runs
base::rm(list=base::ls(all=TRUE))

#####################################
## @knitr LoadData

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
base::require(plyr)
base::require(reshape2)



  ### Import the data ##
pathDir<-file.path(getwd()) # define path for project root directory

# Links to the data source
tagset<-c("NLSY97_Religiosity_20042014") #"Database_ResponseOfInterest_DateOfDownload"
pathDataFolder<-file.path(getwd(),paste0("Documentation/data/",tagset))
pathDataSource<-file.path(pathDataFolder,paste0(tagset,".csv")) 
pathDataSourceLabels<-file.path(pathDataFolder,paste0(tagset,".dct"))  
# reading in the data
dsSource<-read.csv(pathDataSource,header=TRUE, skip=0,sep=",")
varnames<-names(dsSource)

# NLSY97 variable id are linked to the descriptive label in the file dictionary file "NLSY97_Religiosity_20042014.dtc"
dsSourceLabels<-read.csv(pathDataSourceLabels,header=TRUE, skip=0,nrow=ncol(dsSource), sep="")
dsSourceLabels$X.<-NULL
dsSourceLabels<-rename(dsSourceLabels,replace=c("infile"="RNUM","dictionary"="VARIABLE_TITLE"))

#sort by mpg (ascending) and cyl (descending)
dsSourceLabels<-arrange(dsSourceLabels,VARIABLE_TITLE) # sort by Variable Title
write.table(dsSourceLabels, "./Documentation/data/dsSourceLabels.csv", sep=",")

############################
## @knitr TweakData

# Using renaming template "NLSY97_Religiosity_20042014.xlsx" located in "Documentation\data" folder
# rename the native variable names of NLSY97 (left) into custom chosen names for programming convenience (right)

dsSource<-rename(dsSource, c(
  "R0323900"="famrel_1997",
  "R2165200"="famrel_1998",
  "R3483100"="famrel_1999",
  "R4881300"="famrel_2000",
  "S2977900"="internet_2003",
  "S4676700"="internet_2004",
  "S6308900"="internet_2005",
  "S8329800"="internet_2006",
  "T0737600"="internet_2007",
  "T2779700"="internet_2008",
  "T4494400"="internet_2009",
  "T6141400"="internet_2010",
  "T7635300"="internet_2011",
  "R1193900"="agemon_1997",
  "R2553400"="agemon_1998",
  "R3876200"="agemon_1999",
  "R5453600"="agemon_2000",
  "R7215900"="agemon_2001",
  "S1531300"="agemon_2002",
  "S2000900"="agemon_2003",
  "S3801000"="agemon_2004",
  "S5400900"="agemon_2005",
  "S7501100"="agemon_2006",
  "T0008400"="agemon_2007",
  "T2011000"="agemon_2008",
  "T3601400"="agemon_2009",
  "T5201300"="agemon_2010",
  "T6651200"="agemon_2011",
  "R1194100"="ageyear_1997",
  "R2553500"="ageyear_1998",
  "R3876300"="ageyear_1999",
  "R5453700"="ageyear_2000",
  "R7216000"="ageyear_2001",
  "S1531400"="ageyear_2002",
  "S2001000"="ageyear_2003",
  "S3801100"="ageyear_2004",
  "S5401000"="ageyear_2005",
  "S7501200"="ageyear_2006",
  "T0008500"="ageyear_2007",
  "T2011100"="ageyear_2008",
  "T3601500"="ageyear_2009",
  "T5201400"="ageyear_2010",
  "T6651300"="ageyear_2011",
  "R1235800"="sample",
  "S0919700"="todo_2002",
  "S6317100"="todo_2005",
  "T2782200"="todo_2008",
  "T7637800"="todo_2011",
  "R4893900"="happy_2000",
  "S0921100"="happy_2002",
  "S4682200"="happy_2004",
  "S8332600"="happy_2006",
  "T2782900"="happy_2008",
  "T6144000"="happy_2010",
  "R4893600"="nervous_2000",
  "S0920800"="nervous_2002",
  "S4681900"="nervous_2004",
  "S8332300"="nervous_2006",
  "T2782600"="nervous_2008",
  "T6143700"="nervous_2010",
  "R4893700"="calm_2000",
  "S0920900"="calm_2002",
  "S4682000"="calm_2004",
  "S8332400"="calm_2006",
  "T2782700"="calm_2008",
  "T6143800"="calm_2010",
  "R4894000"="depressed_2000",
  "S0921200"="depressed_2002",
  "S4682300"="depressed_2004",
  "S8332700"="depressed_2006",
  "T2783000"="depressed_2008",
  "T6144100"="depressed_2010",
  "R4893800"="blue_2000",
  "S0921000"="blue_2002",
  "S4682100"="blue_2004",
  "S8332500"="blue_2006",
  "T2782800"="blue_2008",
  "T6143900"="blue_2010",
  "R0552400"="attendPR",
  "R4893400"="attend_2000",
  "R6520100"="attend_2001",
  "S0919300"="attend_2002",
  "S2987800"="attend_2003",
  "S4681700"="attend_2004",
  "S6316700"="attend_2005",
  "S8331500"="attend_2006",
  "T0739400"="attend_2007",
  "T2781700"="attend_2008",
  "T4495000"="attend_2009",
  "T6143400"="attend_2010",
  "T7637300"="attend_2011",
  "S1225400"="computer_2002",
  "T1049900"="computer_2007",
  "T3145100"="computer_2008",
  "T4565400"="computer_2009",
  "T6209600"="computer_2010",
  "T7707000"="computer_2011",
  "S1225500"="tv_2002",
  "T1050000"="tv_2007",
  "T3145200"="tv_2008",
  "T4565500"="tv_2009",
  "T6209700"="tv_2010",
  "T7707100"="tv_2011",
  "T2782400"="faith_2008",
  "T7638000"="faith_2011",
  "R0536401"="bmonth",
  "R0536402"="byear",
  "R1482600"="race",
  "R0536300"="sex",
  "R0000100"="id",
  "T2111500"="bornagain_2008",
  "T6759400"="bornagain_2011",
  "S0919600"="decisions_2002",
  "S6317000"="decisions_2005",
  "T2782100"="decisions_2008",
  "T7637700"="decisions_2011",
  "S0919500"="obeyed_2002",
  "S6316900"="obeyed_2005",
  "T2782000"="obeyed_2008",
  "T7637600"="obeyed_2011",
  "S5532800"="relpref_2005",
  "T2111400"="relpref_2008",
  "T6759300"="relpref_2011",
  "S0919400"="values_2002",
  "S6316800"="values_2005",
  "T2781900"="values_2008",
  "T7637500"="values_2011",
  "S0919800"="pray_2002",
  "S6317200"="pray_2005",
  "T2782300"="pray_2008",
  "T7637900"="pray_2011",
  "T6650500"="release",
  "R0552200"="relraisedPR"
))
# keeping only binary responses in attitudinal variables
dsSource$todo_2002=ifelse((dsSource$todo_2002 %in% c(0,1)),dsSource$todo_2002,NA)
dsSource$todo_2005=ifelse((dsSource$todo_2005 %in% c(0,1)),dsSource$todo_2005,NA)
dsSource$todo_2008=ifelse((dsSource$todo_2008 %in% c(0,1)) ,dsSource$todo_2008,NA)
dsSource$todo_2011=ifelse((dsSource$todo_2011 %in% c(0,1)) ,dsSource$todo_2011,NA)

dsSource$values_2002=ifelse((dsSource$values_2002 %in% c(0,1)),dsSource$values_2002,NA)
dsSource$values_2005=ifelse((dsSource$values_2005 %in% c(0,1)),dsSource$values_2005,NA)
dsSource$values_2008=ifelse((dsSource$values_2008 %in% c(0,1)) ,dsSource$values_2008,NA)
dsSource$values_2011=ifelse((dsSource$values_2011 %in% c(0,1)) ,dsSource$values_2011,NA)

dsSource$obeyed_2002=ifelse((dsSource$obeyed_2002 %in% c(0,1)),dsSource$obeyed_2002,NA)
dsSource$obeyed_2005=ifelse((dsSource$obeyed_2005 %in% c(0,1)),dsSource$obeyed_2005,NA)
dsSource$obeyed_2008=ifelse((dsSource$obeyed_2008 %in% c(0,1)) ,dsSource$obeyed_2008,NA)
dsSource$obeyed_2011=ifelse((dsSource$obeyed_2011 %in% c(0,1)) ,dsSource$obeyed_2011,NA)

dsSource$pray_2002=ifelse((dsSource$pray_2002 %in% c(0,1)),dsSource$pray_2002,NA)
dsSource$pray_2005=ifelse((dsSource$pray_2005 %in% c(0,1)),dsSource$pray_2005,NA)
dsSource$pray_2008=ifelse((dsSource$pray_2008 %in% c(0,1)) ,dsSource$pray_2008,NA)
dsSource$pray_2011=ifelse((dsSource$pray_2011 %in% c(0,1)) ,dsSource$pray_2011,NA)

dsSource$decisions_2002=ifelse((dsSource$decisions_2002 %in% c(0,1)),dsSource$decisions_2002,NA)
dsSource$decisions_2005=ifelse((dsSource$decisions_2005 %in% c(0,1)),dsSource$decisions_2005,NA)
dsSource$decisions_2008=ifelse((dsSource$decisions_2008 %in% c(0,1)) ,dsSource$decisions_2008,NA)
dsSource$decisions_2011=ifelse((dsSource$decisions_2011 %in% c(0,1)) ,dsSource$decisions_2011,NA)

# recode negativale worded question:  1 - more religious
dsSource$todo_2002=ifelse((dsSource$todo_2002 %in% c(1)),0,ifelse((dsSource$todo_2002 %in% c(0)),1,NA))
dsSource$todo_2005=ifelse((dsSource$todo_2005 %in% c(1)),0,ifelse((dsSource$todo_2005 %in% c(0)),1,NA))
dsSource$todo_2008=ifelse((dsSource$todo_2008 %in% c(1)),0,ifelse((dsSource$todo_2008 %in% c(0)),1,NA))
dsSource$todo_2011=ifelse((dsSource$todo_2011 %in% c(1)),0,ifelse((dsSource$todo_2011 %in% c(0)),1,NA))

dsSource$values_2002=ifelse((dsSource$values_2002 %in% c(1)),0,ifelse((dsSource$values_2002 %in% c(0)),1,NA))
dsSource$values_2005=ifelse((dsSource$values_2005 %in% c(1)),0,ifelse((dsSource$values_2005 %in% c(0)),1,NA))
dsSource$values_2008=ifelse((dsSource$values_2008 %in% c(1)),0,ifelse((dsSource$values_2008 %in% c(0)),1,NA))
dsSource$values_2011=ifelse((dsSource$values_2011 %in% c(1)),0,ifelse((dsSource$values_2011 %in% c(0)),1,NA))

# Recode ATTENDANCE into valid values
attendcategoreis<-c(1:8)
dsSource$attend_2000=ifelse((dsSource$attend_2000 %in% attendcategoreis),dsSource$attend_2000,NA)
dsSource$attend_2001=ifelse((dsSource$attend_2001 %in% attendcategoreis),dsSource$attend_2001,NA)
dsSource$attend_2002=ifelse((dsSource$attend_2002 %in% attendcategoreis),dsSource$attend_2002,NA)
dsSource$attend_2003=ifelse((dsSource$attend_2003 %in% attendcategoreis),dsSource$attend_2003,NA)
dsSource$attend_2004=ifelse((dsSource$attend_2004 %in% attendcategoreis),dsSource$attend_2004,NA)
dsSource$attend_2005=ifelse((dsSource$attend_2005 %in% attendcategoreis),dsSource$attend_2005,NA)
dsSource$attend_2006=ifelse((dsSource$attend_2006 %in% attendcategoreis),dsSource$attend_2006,NA)
dsSource$attend_2007=ifelse((dsSource$attend_2007 %in% attendcategoreis),dsSource$attend_2007,NA)
dsSource$attend_2008=ifelse((dsSource$attend_2008 %in% attendcategoreis),dsSource$attend_2008,NA)
dsSource$attend_2009=ifelse((dsSource$attend_2009 %in% attendcategoreis),dsSource$attend_2009,NA)
dsSource$attend_2010=ifelse((dsSource$attend_2010 %in% attendcategoreis),dsSource$attend_2010,NA)
dsSource$attend_2011=ifelse((dsSource$attend_2010 %in% attendcategoreis),dsSource$attend_2011,NA)

# keep only observations that has non-interrupted attendance for all years
# dsSource <- dsSource[dsSource$attend_2000 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2001 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2002 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2003 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2004 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2005 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2006 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2007 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2008 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2009 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2010 %in% attendcategoreis, ]
# dsSource <- dsSource[dsSource$attend_2011 %in% attendcategoreis, ]

# Include only records with a valid birth year
dsSource <- dsSource[dsSource$byear %in% 1980:1984, ]

#Include only records with a valid ID
dsSource <- dsSource[dsSource$id != "V", ]
dsSource$id <- as.integer(dsSource$id)
# remove all but one dataset
#  rm(list=setdiff(ls(), "dsSource"))



## Will's code
# #########################################################################################################
# ####
# #### The following example comes from https://github.com/wibeasley/Wats.  Rename the paths appropriately.
# ####
# 
# 
# ###################################
# # Declare the paths of the necessary files.
# 
# # The raw/input data files:
# pathCensus199x <- base::paste0("./Datasets/CensusIntercensal/STCH-icen199", 0:9, ".txt")
# pathCensus200x <- "./Datasets/CensusIntercensal/CO-EST00INT-AGESEX-5YR.csv"
# pathCountyFips <- "./Datasets/CountyFipsCode.csv"
# 
# # The derived/intermediate data files (which are produced by the repository's code files):
# pathCensusYearly <- "./Datasets/CensusIntercensal/CensusCountyYear.csv"
# pathCensusMonthly <- "./Datasets/CensusIntercensal/CensusCountyMonth.csv"
# pathDataForAnalaysis2005 <- "./Datasets/CountyMonthBirthRate2005Version.csv"
# pathDataForAnalaysis2014 <- "./Datasets/CountyMonthBirthRate2014Version.csv"
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
# ###################################
# # Run the files that manipulate and analyze.
# 
# # Execute code that restructures the Census data
# base::source(pathManipulateCensus, local=base::new.env())
# 
# # Assert that the intermediate files exist (the two files produced by `IsolateCensusPopsForGfr.R`)
# testit::assert("The yearly records should exist.", base::file.exists(pathCensusYearly))
# testit::assert("The monthly records should exist.", base::file.exists(pathCensusMonthly))
# 
# #Execute code that combines the census and birth count data.
# base::source(pathCalculateGfr, local=base::new.env())
# 
# # Verify that the two human readable datasets are present.
# testit::assert("The CSV for the 2005 Version should exist.", base::file.exists(pathDataForAnalaysis2005))
# testit::assert("The CSV for the 2014 Version should exist.", base::file.exists(pathDataForAnalaysis2014))
# 
# ###################################
# # Build the reports
# for( pathRmd in pathsReports ) {
#   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
#   pathHtml <- base::gsub(pattern=".Rmd$", replacement=".html", x=pathRmd)
#   knitr::knit(input=pathRmd, output=pathMd)
#   markdown::markdownToHTML(file=pathMd, output=pathHtml)
# }
