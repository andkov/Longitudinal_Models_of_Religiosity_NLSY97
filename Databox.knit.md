The List of Descriptive Graphs for Databox
=================================================
This report creates graphs for basic descriptive statistics in the NLSY97 religiosity data as defined by the extract NLSY97_Religiosity_20042014. 


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->



<!-- Set the report-wide options, and point to the external code file. -->

<!-- Run this three chunks to get to the starting point -->





### 1. Load Data
First we load the data, specifically the dataset **dsL**, obtained by the report [Derive_dsL_from_Extract](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Data/Derive_dsL_from_Extract.md) and saved as a **.rds** dataset file, native to R.

### Figure 3.3 : View of the initial **dsL** dataset
<img link src="./figure_rmd/3_Methods_Figure_3_3.png" alt="View of dsL" style="width:900px;"/>  
The view shows all the measurements taken from one individual (id=1) for the selected variables (columns). All datasets for modeling are derived by subsetting the columns of this one. However, it's easier to see the overall data layout with expressing **dsL** as a slice of Cattell's databox, showing variables across occasions.

### Figure 3.2 : **dsL** re-expressed as a Cattell's datacube slice
<img link src="./figure_rmd/3_Methods_Figure_3_2.png" alt="Databox slice" style="width:900px;"/>
Observed that this view is obtained by transposing the columns in Figure 3.3, except for **year**, which values are used as symbols for intersections of variables and occasions.



### 2. Produce Graphs 
The following plots are organized into an interactive [display](http://religiositynlys97.businesscatalyst.com/descriptives.html)


























































