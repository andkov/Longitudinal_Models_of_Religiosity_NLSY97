############################
## @knitr LoadPackages
require(RODBC)
require(plyr)
require(ggplot2)
require(reshape2)
require(lme4) #Load the library necessary for multilevel models
require(colorspace) #Load the library necessary for creating tightly-controlled palettes.
require(Hmisc)
require(lattice)

########################################################
(m12 <-lmer (attend ~ 
               1  + timec + timec2 + timec3 + agec 
             + agec:timec +agec:timec2 
             + (1 + timec + timec2 | id),
             data = ds, REML=0))
########################################################
(m11 <-lmer (attend ~ 
               1  + timec + timec2 + timec3 + agec 
             + agec:timec +agec:timec2 + agec:timec3
             + (1 + timec + timec2 | id),
             data = ds, REML=0))
######## Maximum Complexity ############################
(m10 <-lmer (attend ~ 
               1  + agec + timec + timec2 + timec3
             + agec:timec +agec:timec2 + agec:timec3
             + (1 + timec + timec2 + timec3 | id),
             data = ds, REML=0))
########################################################
(m9 <-lmer (attend ~ 
              1  + timec + timec2 + timec3 + agec 
            + agec:timec +agec:timec2 
            + (1 + timec + timec2 + timec3 | id),
            data = ds, REML=0))
########################################################
(m8 <-lmer (attend ~ 
              1  + timec + timec2 + timec3 + agec 
            + agec:timec 
            + (1 + timec + timec2 + timec3 | id),
            data = ds, REML=0))
########################################################
(m7 <-lmer (attend ~ 
              1  + timec + timec2 + timec3 + agec             
            + (1 + timec + timec2 + timec3 | id),
            data = ds, REML=0))
########################################################
(m6 <-lmer (attend ~ 
              1  + timec + timec2 + timec3            
            + (1 + timec + timec2 + timec3 | id),
            data = ds, REML=0))
########################################################
(m5 <-lmer (attend ~ 
              1  + timec + timec2 + timec3            
            + (1 + timec + timec2 | id),
            data = ds, REML=0))
########################################################
(m4 <-lmer (attend ~ 
              1  + timec + timec2            
            + (1 + timec + timec2 | id),
            data = ds, REML=0))
########################################################
(m3 <-lmer (attend ~ 
              1  + timec + timec2            
            + (1 + timec | id),
            data = ds, REML=0))
########################################################
(m2 <-lmer (attend ~ 
              1  + timec
            + (1 + timec | id),
            data = ds, REML=0))
########################################################
(m1 <-lmer (attend ~ 
              1  + timec
            + (1 | id),
            data = ds, REML=0))
########################################################
(m0 <-lmer (attend ~ 
              1 + (1 | id),
            data = ds, REML=0))
########################################################
(m00 <-lm (attend ~ 1,
 data = ds, REML=0))