Reproducibility Instructions
=================================================
This report narrates data preparations for the Longitudinal Models of Religiosity in NLSY97

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->



<!-- Set the report-wide options, and point to the external code file. -->

```
Warning: cannot open file '/Data/Derive_dsL_from_Extract.R': No such file or directory
```

```
Error: cannot open the connection
```



## Data Retrieval
Using [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp) a list of variables was downloaded from [NLS](http://www.bls.gov/nls/) datasets. All the downloaded materials  were unzipped into  the folder "**/Documentation/data/NLSY97_Religiosity_20042014**", located in the GitHub Repository. 
(The naming convention is "Study_Focus_DDMMYYYofDownload")   

#### The files include:    
NLSY97_Religiosity_20042014.cdb - **codebook** containing item descriptions  
NLSY97_Religiosity_20042014.csv - **data** in comma delimited format  
NLSY97_Religiosity_20042014.NLSY97 - **tagset**, the list of variables in the downloaded dataset  
NLSY97_Religiosity_20042014.dtc - STATA **dictionary** file of selected variables, contains data as well
  

After importing the data from the datafile,
<!-- run initial import from the databank defined by tagset. --> 

```r
###################################
# Load the necessary packages.
base::require(base)
base::require(knitr)
base::require(markdown)
base::require(testit)
base::require(plyr)
base::require(reshape2)
base::require(stringr)

#################################
### Declaration of objects
# Variables, which values that DON'T change with time - time invariant (TI) variables 
TIvars<-c("sample", "id", "sex","race", "bmonth","byear",  'attendPR', "relprefPR", "relraisedPR")

#test of revert/roll back

###########################
### Import the data ##
pathDir<-file.path(getwd()) # define path for project root directory

# Links to the data source

tagset<-c("NLSY97_Religiosity_20042014") #"Database_ResponseOfInterest_DateOfDownload"
pathDataFolder<-file.path("./Data/Extracts",tagset)
pathDataSource<-file.path(pathDataFolder,paste0(tagset,".csv")) 
pathDataSourceLabels<-file.path(pathDataFolder,paste0(tagset,".dct"))

# reading in the data
dsSource<-read.csv(pathDataSource,header=TRUE, skip=0,sep=",")
```

```
Warning: cannot open file './Data/Extracts/NLSY97_Religiosity_20042014/NLSY97_Religiosity_20042014.csv': No such file
or directory
```

```
Error: cannot open the connection
```

```r
varOrig<-ncol(dsSource) # Original number of variables in the NLS download
```

```
Error: object 'dsSource' not found
```

```r
dsSource["T6650500"]<-NULL # Remove version number for cleaner dataset
```

```
Error: object 'dsSource' not found
```

```r


# NLSY97 variable id are linked to the descriptive label in the file dictionary file "NLSY97_Religiosity_20042014.dtc"
dsSourceLabels<-read.csv(pathDataSourceLabels,header=TRUE, skip=0,nrow=varOrig, sep="")
```

```
Warning: cannot open file './Data/Extracts/NLSY97_Religiosity_20042014/NLSY97_Religiosity_20042014.dct': No such file
or directory
```

```
Error: cannot open the connection
```

```r
dsSourceLabels$X.<-NULL
```

```
Error: object 'dsSourceLabels' not found
```

```r
dsSourceLabels<-rename(dsSourceLabels,replace=c("infile"="RNUM","dictionary"="VARIABLE_TITLE")) # rename to match NLS Web Investigator format
```

```
Error: object 'dsSourceLabels' not found
```

```r
dsSourceLabels<-dsSourceLabels[dsSourceLabels$RNUM!="T6650500",] # remove version number from list of variables
```

```
Error: object 'dsSourceLabels' not found
```

```r
dsSourceLabels<-arrange(dsSourceLabels,VARIABLE_TITLE) # sort by Variable Title
```

```
Error: object 'dsSourceLabels' not found
```

```r
write.table(dsSourceLabels, "./Data/ItemMapping/dsSourceLabels.csv", sep=",")
```

```
Error: object 'dsSourceLabels' not found
```

```r

print(nrow(dsSource))
```

```
Error: error in evaluating the argument 'x' in selecting a method for function 'print': Error in nrow(dsSource) : object 'dsSource' not found
```

```r


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
  "T7707100"="faith_2011",
  "T2782400"="faith_2008",
  "T7638000"="bmonth",
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
  "R0552300"="relprefPR",
  "R0552200"="relraisedPR"
  
))
```

```
Error: object 'dsSource' not found
```

```r

# head(dsSource[,c("id","relprefPR")],20)
# Remove illegal values. See codebook for description of missingness
illegal<-as.integer(c(-5:-1,997,998,999))
SourceVariables<-names(dsSource)
```

```
Error: object 'dsSource' not found
```

```r

for( variable in SourceVariables ){
    dsSource[,variable]=ifelse(dsSource[,variable] %in% c(-5:-1),NA,dsSource[,variable])

}
```

```
Error: object 'SourceVariables' not found
```

```r

# recode negativale worded question so that :  1 - more religious, 0 - less religious
for (item in c("todo","values")){
  for (year in c(2002,2005,2008,2011)){
  itemyear<-(paste0(item , "_" , year))
  dsSource[,itemyear]=ifelse( (dsSource[,itemyear] %in% c(1)) , 0 ,ifelse((dsSource[,itemyear] %in% c(0)),1,NA))
}
}
```

```
Error: object 'dsSource' not found
```

```r

# Include only records with a valid birth year
dsSource <- dsSource[dsSource$byear %in% 1980:1984, ]
```

```
Error: object 'dsSource' not found
```

```r

#Include only records with a valid ID
dsSource <- dsSource[dsSource$id != "V", ]
```

```
Error: object 'dsSource' not found
```

```r
dsSource$id <- as.integer(dsSource$id)
```

```
Error: object 'dsSource' not found
```

```r
# remove all but one dataset
#  rm(list=setdiff(ls(), "dsSource"))



#################################
## Preparing the common Long dataset
ds<-dsSource
```

```
Error: object 'dsSource' not found
```

```r
## id.vars declares MEASURED variables (as opposed to RESPONSE variable)
dsLong <- reshape2::melt(ds, id.vars=TIvars)
```

```
Error: object 'ds' not found
```

```r

##############
head(dsLong[dsLong$id==1,],20)
```

```
Error: error in evaluating the argument 'x' in selecting a method for function 'head': Error: object 'dsLong' not found
```

```r
# create varaible "year" by stripping the automatic ending in TV variables' names
## ?? How to read off 4 characters from right with reshape/plyr?
dsLong$year<-str_sub(dsLong$variable,-4,-1) 
```

```
Error: object 'dsLong' not found
```

```r
# the automatic ending in TV variables' names
# ?? how to automate the creation of strings?
timepattern<-c("_1997", "_1998", "_1999", "_2000", "_2001", "_2002", "_2003", "_2004", "_2005", "_2006","_2007", "_2008", "_2009", "_2010", "_2011")
# Strip off the automatic ending
for (i in timepattern){
dsLong$variable <- gsub(pattern=i, replacement="", x=dsLong$variable) 
}
```

```
Error: object 'dsLong' not found
```

```r
# Convert to a number.
dsLong$year <- as.integer(dsLong$year) 
```

```
Error: object 'dsLong' not found
```

```r


# reorder for easier inspection
dsLong<-dsLong[with(dsLong, order(id,variable)), ] # alternative sorting to plyr
```

```
Error: object 'dsLong' not found
```

```r
# view the long data for one person
print(dsLong[dsLong$id==1,]) 
```

```
Error: error in evaluating the argument 'x' in selecting a method for function 'print': Error: object 'dsLong' not found
```

```r

##############################
## Create individual long datasets, one per TV variable
## ?? how to loop over the dataset?

## Time invariant (TI) variables are :
print (TIvars)
```

[1] "sample"      "id"          "sex"         "race"        "bmonth"      "byear"       "attendPR"    "relprefPR"  
[9] "relraisedPR"

```r
## Time variant (TV) variables are :
TVvars<-unique(dsLong$variable)
```

```
Error: object 'dsLong' not found
```

```r
# TVvars<-c("attend","tv") # to test on a few variables
# Create a long (L) dataset (ds) with time invariant (TI) variables 
dsLTI<-subset(dsLong,subset=(dsLong$variable=="agemon")) # agemon because it has 1997:2011
```

```
Error: object 'dsLong' not found
```

```r
dsLTI<-rename(dsLTI,replace=c("value"="agemon"))
```

```
Error: object 'dsLTI' not found
```

```r
dsLTI<-dsLTI[c(TIvars,"year")] # select only TI variables
```

```
Error: object 'dsLTI' not found
```

```r

## Strip off each TV from dsLong to merge later
for ( i in TVvars){
dstemp<-subset(dsLong,subset=(dsLong$variable==i))
dstemp<-rename(dstemp,replace=c("value"=i))
dstemp<-dstemp[c("id","year",i)]
dsLTI<-merge(x=dsLTI,y=dstemp,by=c("id","year"),all.x=TRUE)
}
```

```
Error: object 'TVvars' not found
```

```r
## Merging datasets
# Outer join: merge(x = df1, y = df2, by = "CustomerId", all = TRUE)
# Left outer: merge(x = df1, y = df2, by = "CustomerId", all.x=TRUE)
# Right outer: merge(x = df1, y = df2, by = "CustomerId", all.y=TRUE)
# Cross join: merge(x = df1, y = df2, by = NULL)

# OPTIONAL. Order variables in dsL to match the order in "NLSY97_Religiosity_20042012.xlsx"
dsL_order<-c("sample"  ,"id"	,"sex"	,"race"	,"bmonth"	,"byear"	,"attendPR"	,"relprefPR"	,"relraisedPR"	,"year","agemon"	,"ageyear"	,"famrel"	,"attend"	,"values"	,"todo"	,"obeyed"	,"pray"	,"decisions"	,"relpref"	,"bornagain"	,"faith"	,"calm"	,"blue"	,"happy"	,"depressed"	,"nervous"	,"tv"	,"computer"	,"internet")
dsL<-dsLTI[dsL_order]
```

```
Error: object 'dsLTI' not found
```

```r

print(dsL[dsLong$id==1,]) 
```

```
Error: error in evaluating the argument 'x' in selecting a method for function 'print': Error: object 'dsL' not found
```

```r
pathdsL <- file.path(getwd(),"Data/Derived/dsL.csv")
write.csv(dsL,pathdsL,  row.names=FALSE)
```

```
Error: object 'dsL' not found
```

```r

# # remove all but one dataset
# rm(list=setdiff(ls(), c("TIvars","TVvars","dsL")))
```

we have created the initial wide dataset with

```r
# dsSource  - cointains all imported variables
length(unique(dsSource$id)) 
```

```
Error: object 'dsSource' not found
```

individuals. Of them,

```r
# 1 - Cross-sectional
# 0 - Oversample
table(dsSource$sample)
```

```
Error: object 'dsSource' not found
```



```r
# dsSourceLabels - contains the RNUM (NLSY97 Variables codes) and VARIABLE_TITLE used by NLY Investigator 
print(dsSourceLabels) 
```

```
Error: error in evaluating the argument 'x' in selecting a method for function 'print': Error: object 'dsSourceLabels' not found
```


To explore the variables in the native context of NLS, go to [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp), select "NLYS97 1997-2011" in the first dropdown box and then click on "Choose File" under "Upload Tagset." Select the file "NLSY97_Religiosity_20042014.NLSY97" from the folder "**/Documentation/data/NLSY97_Religiosity_20042014**", in the GitHub repository.

## Variables by Occasions
To better understand the longitudinal structure of the selected variables, the dataset was re-arranged in the two-dimensional slice of Cattell's databox: variables by occasions.
## Figure 1
<img link src="./figure_rmd/variables_layout.png" alt="Databox slice" style="width:800px;"/>  
[Interactive version]("./www/slice-vo.html")

This databox slice indicates in what year measurement was taken for selected variables  and describes the variables extracted from NLYS97 for analysis. Three descriptions are given:  
**Variable Title**, which is verbatim identifier from NLSY97,  
**Unit**, which attemps to give a brief desription of the scale on which the variable is measured, and  
**Codename**, which spells the name of the variable, as it is used in R code that services the analysis

The excel spreadsheet (*NLYS97_Religiosity_20042014.xlsx*) in the "./Documentation/data" folder, hosts this list, as well as a semi-automated routine (Tab "Renaming") to aid in renaming the repeated endings in the variable names for easier coding. The values in the "Variable Title" can be used to locate the item in the [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp) by copy/pasting it into "Word in Title" search line
## Figure 2
<img src="./figure_rmd/nls_investigator_snapshot.png" alt="Looking up items" style="width:800px ;"/>




