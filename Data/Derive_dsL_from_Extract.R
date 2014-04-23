###################################
### Reproducible Research
###################################
# Importing the raw data from the NLS Investigator download object
###################################
# Clear memory from previous runs
# base::rm(list=base::ls(all=TRUE))

#####################################
## @knitr LoadData

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
varOrig<-ncol(dsSource) # Original number of variables in the NLS download
dsSource["T6650500"]<-NULL # Remove version number for cleaner dataset


# NLSY97 variable id are linked to the descriptive label in the file dictionary file "NLSY97_Religiosity_20042014.dtc"
dsSourceLabels<-read.csv(pathDataSourceLabels,header=TRUE, skip=0,nrow=varOrig, sep="")
dsSourceLabels$X.<-NULL
dsSourceLabels<-rename(dsSourceLabels,replace=c("infile"="RNUM","dictionary"="VARIABLE_TITLE")) # rename to match NLS Web Investigator format
dsSourceLabels<-dsSourceLabels[dsSourceLabels$RNUM!="T6650500",] # remove version number from list of variables
dsSourceLabels<-arrange(dsSourceLabels,VARIABLE_TITLE) # sort by Variable Title
write.table(dsSourceLabels, "./Data/ItemMapping/dsSourceLabels.csv", sep=",")

print(nrow(dsSource))


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

# head(dsSource[,c("id","relprefPR")],20)
# Remove illegal values. See codebook for description of missingness
illegal<-as.integer(c(-5:-1,997,998,999))
SourceVariables<-names(dsSource)

for( variable in SourceVariables ){
    dsSource[,variable]=ifelse(dsSource[,variable] %in% c(-5:-1),NA,dsSource[,variable])

}

# recode negativale worded question so that :  1 - more religious, 0 - less religious
for (item in c("todo","values")){
  for (year in c(2002,2005,2008,2011)){
  itemyear<-(paste0(item , "_" , year))
  dsSource[,itemyear]=ifelse( (dsSource[,itemyear] %in% c(1)) , 0 ,ifelse((dsSource[,itemyear] %in% c(0)),1,NA))
}
}

# Include only records with a valid birth year
dsSource <- dsSource[dsSource$byear %in% 1980:1984, ]

#Include only records with a valid ID
dsSource <- dsSource[dsSource$id != "V", ]
dsSource$id <- as.integer(dsSource$id)
# remove all but one dataset
#  rm(list=setdiff(ls(), "dsSource"))



#################################
## Preparing the common Long dataset
ds<-dsSource
## id.vars declares MEASURED variables (as opposed to RESPONSE variable)
dsLong <- reshape2::melt(ds, id.vars=TIvars)

##############
head(dsLong[dsLong$id==1,],20)
# create varaible "year" by stripping the automatic ending in TV variables' names
## ?? How to read off 4 characters from right with reshape/plyr?
dsLong$year<-str_sub(dsLong$variable,-4,-1) 
# the automatic ending in TV variables' names
# ?? how to automate the creation of strings?
timepattern<-c("_1997", "_1998", "_1999", "_2000", "_2001", "_2002", "_2003", "_2004", "_2005", "_2006","_2007", "_2008", "_2009", "_2010", "_2011")
# Strip off the automatic ending
for (i in timepattern){
dsLong$variable <- gsub(pattern=i, replacement="", x=dsLong$variable) 
}
# Convert to a number.
dsLong$year <- as.integer(dsLong$year) 


# reorder for easier inspection
dsLong<-dsLong[with(dsLong, order(id,variable)), ] # alternative sorting to plyr
# view the long data for one person
print(dsLong[dsLong$id==1,]) 

##############################
## Create individual long datasets, one per TV variable
## ?? how to loop over the dataset?

## Time invariant (TI) variables are :
print (TIvars)
## Time variant (TV) variables are :
TVvars<-unique(dsLong$variable)
# TVvars<-c("attend","tv") # to test on a few variables
# Create a long (L) dataset (ds) with time invariant (TI) variables 
dsLTI<-subset(dsLong,subset=(dsLong$variable=="agemon")) # agemon because it has 1997:2011
dsLTI<-rename(dsLTI,replace=c("value"="agemon"))
dsLTI<-dsLTI[c(TIvars,"year")] # select only TI variables

## Strip off each TV from dsLong to merge later
for ( i in TVvars){
dstemp<-subset(dsLong,subset=(dsLong$variable==i))
dstemp<-rename(dstemp,replace=c("value"=i))
dstemp<-dstemp[c("id","year",i)]
dsLTI<-merge(x=dsLTI,y=dstemp,by=c("id","year"),all.x=TRUE)
}
## Merging datasets
# Outer join: merge(x = df1, y = df2, by = "CustomerId", all = TRUE)
# Left outer: merge(x = df1, y = df2, by = "CustomerId", all.x=TRUE)
# Right outer: merge(x = df1, y = df2, by = "CustomerId", all.y=TRUE)
# Cross join: merge(x = df1, y = df2, by = NULL)

# OPTIONAL. Order variables in dsL to match the order in "NLSY97_Religiosity_20042012.xlsx"
dsL_order<-c("sample"  ,"id"	,"sex"	,"race"	,"bmonth"	,"byear"	,"attendPR"	,"relprefPR"	,"relraisedPR"	,"year","agemon"	,"ageyear"	,"famrel"	,"attend"	,"values"	,"todo"	,"obeyed"	,"pray"	,"decisions"	,"relpref"	,"bornagain"	,"faith"	,"calm"	,"blue"	,"happy"	,"depressed"	,"nervous"	,"tv"	,"computer"	,"internet")
dsL<-dsLTI[dsL_order]

print(dsL[dsLong$id==1,]) 
pathdsL <- file.path(getwd(),"Data/Derived/dsL.csv")
write.csv(dsL,pathdsL,  row.names=FALSE)

# # remove all but one dataset
# rm(list=setdiff(ls(), c("TIvars","TVvars","dsL")))

