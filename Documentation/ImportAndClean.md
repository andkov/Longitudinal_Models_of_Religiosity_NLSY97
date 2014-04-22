Reproducibility Instructions
=================================================
This report narrates data preparations for the Longitudinal Models of Religiosity in NLSY97

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->



<!-- Set the report-wide options, and point to the external code file. -->




## Data Retrieval
Using [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp) a list of variables was downloaded from [NLS](http://www.bls.gov/nls/) datasets. All the downloaded materials  were unzipped into  the folder "**/Documentation/data/NLSY97_Religiosity_20042014**", located in the GitHub Repository. 
(The naming convention is "Study_Focus_DDMMYYYofDownload")   

#### The files include:    
NLSY97_Religiosity_20042014.cdb - **codebook** containing item descriptions  
NLSY97_Religiosity_20042014.csv - **data** in comma delimited format  
NLSY97_Religiosity_20042014.NLSY97 - **tagset**, the list of variables in the downloaded dataset  
NLSY97_Religiosity_20042014.dtc - STATA® **dictionary** file of selected variables, contains data as well
  

After importing the data from the datafile,
<!-- run initial import from the databank defined by tagset. --> 

```
Error: object 'tagset' not found
```

we have created the initial wide dataset with

```r
# dsSource  - cointains all imported variables
length(unique(dsSource$id)) 
```

```
[1] 0
```

individuals. Of them,

```r
# 1 - Cross-sectional
# 0 - Oversample
table(dsSource$sample)
```

```
< table of extent 0 >
```



```r
# dsSourceLabels - contains the RNUM (NLSY97 Variables codes) and VARIABLE_TITLE used by NLY Investigator 
print(dsSourceLabels) 
```

```
        RNUM                                VARIABLE_TITLE
1   R0323900              # DAYS/WK TYP FAM RELIGIOUS 1997
2   R2165200              # DAYS/WK TYP FAM RELIGIOUS 1998
3   R3483100              # DAYS/WK TYP FAM RELIGIOUS 1999
4   R4881300              # DAYS/WK TYP FAM RELIGIOUS 2000
5   S2977900 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2003
6   S4676700 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2004
7   S6308900 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2005
8   S8329800 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2006
9   T0737600 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2007
10  T2779700 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2008
11  T4494400 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2009
12  T6141400 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2010
13  T7635300 CURRENTLY HAVE ACCESS TO INTERNET? (SAQ) 2011
14  R1193900                  CV_AGE(MONTHS)_INT_DATE 1997
15  R2553400                  CV_AGE(MONTHS)_INT_DATE 1998
16  R3876200                  CV_AGE(MONTHS)_INT_DATE 1999
17  R5453600                  CV_AGE(MONTHS)_INT_DATE 2000
18  R7215900                  CV_AGE(MONTHS)_INT_DATE 2001
19  S1531300                  CV_AGE(MONTHS)_INT_DATE 2002
20  S2000900                  CV_AGE(MONTHS)_INT_DATE 2003
21  S3801000                  CV_AGE(MONTHS)_INT_DATE 2004
22  S5400900                  CV_AGE(MONTHS)_INT_DATE 2005
23  S7501100                  CV_AGE(MONTHS)_INT_DATE 2006
24  T0008400                  CV_AGE(MONTHS)_INT_DATE 2007
25  T2011000                  CV_AGE(MONTHS)_INT_DATE 2008
26  T3601400                  CV_AGE(MONTHS)_INT_DATE 2009
27  T5201300                  CV_AGE(MONTHS)_INT_DATE 2010
28  T6651200                  CV_AGE(MONTHS)_INT_DATE 2011
29  R1194100                          CV_AGE_INT_DATE 1997
30  R2553500                          CV_AGE_INT_DATE 1998
31  R3876300                          CV_AGE_INT_DATE 1999
32  R5453700                          CV_AGE_INT_DATE 2000
33  R7216000                          CV_AGE_INT_DATE 2001
34  S1531400                          CV_AGE_INT_DATE 2002
35  S2001000                          CV_AGE_INT_DATE 2003
36  S3801100                          CV_AGE_INT_DATE 2004
37  S5401000                          CV_AGE_INT_DATE 2005
38  S7501200                          CV_AGE_INT_DATE 2006
39  T0008500                          CV_AGE_INT_DATE 2007
40  T2011100                          CV_AGE_INT_DATE 2008
41  T3601500                          CV_AGE_INT_DATE 2009
42  T5201400                          CV_AGE_INT_DATE 2010
43  T6651300                          CV_AGE_INT_DATE 2011
44  R1235800                           CV_SAMPLE_TYPE 1997
45  S0919700           GOD NOTHING TO DO HAPPENS TO R 2002
46  S6317100           GOD NOTHING TO DO HAPPENS TO R 2005
47  T2782200           GOD NOTHING TO DO HAPPENS TO R 2008
48  T7637800           GOD NOTHING TO DO HAPPENS TO R 2011
49  R4893900              HOW OFT R BEEN HAPPY PERSON 2000
50  S0921100              HOW OFT R BEEN HAPPY PERSON 2002
51  S4682200              HOW OFT R BEEN HAPPY PERSON 2004
52  S8332600              HOW OFT R BEEN HAPPY PERSON 2006
53  T2782900              HOW OFT R BEEN HAPPY PERSON 2008
54  T6144000              HOW OFT R BEEN HAPPY PERSON 2010
55  R4893600            HOW OFT R BEEN NERVOUS PERSON 2000
56  S0920800            HOW OFT R BEEN NERVOUS PERSON 2002
57  S4681900            HOW OFT R BEEN NERVOUS PERSON 2004
58  S8332300            HOW OFT R BEEN NERVOUS PERSON 2006
59  T2782600            HOW OFT R BEEN NERVOUS PERSON 2008
60  T6143700            HOW OFT R BEEN NERVOUS PERSON 2010
61  R4893700          HOW OFT R CALM/PEACEFUL PAST MO 2000
62  S0920900          HOW OFT R CALM/PEACEFUL PAST MO 2002
63  S4682000          HOW OFT R CALM/PEACEFUL PAST MO 2004
64  S8332400          HOW OFT R CALM/PEACEFUL PAST MO 2006
65  T2782700          HOW OFT R CALM/PEACEFUL PAST MO 2008
66  T6143800          HOW OFT R CALM/PEACEFUL PAST MO 2010
67  R4894000           HOW OFT R DEPRESSED LAST MONTH 2000
68  S0921200           HOW OFT R DEPRESSED LAST MONTH 2002
69  S4682300           HOW OFT R DEPRESSED LAST MONTH 2004
70  S8332700           HOW OFT R DEPRESSED LAST MONTH 2006
71  T2783000           HOW OFT R DEPRESSED LAST MONTH 2008
72  T6144100           HOW OFT R DEPRESSED LAST MONTH 2010
73  R4893800              HOW OFT R FELT DOWN OR BLUE 2000
74  S0921000              HOW OFT R FELT DOWN OR BLUE 2002
75  S4682100              HOW OFT R FELT DOWN OR BLUE 2004
76  S8332500              HOW OFT R FELT DOWN OR BLUE 2006
77  T2782800              HOW OFT R FELT DOWN OR BLUE 2008
78  T6143900              HOW OFT R FELT DOWN OR BLUE 2010
79  R0552400             HOW OFTEN PR CHURCH LAST YR? 1997
80  R4893400          HOW OFTEN R ATTEND WORSHIP SERV 2000
81  R6520100          HOW OFTEN R ATTEND WORSHIP SERV 2001
82  S0919300          HOW OFTEN R ATTEND WORSHIP SERV 2002
83  S2987800          HOW OFTEN R ATTEND WORSHIP SERV 2003
84  S4681700          HOW OFTEN R ATTEND WORSHIP SERV 2004
85  S6316700          HOW OFTEN R ATTEND WORSHIP SERV 2005
86  S8331500          HOW OFTEN R ATTEND WORSHIP SERV 2006
87  T0739400          HOW OFTEN R ATTEND WORSHIP SERV 2007
88  T2781700          HOW OFTEN R ATTEND WORSHIP SERV 2008
89  T4495000          HOW OFTEN R ATTEND WORSHIP SERV 2009
90  T6143400          HOW OFTEN R ATTEND WORSHIP SERV 2010
91  T7637300          HOW OFTEN R ATTEND WORSHIP SERV 2011
92  S1225400                 HRS/WK R USES A COMPUTER 2002
93  T1049900                 HRS/WK R USES A COMPUTER 2007
94  T3145100                 HRS/WK R USES A COMPUTER 2008
95  T4565400                 HRS/WK R USES A COMPUTER 2009
96  T6209600                 HRS/WK R USES A COMPUTER 2010
97  T7707000                 HRS/WK R USES A COMPUTER 2011
98  S1225500              HRS/WK R WATCHES TELEVISION 2002
99  T1050000              HRS/WK R WATCHES TELEVISION 2007
100 T3145200              HRS/WK R WATCHES TELEVISION 2008
101 T4565500              HRS/WK R WATCHES TELEVISION 2009
102 T6209700              HRS/WK R WATCHES TELEVISION 2010
103 T7707100              HRS/WK R WATCHES TELEVISION 2011
104 T2782400  IMPORT OF RELIGIOUS FAITH IN DAILY LIFE 2008
105 T7638000  IMPORT OF RELIGIOUS FAITH IN DAILY LIFE 2011
106 R0536401                   KEY!BDATE M/Y (SYMBOL) 1997
107 R0536402                   KEY!BDATE M/Y (SYMBOL) 1997
108 R1482600              KEY!RACE_ETHNICITY (SYMBOL) 1997
109 R0536300                         KEY!SEX (SYMBOL) 1997
110 R0000100                      PUBID - YTH ID CODE 1997
111 T2111500    R A BORN-AGAIN EVANGELICAL CHRISTIAN? 2008
112 T6759400    R A BORN-AGAIN EVANGELICAL CHRISTIAN? 2011
113 S0919600           R ASKS GOD HELP MAKE DECISIONS 2002
114 S6317000           R ASKS GOD HELP MAKE DECISIONS 2005
115 T2782100           R ASKS GOD HELP MAKE DECISIONS 2008
116 T7637700           R ASKS GOD HELP MAKE DECISIONS 2011
117 S0919500         R BELIEVE RELIG TEACHINGS OBEYED 2002
118 S6316900         R BELIEVE RELIG TEACHINGS OBEYED 2005
119 T2782000         R BELIEVE RELIG TEACHINGS OBEYED 2008
120 T7637600         R BELIEVE RELIG TEACHINGS OBEYED 2011
121 S5532800                          R CURR REL PREF 2005
122 T2111400                          R CURR REL PREF 2008
123 T6759300                          R CURR REL PREF 2011
124 S0919400       R NOT NEED RELIGION TO HAVE VALUES 2002
125 S6316800       R NOT NEED RELIGION TO HAVE VALUES 2005
126 T2781900       R NOT NEED RELIGION TO HAVE VALUES 2008
127 T7637500       R NOT NEED RELIGION TO HAVE VALUES 2011
128 S0919800             R PRAYS MORE THAN ONCE A DAY 2002
129 S6317200             R PRAYS MORE THAN ONCE A DAY 2005
130 T2782300             R PRAYS MORE THAN ONCE A DAY 2008
131 T7637900             R PRAYS MORE THAN ONCE A DAY 2011
132 R0552300              WHAT IS PR CURR RELIG PREF? 1997
133 R0552200                 WHAT RELIG PR RAISED IN? 1997
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

After renaming, we arrive at the basic clean dataset in wide format.

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

# negativelyPhrased<-c("todo_","values_")
# negativelyYears<-c("2002","2005","2008","2011")
# 
# for (i in negativelyPhrased){
#   for(k in negativelyYears){
# dsSource$paste0(i,k)=ifelse(( dsSource$paste0(i,k) %in% c(1)),0,ifelse(( dsSource$paste0(i,k) %in% c(0)),1,NA))
# }
# }
dsLong$year <- as.integer(dsLong$year) #Convert to a number.
```

```
Error: object 'dsLong' not found
```

```r
# recode negativale worded question:  1 - more religious
dsSource$todo_2002=ifelse((dsSource$todo_2002 %in% c(1)),0,ifelse((dsSource$todo_2002 %in% c(0)),1,NA))
dsSource$todo_2005=ifelse((dsSource$todo_2005 %in% c(1)),0,ifelse((dsSource$todo_2005 %in% c(0)),1,NA))
dsSource$todo_2008=ifelse((dsSource$todo_2008 %in% c(1)),0,ifelse((dsSource$todo_2008 %in% c(0)),1,NA))
dsSource$todo_2011=ifelse((dsSource$todo_2011 %in% c(1)),0,ifelse((dsSource$todo_2011 %in% c(0)),1,NA))

dsSource$values_2002=ifelse((dsSource$values_2002 %in% c(1)),0,ifelse((dsSource$values_2002 %in% c(0)),1,NA))
dsSource$values_2005=ifelse((dsSource$values_2005 %in% c(1)),0,ifelse((dsSource$values_2005 %in% c(0)),1,NA))
dsSource$values_2008=ifelse((dsSource$values_2008 %in% c(1)),0,ifelse((dsSource$values_2008 %in% c(0)),1,NA))
dsSource$values_2011=ifelse((dsSource$values_2011 %in% c(1)),0,ifelse((dsSource$values_2011 %in% c(0)),1,NA))

# Include only records with a valid birth year
dsSource <- dsSource[dsSource$byear %in% 1980:1984, ]

#Include only records with a valid ID
dsSource <- dsSource[dsSource$id != "V", ]
dsSource$id <- as.integer(dsSource$id)
# remove all but one dataset
#  rm(list=setdiff(ls(), "dsSource"))

# Variables, which values that DON'T change with time - time invariant (TI) variables 
TIvars<-c("sample", "id", "sex","race", "byear", "bmonth", 'attendPR', "relprefPR", "relraisedPR")

??str_sub


#################################
## Preparing the common Long dataset
ds<-dsSource
## id.vars declares MEASURED variables (as opposed to RESPONSE variable)
dsLong <- reshape2::melt(ds, id.vars=TIvars)
# create varaible "year" by stripping the automatic ending in TV variables' names
dsLong$year<-str_sub(dsLong$variable,-4,-1) 
# the automatic ending in TV variables' names
timepattern<-c("_1997", "_1998", "_1999", "_2000", "_2001", "_2002", "_2003", "_2004", "_2005", "_2006","_2007", "_2008", "_2009", "_2010", "_2011")
# Strip off the automatic ending
for (i in timepattern){
dsLong$variable <- gsub(pattern=i, replacement="", x=dsLong$variable) 
}
# Convert to a number.
dsLong$year <- as.integer(dsLong$year) 
# Remove illegal values
illegal<-c(-5:-1,997,998,999)
dsLong$value=ifelse(dsLong$value %in% illegal,NA,dsLong$value)
# reorder for easier inspection
dsLong<-dsLong[with(dsLong, order(id,variable)), ]
# view the long data for one person
print(dsLong[dsLong$id==1,]) 

##############################
## Create individual long datasets, one per TV variable
TVvars<-unique(dsLong$variable)
TVvars<-"attend"

dsL_agemon<-subset(dsLong,subset=(dsLong$variable=="agemon"))
dsL_agemon<-rename(dsL_agemon,replace=c("value"="agemon"))
dsL_agemon$variable<-NULL

dsL_attend<-subset(dsLong,subset=(dsLong$variable=="attend"))
dsL_attend<-rename(dsL_attend,replace=c("value"="attend"))
dsL_attend$variable<-NULL

dsL_internet<-subset(dsLong,subset=(dsLong$variable=="internet"))
dsL_internet<-rename(dsL_internet,replace=c("value"="internet"))
dsL_internet$variable<-NULL

dsL<-merge(x=dsL_agemon,y=dsL_attend,by=c(TIvars,"year"),all.x=TRUE)
dsL<-arrange(dsL,id)

print(dsL[dsLong$id==1,]) 
```

```
        sample id sex race byear bmonth attendPR relprefPR relraisedPR  variable value year
8985         1  1   2    4  1981      9        7        21          21    agemon   190 1997
35937        1  1   2    4  1981      9        7        21          21    agemon   206 1998
62889        1  1   2    4  1981      9        7        21          21    agemon   219 1999
143745       1  1   2    4  1981      9        7        21          21    agemon   231 2000
170697       1  1   2    4  1981      9        7        21          21    agemon   243 2001
305457       1  1   2    4  1981      9        7        21          21    agemon   256 2002
323425       1  1   2    4  1981      9        7        21          21    agemon   266 2003
359361       1  1   2    4  1981      9        7        21          21    agemon   279 2004
440217       1  1   2    4  1981      9        7        21          21    agemon   290 2005
530057       1  1   2    4  1981      9        7        21          21    agemon   302 2006
610913       1  1   2    4  1981      9        7        21          21    agemon   313 2007
664817       1  1   2    4  1981      9        7        21          21    agemon   325 2008
835513       1  1   2    4  1981      9        7        21          21    agemon   337 2009
889417       1  1   2    4  1981      9        7        21          21    agemon   350 2010
988241       1  1   2    4  1981      9        7        21          21    agemon   360 2011
17969        1  1   2    4  1981      9        7        21          21   ageyear    15 1997
44921        1  1   2    4  1981      9        7        21          21   ageyear    17 1998
71873        1  1   2    4  1981      9        7        21          21   ageyear    18 1999
152729       1  1   2    4  1981      9        7        21          21   ageyear    19 2000
179681       1  1   2    4  1981      9        7        21          21   ageyear    20 2001
314441       1  1   2    4  1981      9        7        21          21   ageyear    21 2002
332409       1  1   2    4  1981      9        7        21          21   ageyear    22 2003
368345       1  1   2    4  1981      9        7        21          21   ageyear    23 2004
449201       1  1   2    4  1981      9        7        21          21   ageyear    24 2005
539041       1  1   2    4  1981      9        7        21          21   ageyear    25 2006
619897       1  1   2    4  1981      9        7        21          21   ageyear    26 2007
673801       1  1   2    4  1981      9        7        21          21   ageyear    27 2008
844497       1  1   2    4  1981      9        7        21          21   ageyear    28 2009
898401       1  1   2    4  1981      9        7        21          21   ageyear    29 2010
997225       1  1   2    4  1981      9        7        21          21   ageyear    29 2011
89841        1  1   2    4  1981      9        7        21          21    attend     1 2000
161713       1  1   2    4  1981      9        7        21          21    attend     6 2001
188665       1  1   2    4  1981      9        7        21          21    attend     2 2002
350377       1  1   2    4  1981      9        7        21          21    attend     1 2003
386313       1  1   2    4  1981      9        7        21          21    attend     1 2004
476153       1  1   2    4  1981      9        7        21          21    attend     1 2005
557009       1  1   2    4  1981      9        7        21          21    attend     1 2006
637865       1  1   2    4  1981      9        7        21          21    attend     1 2007
709737       1  1   2    4  1981      9        7        21          21    attend     1 2008
862465       1  1   2    4  1981      9        7        21          21    attend     1 2009
916369       1  1   2    4  1981      9        7        21          21    attend     1 2010
1033161      1  1   2    4  1981      9        7        21          21    attend     1 2011
116793       1  1   2    4  1981      9        7        21          21      blue     3 2000
260537       1  1   2    4  1981      9        7        21          21      blue     2 2002
413265       1  1   2    4  1981      9        7        21          21      blue     1 2004
583961       1  1   2    4  1981      9        7        21          21      blue     1 2006
790593       1  1   2    4  1981      9        7        21          21      blue     3 2008
943321       1  1   2    4  1981      9        7        21          21      blue     3 2010
691769       1  1   2    4  1981      9        7        21          21 bornagain    NA 2008
1015193      1  1   2    4  1981      9        7        21          21 bornagain    NA 2011
107809       1  1   2    4  1981      9        7        21          21      calm     3 2000
251553       1  1   2    4  1981      9        7        21          21      calm     4 2002
404281       1  1   2    4  1981      9        7        21          21      calm     4 2004
574977       1  1   2    4  1981      9        7        21          21      calm     4 2006
781609       1  1   2    4  1981      9        7        21          21      calm     3 2008
934337       1  1   2    4  1981      9        7        21          21      calm     3 2010
287489       1  1   2    4  1981      9        7        21          21  computer     5 2002
646849       1  1   2    4  1981      9        7        21          21  computer     6 2007
817545       1  1   2    4  1981      9        7        21          21  computer    NA 2008
871449       1  1   2    4  1981      9        7        21          21  computer     6 2009
970273       1  1   2    4  1981      9        7        21          21  computer     6 2010
1087065      1  1   2    4  1981      9        7        21          21  computer     6 2011
215617       1  1   2    4  1981      9        7        21          21 decisions     1 2002
503105       1  1   2    4  1981      9        7        21          21 decisions     1 2005
736689       1  1   2    4  1981      9        7        21          21 decisions     1 2008
1060113      1  1   2    4  1981      9        7        21          21 decisions     1 2011
134761       1  1   2    4  1981      9        7        21          21 depressed     3 2000
278505       1  1   2    4  1981      9        7        21          21 depressed     2 2002
431233       1  1   2    4  1981      9        7        21          21 depressed     1 2004
601929       1  1   2    4  1981      9        7        21          21 depressed     1 2006
808561       1  1   2    4  1981      9        7        21          21 depressed     3 2008
961289       1  1   2    4  1981      9        7        21          21 depressed     3 2010
763641       1  1   2    4  1981      9        7        21          21     faith     3 2008
1096049      1  1   2    4  1981      9        7        21          21     faith     1 2011
1            1  1   2    4  1981      9        7        21          21    famrel    NA 1997
26953        1  1   2    4  1981      9        7        21          21    famrel    NA 1998
53905        1  1   2    4  1981      9        7        21          21    famrel    NA 1999
80857        1  1   2    4  1981      9        7        21          21    famrel    NA 2000
125777       1  1   2    4  1981      9        7        21          21     happy     3 2000
269521       1  1   2    4  1981      9        7        21          21     happy     3 2002
422249       1  1   2    4  1981      9        7        21          21     happy     4 2004
592945       1  1   2    4  1981      9        7        21          21     happy     4 2006
799577       1  1   2    4  1981      9        7        21          21     happy     3 2008
952305       1  1   2    4  1981      9        7        21          21     happy     3 2010
341393       1  1   2    4  1981      9        7        21          21  internet     1 2003
377329       1  1   2    4  1981      9        7        21          21  internet     0 2004
467169       1  1   2    4  1981      9        7        21          21  internet     1 2005
548025       1  1   2    4  1981      9        7        21          21  internet     1 2006
628881       1  1   2    4  1981      9        7        21          21  internet     1 2007
700753       1  1   2    4  1981      9        7        21          21  internet     1 2008
853481       1  1   2    4  1981      9        7        21          21  internet     1 2009
907385       1  1   2    4  1981      9        7        21          21  internet     1 2010
1024177      1  1   2    4  1981      9        7        21          21  internet     1 2011
98825        1  1   2    4  1981      9        7        21          21   nervous     3 2000
242569       1  1   2    4  1981      9        7        21          21   nervous     1 2002
395297       1  1   2    4  1981      9        7        21          21   nervous     1 2004
565993       1  1   2    4  1981      9        7        21          21   nervous     1 2006
772625       1  1   2    4  1981      9        7        21          21   nervous     3 2008
925353       1  1   2    4  1981      9        7        21          21   nervous     3 2010
206633       1  1   2    4  1981      9        7        21          21    obeyed     1 2002
494121       1  1   2    4  1981      9        7        21          21    obeyed     0 2005
727705       1  1   2    4  1981      9        7        21          21    obeyed     0 2008
1051129      1  1   2    4  1981      9        7        21          21    obeyed     0 2011
233585       1  1   2    4  1981      9        7        21          21      pray     0 2002
521073       1  1   2    4  1981      9        7        21          21      pray     0 2005
754657       1  1   2    4  1981      9        7        21          21      pray     0 2008
1078081      1  1   2    4  1981      9        7        21          21      pray     0 2011
458185       1  1   2    4  1981      9        7        21          21   relpref    21 2005
682785       1  1   2    4  1981      9        7        21          21   relpref    21 2008
1006209      1  1   2    4  1981      9        7        21          21   relpref    21 2011
224601       1  1   2    4  1981      9        7        21          21      todo     1 2002
512089       1  1   2    4  1981      9        7        21          21      todo     1 2005
745673       1  1   2    4  1981      9        7        21          21      todo     1 2008
1069097      1  1   2    4  1981      9        7        21          21      todo     1 2011
296473       1  1   2    4  1981      9        7        21          21        tv     2 2002
655833       1  1   2    4  1981      9        7        21          21        tv     2 2007
826529       1  1   2    4  1981      9        7        21          21        tv    NA 2008
880433       1  1   2    4  1981      9        7        21          21        tv     2 2009
979257       1  1   2    4  1981      9        7        21          21        tv     1 2010
197649       1  1   2    4  1981      9        7        21          21    values     1 2002
485137       1  1   2    4  1981      9        7        21          21    values     0 2005
718721       1  1   2    4  1981      9        7        21          21    values     0 2008
1042145      1  1   2    4  1981      9        7        21          21    values     0 2011
```

```
    sample id sex race byear bmonth attendPR relprefPR relraisedPR year agemon attend
1        1  1   2    4  1981      9        7        21          21 1997    190     NA
2        1  1   2    4  1981      9        7        21          21 1998    206     NA
3        1  1   2    4  1981      9        7        21          21 1999    219     NA
4        1  1   2    4  1981      9        7        21          21 2000    231      1
5        1  1   2    4  1981      9        7        21          21 2001    243      6
6        1  1   2    4  1981      9        7        21          21 2002    256      2
7        1  1   2    4  1981      9        7        21          21 2003    266      1
8        1  1   2    4  1981      9        7        21          21 2004    279      1
9        1  1   2    4  1981      9        7        21          21 2005    290      1
10       1  1   2    4  1981      9        7        21          21 2006    302      1
11       1  1   2    4  1981      9        7        21          21 2007    313      1
12       1  1   2    4  1981      9        7        21          21 2008    325      1
13       1  1   2    4  1981      9        7        21          21 2009    337      1
14       1  1   2    4  1981      9        7        21          21 2010    350      1
15       1  1   2    4  1981      9        7        21          21 2011    360      1
16       1  2   1    2  1982      7       -4        -4          -4 1997    178     NA
17       1  2   1    2  1982      7       -4        -4          -4 1998    196     NA
18       1  2   1    2  1982      7       -4        -4          -4 1999    209     NA
19       1  2   1    2  1982      7       -4        -4          -4 2000    221      2
20       1  2   1    2  1982      7       -4        -4          -4 2001    232      2
21       1  2   1    2  1982      7       -4        -4          -4 2002    245      1
22       1  2   1    2  1982      7       -4        -4          -4 2003    256      1
23       1  2   1    2  1982      7       -4        -4          -4 2004    268      2
24       1  2   1    2  1982      7       -4        -4          -4 2005    284      2
25       1  2   1    2  1982      7       -4        -4          -4 2006     NA     NA
26       1  2   1    2  1982      7       -4        -4          -4 2007     NA     NA
27       1  2   1    2  1982      7       -4        -4          -4 2008    318      3
28       1  2   1    2  1982      7       -4        -4          -4 2009    330      1
29       1  2   1    2  1982      7       -4        -4          -4 2010    344      2
30       1  2   1    2  1982      7       -4        -4          -4 2011    354      2
31       1  3   2    2  1983      9        3        12          12 1997    163     NA
32       1  3   2    2  1983      9        3        12          12 1998    182     NA
33       1  3   2    2  1983      9        3        12          12 1999    197     NA
34       1  3   2    2  1983      9        3        12          12 2000    210      3
35       1  3   2    2  1983      9        3        12          12 2001    222      2
36       1  3   2    2  1983      9        3        12          12 2002    232      2
37       1  3   2    2  1983      9        3        12          12 2003    249      2
38       1  3   2    2  1983      9        3        12          12 2004    255      1
39       1  3   2    2  1983      9        3        12          12 2005     NA     NA
40       1  3   2    2  1983      9        3        12          12 2006     NA     NA
41       1  3   2    2  1983      9        3        12          12 2007     NA     NA
42       1  3   2    2  1983      9        3        12          12 2008     NA     NA
43       1  3   2    2  1983      9        3        12          12 2009    317      6
44       1  3   2    2  1983      9        3        12          12 2010     NA     NA
45       1  3   2    2  1983      9        3        12          12 2011    339      2
46       1  4   2    2  1981      2        5         1           1 1997    192     NA
47       1  4   2    2  1981      2        5         1           1 1998    213     NA
48       1  4   2    2  1981      2        5         1           1 1999    228     NA
49       1  4   2    2  1981      2        5         1           1 2000    238      2
50       1  4   2    2  1981      2        5         1           1 2001    251      1
51       1  4   2    2  1981      2        5         1           1 2002    262      3
52       1  4   2    2  1981      2        5         1           1 2003    276      1
53       1  4   2    2  1981      2        5         1           1 2004    287      2
54       1  4   2    2  1981      2        5         1           1 2005    297      2
55       1  4   2    2  1981      2        5         1           1 2006    309      2
56       1  4   2    2  1981      2        5         1           1 2007    320      2
57       1  4   2    2  1981      2        5         1           1 2008    336      2
58       1  4   2    2  1981      2        5         1           1 2009    344      1
59       1  4   2    2  1981      2        5         1           1 2010    357      2
60       1  4   2    2  1981      2        5         1           1 2011    368      5
61       1  5   1    2  1982     10        2         1           1 1997    186     NA
62       1  5   1    2  1982     10        2         1           1 1998    194     NA
63       1  5   1    2  1982     10        2         1           1 1999    205     NA
64       1  5   1    2  1982     10        2         1           1 2000    218      3
65       1  5   1    2  1982     10        2         1           1 2001    234      3
66       1  5   1    2  1982     10        2         1           1 2002    243      3
67       1  5   1    2  1982     10        2         1           1 2003    255      2
68       1  5   1    2  1982     10        2         1           1 2004    266      1
69       1  5   1    2  1982     10        2         1           1 2005    277      2
70       1  5   1    2  1982     10        2         1           1 2006    289      1
71       1  5   1    2  1982     10        2         1           1 2007    300      1
72       1  5   1    2  1982     10        2         1           1 2008    312      4
73       1  5   1    2  1982     10        2         1           1 2009    323      3
74       1  5   1    2  1982     10        2         1           1 2010    338      2
75       1  5   1    2  1982     10        2         1           1 2011    348      2
76       1  6   2    2  1982      1        6         1           1 1997    188     NA
77       1  6   2    2  1982      1        6         1           1 1998    202     NA
78       1  6   2    2  1982      1        6         1           1 1999    215     NA
79       1  6   2    2  1982      1        6         1           1 2000    229      2
80       1  6   2    2  1982      1        6         1           1 2001    242      3
81       1  6   2    2  1982      1        6         1           1 2002    251      2
82       1  6   2    2  1982      1        6         1           1 2003    266      7
83       1  6   2    2  1982      1        6         1           1 2004    278      7
84       1  6   2    2  1982      1        6         1           1 2005    290      2
85       1  6   2    2  1982      1        6         1           1 2006    302      7
86       1  6   2    2  1982      1        6         1           1 2007    310      7
87       1  6   2    2  1982      1        6         1           1 2008    323      7
88       1  6   2    2  1982      1        6         1           1 2009    334      7
89       1  6   2    2  1982      1        6         1           1 2010    346      7
90       1  6   2    2  1982      1        6         1           1 2011    356      7
91       1  7   1    2  1983      4        6         1           1 1997    173     NA
92       1  7   1    2  1983      4        6         1           1 1998    187     NA
93       1  7   1    2  1983      4        6         1           1 1999    200     NA
94       1  7   1    2  1983      4        6         1           1 2000    214      6
95       1  7   1    2  1983      4        6         1           1 2001    224      1
96       1  7   1    2  1983      4        6         1           1 2002    237      1
97       1  7   1    2  1983      4        6         1           1 2003     NA     NA
98       1  7   1    2  1983      4        6         1           1 2004     NA     NA
99       1  7   1    2  1983      4        6         1           1 2005    275      1
100      1  7   1    2  1983      4        6         1           1 2006    283      1
101      1  7   1    2  1983      4        6         1           1 2007     NA     NA
102      1  7   1    2  1983      4        6         1           1 2008     NA     NA
103      1  7   1    2  1983      4        6         1           1 2009    319      1
104      1  7   1    2  1983      4        6         1           1 2010    332      1
105      1  7   1    2  1983      4        6         1           1 2011    343     NA
106      1  8   2    4  1981      6        6         1           1 1997    202     NA
107      1  8   2    4  1981      6        6         1           1 1998    210     NA
108      1  8   2    4  1981      6        6         1           1 1999    221     NA
109      1  8   2    4  1981      6        6         1           1 2000    234      2
110      1  8   2    4  1981      6        6         1           1 2001    246      2
111      1  8   2    4  1981      6        6         1           1 2002    258      4
112      1  8   2    4  1981      6        6         1           1 2003    273      3
113      1  8   2    4  1981      6        6         1           1 2004    282      3
114      1  8   2    4  1981      6        6         1           1 2005    295      3
115      1  8   2    4  1981      6        6         1           1 2006    307      3
116      1  8   2    4  1981      6        6         1           1 2007    318      3
117      1  8   2    4  1981      6        6         1           1 2008     NA     NA
118      1  8   2    4  1981      6        6         1           1 2009    344      3
119      1  8   2    4  1981      6        6         1           1 2010     NA     NA
120      1  8   2    4  1981      6        6         1           1 2011    367      3
121      1  9   1    4  1982     10        6         1           1 1997    186     NA
122      1  9   1    4  1982     10        6         1           1 1998    194     NA
123      1  9   1    4  1982     10        6         1           1 1999    205     NA
```




