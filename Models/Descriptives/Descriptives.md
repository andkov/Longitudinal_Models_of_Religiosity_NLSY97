Descriptive statistics
=================================================
This report tracks down the creation of graphs for basic descriptive statistics in the NLSY97 religiosity data as defined by the extract NLSY97_Religiosity_20042014.  


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->




<!-- Set the report-wide options, and point to the external code file. -->












First we load the data, specifically the dataset **dsL**, obtained by the report [Derive_dsL_from_Extract](./Data/Derive_dsL_from_Extract.md). 

### Figure 1 : View of the initial **dsL** dataset
<img link src="./figure_rmd/dsL_view.png" alt="View of dsL" style="width:900px;"/>  
The view shows all the measurements taken from one individual (id=1) for the selected variables (columns). All datasets for modeling are derived by subsetting the columns of this one. However, it's easier to see the overall data layout with expressing **dsL** as a slice of Cattell's databox, showing variables across occasions.

### Figure 2 : **dsL** re-expressed as a Cattell's datacube slice
<img link src="./figure_rmd/variables_layout.png" alt="Databox slice" style="width:800px;"/>
Observed that this view is obtained by transposing the columns in Figure 1, except for **year**, which values are used as symbols of intersections of variales and occasions.




<img src="figure_rmd/sample_1997.png" title="plot of chunk sample_1997" alt="plot of chunk sample_1997" width="565px" />


<img src="figure_rmd/sex_1997.png" title="plot of chunk sex_1997" alt="plot of chunk sex_1997" width="565px" />


<img src="figure_rmd/race_1997.png" title="plot of chunk race_1997" alt="plot of chunk race_1997" width="565px" />


<img src="figure_rmd/bmonth_1997.png" title="plot of chunk bmonth_1997" alt="plot of chunk bmonth_1997" width="565px" />


<img src="figure_rmd/byear_1997.png" title="plot of chunk byear_1997" alt="plot of chunk byear_1997" width="565px" />



```
Error: object 'attlevels' not found
```

<img src="figure_rmd/attendPR_1997.png" title="plot of chunk attendPR_1997" alt="plot of chunk attendPR_1997" width="565px" />


<img src="figure_rmd/relprefPR_1997.png" title="plot of chunk relprefPR_1997" alt="plot of chunk relprefPR_1997" width="565px" />


<img src="figure_rmd/relraisedPR_1997.png" title="plot of chunk relraisedPR_1997" alt="plot of chunk relraisedPR_1997" width="565px" />












