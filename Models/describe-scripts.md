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

Uses function **BuildMosaic** to combine individuals graphs into a complex manifestation of each model.

Renaming scheme:                 
			   LCMsequence => sequence
               FERE-graph  => graph-FERE  
          bar graph of fit => graph-FIT  
line graph of trajectories => graph-PREDICT  

                  LCModels => model-SPECIFY 
         singleModel_brief => model-ESTIMATE
		 
		 
## Specify statistical models

The script **model-SPECIFY.r**  contains model specifications of models as gls/lmer syntax.


		 
## Estimate model solution

The script **model-ESTIMATION.R**  contains the loop that cycles through all available model definition. Includes the following operations:   
 1. defines the dataset to model @knitr defineData 
			</br>
 2a. use lme4::lmer to estimate (if a model contains     random effects)
 2b. use nlme::gls  to estimate (if a model contains only fixed effects)
			</br>	
 3. Post-process model solution and save datasets:
	- dsmInfo.rds  *model fit and information indices*  
	- dsFERE.rds  *fixed (FE) and random effects (RE) descriptors*  
	- dsp.rds *predicted values from the model*  


## Collect model solutions

The script **model-COLLECT-SOLUTIONS.R** aggregates models results produces by the *model-ESTIMATION.r* script 


## Creating fit graph 

Scripts **customFit.R(md)** create bar graphs of fit for all models in the sequence.



	