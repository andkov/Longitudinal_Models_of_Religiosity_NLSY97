Description of the scripts used in model sequencing
===  
  
**singleModel_brief.R** - conducts the analysis for a single model. Looped.

**sequenceLCM.R** - combines the graphs for each model into a report of model sequence  

**LCModels2.R** - specifies estimation formulas for each model in the sequence


**FERE graph.R** - estimation of the Fixed Effects (FE) and Random Effects (RE) are printed into a table.

**bar graph of fit.R** - skyscraper graph of Deviance, AIC, and BIC

**line graph of trajectories.R** - modeled trajectories are graphed



## Compile sequence report  

**sequenceLCM.rdm** - produces the report containing the sequence
**sequenceLCM.r** - powers the computations in **sequenceLCM.rmd**

Sources the following files:
    - FERE graph.R   *(Fixed/Random Effects)*  
    - bar graph of fit.R  *(Deviance, AIC, BIC)*  
    - line graph of trajectories.R  *(predicted patterns)*   
</br> 
    - AesDefine.R *(definitions of aesthetics used in graphs)*  
</br>
    - LCModels.R *(specifications of models as gls/lmer syntax)*  


	