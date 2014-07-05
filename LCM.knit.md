---
title: "LCM"
output:
  html_document:
    css: ~/GitHub/Longitudinal_Models_of_Religiosity_NLSY97/www/css/thesis.css
    fig.retina: 2
    fig_width: 8
    toc: yes
  md_document:
    toc: yes
    toc_depth: 3
  pdf_document:
    fig_crop: no
    fig_width: 8
    highlight: haddock
    latex_engine: xelatex
    number_sections: yes
    toc: yes
    toc_depth: 3
  word_document:
    fig_width: 6.5
mainfont: Calibri
---




<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->












Analyzing a sequence of multilevel latent curve models of church attendance in NLSY97.

# Data

The preparation of this dataset is described in the report [Derive_dsL_from_Extract][derive]. For the scales and factor levels, refer to [Metrics][metrics] report, which relies on the script  [LabelingFactorLevels.R][labels] sourced at the end of [Derive_dsL_from_Extract][3].

A basic LCM in this sequence relies on four variables from the **dsL** dataset: identifyer (**id**), birth year which is also used as cohort indicator (**byear**), wave of measurement (**year**), and the variable of interest - worship attendance (**attend**). 

```
   id byear year attend
1   1  1981 2000      1
2   1  1981 2001      6
3   1  1981 2002      2
4   1  1981 2003      1
5   1  1981 2004      1
6   1  1981 2005      1
7   1  1981 2006      1
8   1  1981 2007      1
9   1  1981 2008      1
10  1  1981 2009      1
11  1  1981 2010      1
12  1  1981 2011      1
```

The focal variable of interest is **attend**, an item measuring church attendance in the current year. Although it was recorded on an ordinal scale, the integers used to record the response (1 through 8) are treated as measurements on the continuous scale when fitted in these statistical models. For elaboraton on metrics of church attendance and time, see [Attendance][attend] report.


New variable **timec** is created, containing the values of **year**, centered at 2000. The numbers on the horizontal axes represent years passed since 2000. In addition, time effects are added, encoded as  weights of the Lambda matrix. Notice that equality of **timec** and **linear** is coincidental. 

```
   id byear year attend timec linear quadratic cubic
1   1  1981 2000      1     0      0         0     0
2   1  1981 2001      6     1      1         1     1
3   1  1981 2002      2     2      2         4     8
4   1  1981 2003      1     3      3         9    27
5   1  1981 2004      1     4      4        16    64
6   1  1981 2005      1     5      5        25   125
7   1  1981 2006      1     6      6        36   216
8   1  1981 2007      1     7      7        49   343
9   1  1981 2008      1     8      8        64   512
10  1  1981 2009      1     9      9        81   729
11  1  1981 2010      1    10     10       100  1000
12  1  1981 2011      1    11     11       121  1331
```

NLSY97 has the data on church attendance for 12 years (as of July 2014), from 2000 to 2011. LCM models trajectories of individuals. The following graph maps the data from the previous example (id = 837):  
## model 00

\[{y_{ti}} = {\beta _0} + {\varepsilon _{ti}}\]  





