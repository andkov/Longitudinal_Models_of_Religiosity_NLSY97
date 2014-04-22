
Longitudinal Models of Religiosity: NLSY97 sample
========================================================

## Study Goal

The current study analysizes how religiosity changes during adolescence and young adulthood. Three different classes of models are considered to explain the same data. Latent curve modeling (**LCM**) fits  several time effects (linear, quadratic, and cubic ) in search of the best fitting trajectory of  church attendance between 2000 and 2011, regressing random terms on cohort membership. Growth mixture modeling (**GMM**) selects the best fitting solutions of LCM and searchers for latent classes underlying the observed church attendance. Individuals are grouped based on the similarity of their trajectories of change in church attendance over the years. Finally, Markov models (**MM**), such as EMOSA and transition analysis, describe the data in terms of categories (of religious attendance) and transitions between them, instead of trajectories. Treating the outcome scale as categorical, instead of continuous, allows to test out research hypotheses different from that of previous two modeling techniques.

## Sample

The current study uses the data from the [NLSY97](http://www.bls.gov/nls/nlsy97.htm) study, which is a part of a larger effort of the National Longitudinal Surveys [NLS](http://www.bls.gov/nls/). NLSY97 is a nationally representative sample of households including approximately 9,000 participants. Selected individuals were 12 to 16 years old as of December 31, 1996. They were interviewed annually, starting in 1997 and continuing until today. As of the current date (April 22, 20014), there are 15 publically availible rounds of NLSY97 data (1997-2011).

## Domain of Religiosity  

NLYS97 contains several items mapping into the domain of religiosity. One particular variable, measuring church attendance (Codename:attend) is measured in each year and thus is at the focus of all models. The items selected for analysis and context are shown in the following graph. 

## Variable-Occasion Slice (**VO**) 
<img link src="./Documentation/figure_rmd/variables_layout.png" alt="Databox slice" style="width:700px;"/>  

The first section of variables gives basic context variables: birth month and year, age at the time of the interview, sex, race, as well as sample indicator (cross-sectional or oversample) and id.

The second group of variables (in light gray) measures religious behaviors (relpref, attend, pray, decisions) and attitudes (values, todo, obeyed, bornagain, faith) of respondents. Another section (aslo in gray) at the bottom lists availible variables concerning religiosity of the PARENT of the respondent (attendPR, relprefPR, relraisedPR).  Between religiosity sections is a list of potential covariates, in this case a self-reported measures of emotional wellfair (calm, blue, happy, depressed, nervous) and media activities (internet, computer,tv). 
 
 
## Primary Dataset : View of one case (id=1) 
This variable-occasion slice of Cattell's databox, shows at what time points measurement exists for each of the selected variables. This datamap has a direct relationship with the structure of the primary dataset in the study

<img link src="./Documentation/figure_rmd/variables_layout_dsL.png" alt="Databox slice" style="width:700px;"/>  

in which we rotate the previous VO Slice 90 degrees. Here, we can distinguish time invariate (**TI**) variables, which values do not change with time. You can see their values remaining constant for each individual (id). Column with **year** counter separates **TI** variables from time variant (**TV**) variables, which values are availible for more than one time point. The datasets used in specific modeling are derived from this initial dataset

## Manipulation
Special report [ImportAndClean]("./Documentation/ImportAndClean.md") narrates every step in data preparation, from accessing [NLS Investigator](https://www.nlsinfo.org/investigator/pages/login.jsp) to arriving at the **dsL** dataset shown above. This dataset (**dsL**) is subsetted and transformed to fit the needs of particular modeling techinique. Reports of these transormations are given inside corresponding model analyses (LCM, GMM, MM).

## Modeling



## Documentation

<!--
pathMd <- base::file.path("./", c("README.md"))
pathHtml <- base::gsub(pattern=".md$", replacement=".html", x=pathMd)
markdown::markdownToHTML(file=pathMd, output=pathHtml)
-->

