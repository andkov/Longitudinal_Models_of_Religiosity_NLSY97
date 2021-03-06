-   Five basic functions in data handling
    -   <code>select()</code>
    -   <code>filter()</code>
    -   <code>arrange()</code>
    -   <code>mutate()</code>
    -   <code>summarize()</code>
-   Grouping and Combining
-   Base subsetting
-   Base Reference
-   Read more

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->





Demonstrating the language of data manipulation in <code>dplyr</code>
packages using **dsL** as an example

<!-- Run this three chunks to get to the starting point -->







Five basic functions in data handling
-------------------------------------

For a more detailed discussion of basic verbs and operations consult the
[R-Studio guide](http://blog.rstudio.org/2014/01/17/introducing-dplyr/)
or internal
[vignette](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)

    vignette("introduction",package="dplyr")

The following is a brief demonstration of <code>dplyr</code> syntax
using **dsL** dataset as an example. I attach prefix
<code>dplyr::</code> to avoid possible conflicts with <code>plyr</code>
package on which <code>ggplot2</code> package relies. I recommend such
practice in all <code>dplyr</code> expressions in sharable publications.

One of the innovations in <code>dplyr</code> is the ability to chain
phrases in the data manipulationsentence. The operator <code>%\>%</code>
(or <code>%.%</code>), accomplishes this, turning <code>x %\>%
f(y)</code> into <code>f(x, y) </code>.

### <code>select()</code>

selects variables into a smaller data set

    ds<-dsL
    dim(ds)

    [1] 134745     60

    ds<- dsL %>%
      dplyr::select(id,year, byear, attend, attendF)
    head(ds,13)

       id year byear attend         attendF
    1   1 1997  1981     NA            <NA>
    2   1 1998  1981     NA            <NA>
    3   1 1999  1981     NA            <NA>
    4   1 2000  1981      1           Never
    5   1 2001  1981      6 About once/week
    6   1 2002  1981      2   Once or Twice
    7   1 2003  1981      1           Never
    8   1 2004  1981      1           Never
    9   1 2005  1981      1           Never
    10  1 2006  1981      1           Never
    11  1 2007  1981      1           Never
    12  1 2008  1981      1           Never
    13  1 2009  1981      1           Never

    dim(ds)

    [1] 134745      5

### <code>filter()</code>

Removes observations that do not meet criteria. The following code
selects observation based on the type of sample

      sample         sampleF
    1      1 Cross-Sectional
    2      0      Oversample

and only between years 2000 and 2011, as only during those years the
outcome of interest <code>attend</code> was recorded.

    ds<- dsL %>%
      dplyr::filter(sample==1, year %in% c(2000:2011))%>%
      dplyr::select(id, year, attend, attendF)
    head(ds,13)

       id year attend         attendF
    1   1 2000      1           Never
    2   1 2001      6 About once/week
    3   1 2002      2   Once or Twice
    4   1 2003      1           Never
    5   1 2004      1           Never
    6   1 2005      1           Never
    7   1 2006      1           Never
    8   1 2007      1           Never
    9   1 2008      1           Never
    10  1 2009      1           Never
    11  1 2010      1           Never
    12  1 2011      1           Never
    13  2 2000      2   Once or Twice

### <code>arrange()</code>

Sorts observations

    ds<- dsL %>%
      dplyr::filter(sample==1, year %in% c(2000:2011)) %>%
      dplyr::select(id, year, attend) %>%
      dplyr::arrange(year, desc(id))
    head(ds,13)

         id year attend
    1  9022 2000      1
    2  9021 2000      2
    3  9020 2000      2
    4  9018 2000      4
    5  9017 2000      6
    6  9012 2000      5
    7  9011 2000      6
    8  9010 2000      1
    9  9009 2000      2
    10 9008 2000      6
    11 8992 2000     NA
    12 8991 2000      3
    13 8987 2000      6

    ds<- dplyr::arrange(ds, id, year)
    head(ds, 13)

       id year attend
    1   1 2000      1
    2   1 2001      6
    3   1 2002      2
    4   1 2003      1
    5   1 2004      1
    6   1 2005      1
    7   1 2006      1
    8   1 2007      1
    9   1 2008      1
    10  1 2009      1
    11  1 2010      1
    12  1 2011      1
    13  2 2000      2

### <code>mutate()</code>

Creates additional variables from the values of existing.

    ds<- dsL %>%
      dplyr::filter(sample==1, year %in% c(2000:2011)) %>%
      dplyr::select(id, byear, year, attend) %>%
      dplyr::mutate(age = year-byear, 
                    timec = year-2000,
                    linear= timec,
                    quadratic= linear^2,
                    cubic= linear^3)
    head(ds,13)

       id byear year attend age timec linear quadratic cubic
    1   1  1981 2000      1  19     0      0         0     0
    2   1  1981 2001      6  20     1      1         1     1
    3   1  1981 2002      2  21     2      2         4     8
    4   1  1981 2003      1  22     3      3         9    27
    5   1  1981 2004      1  23     4      4        16    64
    6   1  1981 2005      1  24     5      5        25   125
    7   1  1981 2006      1  25     6      6        36   216
    8   1  1981 2007      1  26     7      7        49   343
    9   1  1981 2008      1  27     8      8        64   512
    10  1  1981 2009      1  28     9      9        81   729
    11  1  1981 2010      1  29    10     10       100  1000
    12  1  1981 2011      1  30    11     11       121  1331
    13  2  1982 2000      2  18     0      0         0     0

### <code>summarize()</code>

collapses data into a single value computed according to the aggregate
functions.

    require(dplyr)
    ds<- dsL %>%
      dplyr::filter(sample==1) %>%
      dplyr::summarize(N= n_distinct(id))
    ds

         N
    1 6747

Other functions one could use with <code>summarize()</code> include:

From <code>base</code>

-   <code> min() </code>  
-   <code> max() </code>  
-   <code> mean() </code>  
-   <code> sum() </code>  
-   <code> sd() </code>  
-   <code> median() </code>  
-   <code> IQR() </code>

Native to <code>dplyr</code>

-   <code> n() </code> - number of observations in the current group  
-   <code> n\_distinct(x) </code> - count the number of unique values in
    x.  
-   <code> first(x) </code> - similar to <code>x[ 1 ]</code> + control
    over <code>NA</code>  
-   <code> last(x) </code> - similar to <code>x[length(x)] </code> +
    control over <code>NA</code>  
-   <code> nth(x, n) </code> - similar to<code> x[n] </code> + control
    over <code>NA</code>

Grouping and Combining
----------------------

The function <code>group\_by()</code> is used to identify groups in
split-apply-combine (SAC) procedure: it splits the initial data into
smaller datasets (according to all possible interactions between the
levels of supplied variables). It is these smaller datasets that
<code>summarize()</code> will individually collapse into a single
computed value according to its formula.

    ds<- dsL %>%
      dplyr::filter(sample==1, year %in% c(2000:2011)) %>%
      dplyr::select(id, year, attendF) %>%
      dplyr::group_by(year,attendF) %>%
      dplyr::summarise(count = n()) %>%
      dplyr::mutate(total = sum(count),
                  percent= count/total)
    head(ds,10)

    Source: local data frame [10 x 5]
    Groups: year

       year              attendF count total  percent
    1  2000                Never  1580  6747 0.234178
    2  2000        Once or Twice  1304  6747 0.193271
    3  2000 Less than once/month   775  6747 0.114866
    4  2000     About once/month   362  6747 0.053653
    5  2000    About twice/month   393  6747 0.058248
    6  2000      About once/week  1101  6747 0.163184
    7  2000   Several times/week   463  6747 0.068623
    8  2000             Everyday    36  6747 0.005336
    9  2000                   NA   733  6747 0.108641
    10 2001                Never  1626  6747 0.240996

To verify :

    dplyr::summarize( filter(ds, year==2000), should.be.one=sum(percent))

    Source: local data frame [1 x 2]

      year should.be.one
    1 2000             1

Base subsetting
---------------

Generally, we can compose any desired dataset by using matrix calls. The
general formula is of the form: **ds**[ *rowCond* , *colCond* ], where
**ds** is a dataframe, and *rowCond* and *colCond* are conditions for
including rows and columns of the new dataset, respectively. One can
also call a variable by attaching <code> \$ </code> followed variable
name to the name of the dataset: <code>**ds***\$variableName*</code>.

    ds<-dsL[dsL$year %in% c(2000:2011),c('id',"byear","year","agemon","attendF","ageyearF")]
    print(ds[ds$id==1,]) 

       id byear year agemon         attendF ageyearF
    4   1  1981 2000    231           Never       19
    5   1  1981 2001    243 About once/week       20
    6   1  1981 2002    256   Once or Twice       21
    7   1  1981 2003    266           Never       22
    8   1  1981 2004    279           Never       23
    9   1  1981 2005    290           Never       24
    10  1  1981 2006    302           Never       25
    11  1  1981 2007    313           Never       26
    12  1  1981 2008    325           Never       27
    13  1  1981 2009    337           Never       28
    14  1  1981 2010    350           Never       29
    15  1  1981 2011    360           Never       29

The following is a list of operatiors that can be used in these calls.
<ul>
<li>
basic math operators: <code>+</code>, <code>-</code>, <code>\*</code>,
<code>/</code>, <code>%%</code>, <code>\^</code>
</li>
<li>
math functions: <code>abs</code>, <code>acos</code>, <code>acosh</code>,
<code>asin</code>, <code>asinh</code>, <code>atan</code>,
<code>atan2</code>, <code>atanh</code>, <code>ceiling</code>,
<code>cos</code>, <code>cosh</code>, <code>cot</code>,
<code>coth</code>, <code>exp</code>, <code>floor</code>,
<code>log</code>, <code>log10</code>, <code>round</code>,
<code>sign</code>, <code>sin</code>, <code>sinh</code>,
<code>sqrt</code>, <code>tan</code>, <code>tanh</code>
</li>
<li>
logical comparisons: <code>\<</code>, <code>\<=</code>, <code>!=</code>,
<code>\>=</code>, <code>\></code>, <code>==</code>, <code>%in%</code>
</li>
<li>
boolean operations: <code>&</code>, <code>&&</code>, <code>|</code>,
<code>||</code>, <code>!</code>, <code>xor</code>
</li>
<li>
basic aggregations: <code>mean</code>, <code>sum</code>,
<code>min</code>, <code>max</code>, <code>sd</code>, <code>var</code>
</li>
</ul>

<code>dplyr</code> can translate all of these into SQL. For more of on
<code>dplyr</code> and SQL compatibility consult another built-in
[vignette](http://cran.rstudio.com/web/packages/dplyr/vignettes/databases.html)

    vignette("database",package="dplyr")

Base Reference
--------------

The following unary and binary operators are defined for <code>
base</code>. They are listed in precedence groups, from highest to
lowest.

-   <code> :: ::: </code> - access variables in a namespace  
-   <code> \$ @ </code> - component / slot extraction  
-   <code> [ [[ </code> - indexing  
-   <code> \^ </code> - exponentiation (right to left)  
-   <code> - + </code> - unary minus and plus  
-   <code> : </code> - sequence operator  
-   <code> %any% </code> - special operators (including %% and %/%)  
-   <code> \* / </code> - multiply, divide  
-   <code> + - </code> - (binary) add, subtract  
-   <code> \< \> \<= \>= == != </code> - ordering and comparison  
-   <code> ! </code> - negation  
-   <code> & && </code> - and  
-   <code> | || </code> - or  
-   <code> \~ </code> - as in formulae  
-   <code> -\> -\>\> </code> - rightwards assignment  
-   <code> \<- \<\<- </code> - assignment (right to left)  
-   <code> = </code> - assignment (right to left)  
-   <code> ? </code> - help (unary and binary)

Read more
---------

in <code>./Models/Descriptives</code>:

-   [Metrics](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Models/Descriptives/Metrics.md)
    - how values of items are labeled  
-   [Descriptives](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Models/Descriptives/Descriptives.md)
    - basic stats of various items  
-   [Attendance](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Models/Descriptives/Attendance.md)
    - focus on church attendence over time  
-   [Databox](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Models/Descriptives/Databox.Rmd)

See also

-   [Deriving Data from NLYS97
    extract](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Data/Derive_dsL_from_Extract.md)
-   [Data Manipulation
    Guide](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/blob/master/Vignettes/dplyr/Data_Manipulation_Guide.md)
