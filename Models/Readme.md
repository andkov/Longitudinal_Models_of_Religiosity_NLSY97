
Models of the data
========================================================

This folder contains modeling projects. 

In [Models/Descriptives](./Descriptives), report [Metrics.md](./Descriptives/Metrics.md) explains how raw values of selected variables are labeled, focusing the on the metrics of time and church attendance. Another report [Databox.md](./Descriptives/Databox.md)  produces the graphs and statistics for all selected variables that are s in the interactive [databox](http://statcanvas.net/thesis/databox/index.html)

In [Models/LCM](./LCM), fits a sequence of LCM models and organizes models for synthesis.


### About the models

Latent curve models (**LCM**) test certain shapes of the time effect (linear, quadratic, and cubic ) in search of the best fitting common trajectory that describes church attendance between 2000 and 2011, regressing random terms on cohort membership. 

Growth mixture models (**GMM**) selects the best fitting solutions of LCM and searcher for latent classes underlying the observed trajectory of church attendance over time. Individuals are grouped based on the similarity of their trajectories, and profiled. Birth cohort is used as predictor in determining membership in such latent profile. 

Finally, Markov/EMOSA models (**M/E**), describe states and transitions among them. Treating the same outcome (church attendance) as categorical (and not as continuous like in LCM and GMM cases), EMOSA models event occurrence and accounts for the changing ratio of categories in the population, predicting how the age of the individual affects the likelihood of staying in one (e.g. “church goer”) or another (e.g. “non-goer”) behavior category that quantifies religiosity.
