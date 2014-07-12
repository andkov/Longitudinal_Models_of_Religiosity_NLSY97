# Models with fixed effects only
### m7F ###
call_m7F <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec  + cohort:timec2  + cohort:timec3 "
### m6F ###
call_m6F <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec  + cohort:timec2"
### m5F ###
call_m5F <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec"
### m4F ###
call_m4F <- "attend ~ 1  + timec + timec2 + timec3 + cohort "
### m3F ###
call_m3F <- "attend ~ 1  + timec + timec2 + timec3 "
### m2F ###
call_m2F <- "attend ~ 1  + timec + timec2"
### m1F ###
call_m1F <- "attend ~ 1  + timec "
### m0F ###
call_m0F <- "attend ~ 1  "

modelsF<-  c( call_m0F, call_m1F, call_m2F, call_m3F, call_m4F, call_m5F, call_m6F, call_m7F)
  mF<- c(  "m0F",  "m1F",  "m2F",  "m3F",  "m4F",  "m5F",  "m6F",  "m7F")


### mFa ###
call_mFa <- "attend ~ 1  + cohort "
### mFb ###
call_mFb <- "attend ~ 1  + timec + cohort " 
### mFc ###
call_mFc <- "attend ~ 1  + timec + cohort + cohort:timec "
### mFf ###
call_mFf <- "attend ~ 1  + timec + timec2 + cohort " 
### mFd ###
call_mFd <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec "
### mFe ###
call_mFe <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec  + cohort:timec2"


modelsFi<- c( call_mFa, call_mFb, call_mFc, call_mFf, call_mFd, call_mFe)
mFi<- c(   "mFa",   "mFb",   "mFc",   "mFf",   "mFd",   "mFe")

# Models with 1 random component
### m7R1 ###
call_m7R1 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + cohort:timec2  + cohort:timec3 + (1 | id)"
### m6R1 ###
call_m6R1 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec  + cohort:timec2  + (1 | id)"
### m5R1 ###
call_m5R1 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + (1 | id)"
### m4R1 ###
call_m4R1 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + (1 | id)"
### m3R1 ###
call_m3R1 <- "attend ~ 1  + timec + timec2 + timec3 + (1 | id)"
### m2R1 ###
call_m2R1 <- "attend ~ 1  + timec + timec2 + (1 | id)"
### m1R1 ###
call_m1R1 <- "attend ~ 1  + timec + (1 | id)"
### m0R1 ###
call_m0R1 <- "attend ~ 1 + (1 | id)"

modelsR1<-  c( call_m0R1, call_m1R1, call_m2R1, call_m3R1, call_m4R1, call_m5R1, call_m6R1, call_m7R1) 
mR1<-  c(   "m0R1",   "m1R1",   "m2R1",   "m3R1",   "m4R1",   "m5R1",   "m6R1",   "m7R1") 

### mR1a ###
call_mR1a <- "attend ~ 1  + cohort + (1 | id)"
### mR1b ###
call_mR1b <- "attend ~ 1  + timec + cohort + (1 | id)"
### mR1c ###
call_mR1c <- "attend ~ 1  + timec + cohort + cohort:timec + (1 | id)"
### mR1f ###
call_mR1f <- "attend ~ 1  + timec + timec2 + cohort + (1 | id)"
### mR1d ###
call_mR1d <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec + (1 | id)"
### mR1e ###
call_mR1e <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec  + cohort:timec2 + (1 | id)"

modelsR1i<-  c( call_mR1a, call_mR1b, call_mR1c, call_mR1f, call_mR1d, call_mR1e) 
mR1i<-  c(   "mR1a",   "mR1b",   "mR1c",   "mR1f",   "mR1d",   "mR1e") 

# Models with 2 random coefficients
### m7R2 ###
call_m7R2 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + cohort:timec2  + cohort:timec3 + (1 + timec| id)"
### m6R2 ###
call_m6R2 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec  + cohort:timec2  + (1 + timec| id)"
### m5R2 ###
call_m5R2 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + (1 + timec| id)"
### m4R2 ###
call_m4R2 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + (1 + timec| id)"
### m3R2 ###
call_m3R2 <- "attend ~ 1  + timec + timec2 + timec3 + (1 + timec| id)"
### m2R2 ###
call_m2R2 <- "attend ~ 1  + timec + timec2 + (1 + timec| id)"
### m1R2 ###
call_m1R2 <- "attend ~ 1  + timec + (1 + timec| id)"

