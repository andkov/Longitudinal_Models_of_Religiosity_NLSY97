Descriptive statistics
=================================================
This report offers basic statical graphs describing  NLSY97 religiosity data. For list of graphs pupulating the interactive databox, see "**Descriptives List**" report


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->




<!-- Set the report-wide options, and point to the external code file. -->








First we load the data, specifically the dataset **dsL**, obtained by the report [Derive_dsL_from_Extract](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Data/Derive_dsL_from_Extract.md) and saved as a **.rds** dataset file, native to R.








```r
# see code in .Rmd file
```


Initial point of departure - the [databox](http://statcanvas.net/thesis/databox/) of the selected sample, described in the [Methods](http://statcanvas.net/thesis/III_methods/03_Methods.htm) chapter and located in the [Results](http://statcanvas.net/thesis/IV_Results/04_Results.htm) chapter of the dissertation.
<img link src="./figure_rmd/3_Methods_Figure_3_2.png" alt="Databox slice" style="width:900px;"/>
This databox corresponds to the dataset **dsL** the screenshot of which is given below
<img link src="./figure_rmd/3_Methods_Figure_3_3.png" alt="View of dsL" style="width:1200px;"/>  

We don't need all the variables at the moment, so let's select only those we need to describe how respondents' church attendance was changing across time. Looking at the figures above, we type in the names of variables we want to pick

```r
print (dsL[dsL$id==1,c("id","year","attend")]) # print [ rows, columns/variables]
```

```
   id year          attend
1   1 1997            <NA>
2   1 1998            <NA>
3   1 1999            <NA>
4   1 2000           Never
5   1 2001 About once/week
6   1 2002   Once or Twice
7   1 2003           Never
8   1 2004           Never
9   1 2005           Never
10  1 2006           Never
11  1 2007           Never
12  1 2008           Never
13  1 2009           Never
14  1 2010           Never
15  1 2011           Never
```

```r
selectCols<-c("year","id","byear","agemon","attend") # type in variable name
ds<-dsL[,selectCols] # select all rows and only columns listed in the object selectCols
print(ds[ds$id==1,])  # print all availible data for respondent with ID number of 1
```

```
   year id byear agemon          attend
1  1997  1  1981    190            <NA>
2  1998  1  1981    206            <NA>
3  1999  1  1981    219            <NA>
4  2000  1  1981    231           Never
5  2001  1  1981    243 About once/week
6  2002  1  1981    256   Once or Twice
7  2003  1  1981    266           Never
8  2004  1  1981    279           Never
9  2005  1  1981    290           Never
10 2006  1  1981    302           Never
11 2007  1  1981    313           Never
12 2008  1  1981    325           Never
13 2009  1  1981    337           Never
14 2010  1  1981    350           Never
15 2011  1  1981    360           Never
```

Generally we can select any desired dataset by formula **dataset[_condition for rows_,_condition for columns_]

```r
ds<-dsL[dsL$year %in% c(2000:2011),c('id',"byear","year","attend","ageyear","agemon")]
```






We can apply a full or short label to the values recorded in the variable **attend**, for the definitions of all factor labels see [Manipulate](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Manipulation/LabelingFactorLevels.R) code.

selectRows<-dsL$year %in% c(2000:2011)
Attend
print(ds$id[ds$id==1,])  # print first few lines of data
length(unique(ds$id)) # number of respondents in the dataset

The view shows all the measurements taken from one individual (id=1) for the selected variables (columns). All datasets for modeling are derived by subsetting the columns of this one. However, it's easier to see the overall data layout with expressing **dsL** as a slice of Cattell's databox, showing variables across occasions.
ds<-dsL[dsL$year %in% c(2000:2011),c('id',"byear","year","attend","ageyear","agemon")]
ds<- dsLCM[dsLCM$id %in% c(1),]
ds$age<-ds$year-ds$byear
ds$ageALT<- ds$agemon/12
print(ds)


Notice that this view is obtained by transposing the columns of the databox slice in Figure 3.3, save for **year**, which values are used as symbols to represent intersections of variables and occasions.


```r
source(file.path(pathDir,"UtilityScripts/produceMDandHTML.R"))
```


