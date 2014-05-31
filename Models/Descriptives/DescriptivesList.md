The List of Descriptive Graphs for Databox
=================================================
This report creates graphs for basic descriptive statistics in the NLSY97 religiosity data as defined by the extract NLSY97_Religiosity_20042014. 


<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->




<!-- Set the report-wide options, and point to the external code file. -->


<!-- Run this three chunks to get to the starting point -->









First we load the data, specifically the dataset **dsL**, obtained by the report [Derive_dsL_from_Extract](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Data/Derive_dsL_from_Extract.md) and saved as a **.rds** dataset file, native to R.

### Figure 3.3 : View of the initial **dsL** dataset
<img link src="./figure_rmd/3_Methods_Figure_3_3.png" alt="View of dsL" style="width:900px;"/>  
The view shows all the measurements taken from one individual (id=1) for the selected variables (columns). All datasets for modeling are derived by subsetting the columns of this one. However, it's easier to see the overall data layout with expressing **dsL** as a slice of Cattell's databox, showing variables across occasions.

### Figure 3.2 : **dsL** re-expressed as a Cattell's datacube slice
<img link src="./figure_rmd/3_Methods_Figure_3_2.png" alt="Databox slice" style="width:900px;"/>
Observed that this view is obtained by transposing the columns in Figure 3.3, except for **year**, which values are used as symbols for intersections of variales and occasions.



The following plots are organized into an interactive [display](http://religiositynlys97.businesscatalyst.com/descriptives.html)

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


<img src="figure_rmd/agemon1.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon2.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon3.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon4.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon5.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon6.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" />

```
Warning: cannot create file
'C:/Users/inspirion/Documents/GitHub/Longitudinal_Models_of_Religiosity_NLSY92003/Models/Descriptives/figure_rmd/agemon2003.png',
reason 'No such file or directory'
```

<img src="figure_rmd/agemon7.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon8.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" />

```
Warning: cannot create file
'C:/Users/inspirion/Documents/GitHub/Longitudinal_Models_of_Religiosity_NLSY20057/Models/Descriptives/figure_rmd/agemon2005.png',
reason 'No such file or directory'
```

<img src="figure_rmd/agemon9.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon10.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon11.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon12.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon13.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon14.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" /><img src="figure_rmd/agemon15.png" title="plot of chunk agemon" alt="plot of chunk agemon" width="565px" />


<img src="figure_rmd/ageyear.png" title="plot of chunk ageyear" alt="plot of chunk ageyear" width="565px" />


<img src="figure_rmd/famrel.png" title="plot of chunk famrel" alt="plot of chunk famrel" width="565px" />


<img src="figure_rmd/attend.png" title="plot of chunk attend" alt="plot of chunk attend" width="565px" />


<img src="figure_rmd/values.png" title="plot of chunk values" alt="plot of chunk values" width="565px" />


<img src="figure_rmd/todo.png" title="plot of chunk todo" alt="plot of chunk todo" width="565px" />


<img src="figure_rmd/obeyed.png" title="plot of chunk obeyed" alt="plot of chunk obeyed" width="565px" />


<img src="figure_rmd/decisions.png" title="plot of chunk decisions" alt="plot of chunk decisions" width="565px" />


<img src="figure_rmd/pray.png" title="plot of chunk pray" alt="plot of chunk pray" width="565px" />


<img src="figure_rmd/relpref.png" title="plot of chunk relpref" alt="plot of chunk relpref" width="565px" />


<img src="figure_rmd/bornagain.png" title="plot of chunk bornagain" alt="plot of chunk bornagain" width="565px" />


<img src="figure_rmd/faith.png" title="plot of chunk faith" alt="plot of chunk faith" width="565px" />


<img src="figure_rmd/calm.png" title="plot of chunk calm" alt="plot of chunk calm" width="565px" />


<img src="figure_rmd/blue.png" title="plot of chunk blue" alt="plot of chunk blue" width="565px" />


<img src="figure_rmd/happy.png" title="plot of chunk happy" alt="plot of chunk happy" width="565px" />


<img src="figure_rmd/depressed.png" title="plot of chunk depressed" alt="plot of chunk depressed" width="565px" />


<img src="figure_rmd/nervous.png" title="plot of chunk nervous" alt="plot of chunk nervous" width="565px" />


<img src="figure_rmd/tv.png" title="plot of chunk tv" alt="plot of chunk tv" width="565px" />


<img src="figure_rmd/computer.png" title="plot of chunk computer" alt="plot of chunk computer" width="565px" />


<img src="figure_rmd/internet.png" title="plot of chunk internet" alt="plot of chunk internet" width="565px" />




```
Error: 'x' and 'units' must have length > 0
```