modelsR2<-  c( call_m1R2, call_m2R2, call_m3R2, call_m4R2, call_m5R2, call_m6R2, call_m7R2)
mR2<-  c(   "m1R2",   "m2R2",   "m3R2",   "m4R2",   "m5R2",   "m6R2",   "m7R2")

### mR2b ###
call_mR2b <- "attend ~ 1  + timec + cohort +  (1 + timec| id)"
### mR2c ###
call_mR2c <- "attend ~ 1  + timec + cohort + cohort:timec +  (1 + timec| id)"
### mR2f ###
call_mR2f <- "attend ~ 1  + timec + timec2 + cohort +  (1 + timec| id)"
### mR2d ###
call_mR2d <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec +  (1 + timec| id)"
### mR2e ###
call_mR2e <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec  + cohort:timec2 +  (1 + timec| id)"

modelsR2i<-  c( call_mR2b, call_mR2c, call_mR2f, call_mR2d, call_mR2e)
mR2i<-  c(   "mR2b",   "mR2c",   "mR2f",   "mR2d",   "mR2e")
# Models with 3 random componets

### m7R3 ###
call_m7R3 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + cohort:timec2  + cohort:timec3 + (1 + timec + timec2| id)"
### m6R3 ###
call_m6R3 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec  + cohort:timec2  + (1 + timec + timec2| id)"
### m5R3 ###
call_m5R3 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + (1 + timec + timec2| id)"
### m4R3 ###
call_m4R3 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + (1 + timec + timec2| id)"
### m3R3 ###
call_m3R3 <- "attend ~ 1  + timec + timec2 + timec3 + (1 + timec + timec2| id)"
### m2R3 ###
call_m2R3 <- "attend ~ 1  + timec + timec2 + (1 + timec + timec2| id)"

modelsR3<-  c( call_m2R3, call_m3R3, call_m4R3, call_m5R3, call_m6R3, call_m7R3)
mR3<-  c(   "m2R3",   "m3R3",   "m4R3",   "m5R3",   "m6R3",   "m7R3")              
               
### mR3f ###
call_mR3f <- "attend ~ 1  + timec + timec2 + cohort +  (1 + timec + timec2| id)"
### mR3d ###
call_mR3d <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec +  (1 + timec + timec2| id)"
### mR3e ###
call_mR3e <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec  + cohort:timec2 +  (1 + timec + timec2| id)"

modelsR3i<-  c( call_mR3f, call_mR3d, call_mR3e)
mR3i<-  c(   "mR3f",   "mR3d",   "mR3e")
# Models with 3 random componets


### m7R4 ###
call_m7R4 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + cohort:timec2  + cohort:timec3 + (1 + timec + timec2 + timec3| id)"
### m6R4 ###
call_m6R4 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec  + cohort:timec2  + (1 + timec + timec2 + timec3| id)"
### m5R4 ###
call_m5R4 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + (1 + timec + timec2 + timec3| id)"
### m4R4 ###
call_m4R4 <- "attend ~ 1  + timec + timec2 + timec3 + cohort + (1 + timec + timec2 + timec3| id)"
### m3R4 ###
call_m3R4 <- "attend ~ 1  + timec + timec2 + timec3 + (1 + timec + timec2 + timec3| id)"

modelsR4<-  c( call_m3R4, call_m4R4, call_m5R4, call_m6R4, call_m7R4)
mR4<- c(   "m3R4",   "m4R4",   "m5R4",   "m6R4",   "m7R4")              
               
modelNames<- c( modelsF, modelsFi, modelsR1, modelsR1i, modelsR2, modelsR2i, modelsR3, modelsR3i, modelsR4)
modelNamesLabels<- c(   mF, mFi, mR1, mR1i, mR2, mR2i, mR3, mR3i, mR4)


# Groups of modelsL


