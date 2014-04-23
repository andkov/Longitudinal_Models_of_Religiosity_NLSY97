Reproducibility Instructions
=================================================
This report narrates data preparations for the Longitudinal Models of Religiosity in NLSY97

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->



<!-- Set the report-wide options, and point to the external code file. -->




## Data Retrieval
Using [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp) a list of variables was downloaded from [NLS](http://www.bls.gov/nls/) datasets. All the downloaded materials  were unzipped into  the folder "**/Data/Extract/NLSY97_Religiosity_20042014**", located in the GitHub Repository. 
(The naming convention is "Study_Focus_DDMMYYYofDownload")   

#### The files include:    
NLSY97_Religiosity_20042014.cdb - **codebook** containing item descriptions  
NLSY97_Religiosity_20042014.csv - **data** in comma delimited format  
NLSY97_Religiosity_20042014.NLSY97 - **tagset**, the list of variables in the downloaded dataset  
NLSY97_Religiosity_20042014.dtc - STATA **dictionary** file of selected variables, contains data as well
  

After importing the data from the datafile,
<!-- run initial import from the databank defined by tagset. --> 


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
Error: object 'dsSourceLabels' not found
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

After renaming, we arrive at the basic clean dataset in long format.

```r
#dsSource
pathdsL<-file.path("./Data/Derived/dsL.csv")
dsL<-read.csv(pathdsL,header=T,sep=",")
```

```
Warning: cannot open file './Data/Derived/dsL.csv': No such file or directory
```

```
Error: cannot open the connection
```

```r
print(dsL[dsL$id==1,])
```

```
Error: object 'dsL' not found
```



This dataset (dsL) is the starting point for all the models used in this study. The following is a screenshot of what this file looks like in R viewer:
 ** Initial Long dataset **
<img link src="./figure_rmd/variables_layout_dsL.png" alt="Databox slice" style="width:900px;"/>  

This data structure is the Variable-Occasion Slice, rotated 90 degrees. Here, the time dimension run vertially. We can distinguish time invariate (**TI**) variables, which values do not change with time. You can see their values remaining constant for each individual (id). Column with **year** counter separates **TI** variables from time variant (**TV**) variables, which values are availible for more than one time point. The datasets used in specific modeling are transformations of this initial dataset.






