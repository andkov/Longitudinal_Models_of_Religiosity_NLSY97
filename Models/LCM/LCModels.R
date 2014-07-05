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

#THis file contains all the models fitted in the presentation. The second portion of the code
# is the formulas for the fixed effect prediction and should be used 

(m12 <-lmer (attend ~ 
               1  + timec + timec2 + timec3 + agec 
             + agec:timec +agec:timec2 
             + (1 + timec + timec2 | id),
             data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         +(coefs["agec"]*dsp$agec)
  +(coefs["timec"]*dsp$timec)    +(coefs["timec:agec"]*dsp$agec*dsp$timec)
  +(coefs["timec2"]*dsp$timec2)  +(coefs["timec2:agec"]*dsp$agec*dsp$timec2)
  +(coefs["timec3"]*dsp$timec3)  
)
str(dsp$YPar)
########################################################
(m11 <-lmer (attend ~ 
               1  + timec + timec2 + timec3 + agec 
             + agec:timec +agec:timec2 + agec:timec3
             + (1 + timec + timec2 | id),
             data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         +(coefs["agec"]*dsp$agec)
  +(coefs["timec"]*dsp$timec)    +(coefs["timec:agec"]*dsp$agec*dsp$timec)
  +(coefs["timec2"]*dsp$timec2)  +(coefs["timec2:agec"]*dsp$agec*dsp$timec2)
  +(coefs["timec3"]*dsp$timec3)  +(coefs["timec3:agec"]*dsp$agec*dsp$timec3)
)
str(dsp$YPar)
######## Maximum Complexity ############################
(m10 <-lmer (attend ~ 
               1  + agec + timec + timec2 + timec3
             + agec:timec +agec:timec2 + agec:timec3
             + (1 + timec + timec2 + timec3 | id),
             data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         +(coefs["agec"]*dsp$agec)
  +(coefs["timec"]*dsp$timec)    +(coefs["agec:timec"]*dsp$agec*dsp$timec)
  +(coefs["timec2"]*dsp$timec2)  +(coefs["agec:timec2"]*dsp$agec*dsp$timec2)
  +(coefs["timec3"]*dsp$timec3)  +(coefs["agec:timec3"]*dsp$agec*dsp$timec3)
)
str(dsp$YPar)
# note that the names of the terms would be different from all other models: agec:timec instead of timec:agec
######## Maximum Complexity ############################

(m9 <-lmer (attend ~ 
              1  + timec + timec2 + timec3 + agec 
            + agec:timec +agec:timec2 
            + (1 + timec + timec2 + timec3 | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         +(coefs["agec"]*dsp$agec)
  +(coefs["timec"]*dsp$timec)    +(coefs["timec:agec"]*dsp$agec*dsp$timec)
  +(coefs["timec2"]*dsp$timec2)  +(coefs["timec2:agec"]*dsp$agec*dsp$timec2)
  +(coefs["timec3"]*dsp$timec3)  
)
str(dsp$YPar)
########################################################
(m8 <-lmer (attend ~ 
              1  + timec + timec2 + timec3 + agec 
            + agec:timec 
            + (1 + timec + timec2 + timec3 | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         +(coefs["agec"]*dsp$agec)
  +(coefs["timec"]*dsp$timec)    +(coefs["timec:agec"]*dsp$agec*dsp$timec)
  +(coefs["timec2"]*dsp$timec2)  
  +(coefs["timec3"]*dsp$timec3)  
)
str(dsp$YPar)
########################################################
(m7 <-lmer (attend ~ 
              1  + timec + timec2 + timec3 + agec             
            + (1 + timec + timec2 + timec3 | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         +(coefs["agec"]*dsp$agec)
  +(coefs["timec"]*dsp$timec)    
  +(coefs["timec2"]*dsp$timec2)  
  +(coefs["timec3"]*dsp$timec3)  
)
str(dsp$YPar)
########################################################
(m6 <-lmer (attend ~ 
              1  + timec + timec2 + timec3            
            + (1 + timec + timec2 + timec3 | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         
  +(coefs["timec"]*dsp$timec)    
  +(coefs["timec2"]*dsp$timec2)  
  +(coefs["timec3"]*dsp$timec3)  
)
str(dsp$YPar)
########################################################
(m5 <-lmer (attend ~ 
              1  + timec + timec2 + timec3            
            + (1 + timec + timec2 | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         
  +(coefs["timec"]*dsp$timec)    
  +(coefs["timec2"]*dsp$timec2)  
  +(coefs["timec3"]*dsp$timec3)  
)
str(dsp$YPar)
########################################################
(m4 <-lmer (attend ~ 
              1  + timec + timec2            
            + (1 + timec + timec2 | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         
  +(coefs["timec"]*dsp$timec)    
  +(coefs["timec2"]*dsp$timec2)  
)
str(dsp$YPar)
########################################################
(m3 <-lmer (attend ~ 
              1  + timec + timec2            
            + (1 + timec | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         
  +(coefs["timec"]*dsp$timec)    
  +(coefs["timec2"]*dsp$timec2)  
)
str(dsp$YPar)
########################################################
(m2 <-lmer (attend ~ 
              1  + timec
            + (1 + timec | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         
  +(coefs["timec"]*dsp$timec)    
)
str(dsp$YPar)
########################################################
(m1 <-lmer (attend ~ 
              1  + timec
            + (1 | id),
            data = ds, REML=0))

dsp$YPar<-(
  (coefs["(Intercept)"])         
)
str(dsp$YPar)
########################################################
(m0 <-lmer (attend ~ 
              1 + (1 | id),
            data = ds, REML=0))
dsp$YPar<-(
  (coefs["(Intercept)"])         
)
str(dsp$YPar)
########################################################
(m00 <-lm (attend ~ 1),
 data = ds, REML=0))



