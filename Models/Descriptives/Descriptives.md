-   Descriptives:
-   Basic demographics
-   Distribution of age variables
    -   Months of births
    -   Age and cohort structure

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->










Descriptives:
=============

Basic descriptives reports on selected NLSY97 items

Basic demographics
==================

After importing a clean dataset **dsL**

``` {.r}
dsL<-readRDS("./Data/Derived/dsL.rds")
dplyr::summarize(dsL,N=n_distinct(id))
```

         N
    1 8983

respondents. Of them one (id=467) was removed from the dataset due to abberant age score that seemed as a coding mistake. NLSY97 contains representative household sample and the oversample of racial minorities.

``` {.r}
ds<- dsL %>% dplyr::group_by(sampleF) %>% summarize (count=n_distinct(id))
ds
```

      count
    1  8983

    ymax not defined: adjusting position using y instead
    ymax not defined: adjusting position using y instead

![plot of chunk basic\_demo](figure_rmd/Descriptives/basic_demo.png)

Distribution of age variables
=============================

The age of respondents was of particular interest and was entered as a predictor of the model outcome. NSLY97 contains static and dynamic indicators of age age. Variables byear and bmonth were recorded once in 1997 (static) and contain respondentsâ€™ birth year and birth month respectively. Two age variables were recorded continuously at each interview (dynamic): age at the time of the interview in months agemon and in years ageyear. Next graph shows how births in the NLSY97 sample (static age) was distributed over calendric months from 1980 to 1984:

Months of births
----------------

    Source: local data frame [13 x 4]
    Groups: bmonth

       bmonth byearF count  born
    1       1   1980   159  80-1
    2       2   1980   136  80-2
    3       3   1980   139  80-3
    4       4   1980   125  80-4
    5       5   1980   128  80-5
    6       6   1980   137  80-6
    7       7   1980   136  80-7
    8       8   1980   141  80-8
    9       9   1980   144  80-9
    10     10   1980   146 80-10
    11     11   1980   146 80-11
    12     12   1980   154 80-12
    13      1   1981   160  81-1

![plot of chunk bmonth\_dist](figure_rmd/Descriptives/bmonth_dist.png)

Age and cohort structure
------------------------

![plot of chunk agemon\_dist](figure_rmd/Descriptives/agemon_dist.png)

=== Read more in <code>./Models/Descriptives</code>:
+ [Descriptives](./Descriptives.md) - basic stats of various items
+ [Attendance](./Attendance.md) - focus on church attendence over time
+ [Metrics](./Metrics.md) - how values of items are labeled
+ [Databox](./Databox.md)
