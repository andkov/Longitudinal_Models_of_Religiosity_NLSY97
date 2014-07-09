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
### m2R4 ###
call_m2R4 <- "attend ~ 1  + timec + timec2 + (1 + timec + timec2 + timec3| id)"
### m1R4 ###
call_m1R4 <- "attend ~ 1  + timec + (1 + timec + timec2 + timec3| id)"
### m0R4 ###
call_m0R4 <- "attend ~ 1 + (1 + timec + timec2 + timec3| id)"


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
### m1R3 ###
call_m1R3 <- "attend ~ 1  + timec + (1 + timec + timec2| id)"
### m0R3 ###
call_m0R3 <- "attend ~ 1 + (1 + timec + timec2| id)"

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
### m0R2 ###
call_m0R2 <- "attend ~ 1 + (1 + timec| id)"


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
call_m0F <- "attend ~ 1  + timec "

### mRa ###
call_mRa <- "attend ~ 1  + timec + (1 | id)"
### mRb ###
call_mRb <- "attend ~ 1  + timec + cohort + (1 | id)"
### mRc ###
call_mRc <- "attend ~ 1  + timec + cohort + cohort:timec + (1 | id)"
### mRd ###
call_mRd <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec + (1 | id)"
### mRe ###
call_mRe <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec  + cohort:timec2 + (1 | id)"

### mFa ###
call_mFa <- "attend ~ 1  + timec "
### mFb ###
call_mFb <- "attend ~ 1  + timec + cohort " 
### mFc ###
call_mFc <- "attend ~ 1  + timec + cohort + cohort:timec "
### mFd ###
call_mFd <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec "
### mFe ###
call_mFe <- "attend ~ 1  + timec + timec2 + cohort + cohort:timec  + cohort:timec2"


modelNamesLabels<- c(
  "m0R4", "m1R4", "m2R4", "m3R4", "m4R4", "m5R4", "m6R4", "m7R4",
  "m0R3", "m1R3", "m2R3", "m3R3", "m4R3", "m5R3", "m6R3", "m7R3",
  "m0R2", "m1R2", "m2R2", "m3R2", "m4R2", "m5R2", "m6R2", "m7R2",
  "m0R1", "m1R1", "m2R1", "m3R1", "m4R1", "m5R1", "m6R1", "m7R1",
  "m0F", "m1F", "m2F", "m3F", "m4F", "m5F", "m6F", "m7F",
  "mRa", "mRb", "mRc", "mRd","mRe",
  "mFa", "mFb", "mFc", "mFd","mFe")

modelNames<- c(
  call_m0R4, call_m1R4, call_m2R4, call_m3R4, call_m4R4, call_m5R4, call_m6R4, call_m7R4,
  call_m0R3, call_m1R3, call_m2R3, call_m3R3, call_m4R3, call_m5R3, call_m6R3, call_m7R3,
  call_m0R2, call_m1R2, call_m2R2, call_m3R2, call_m4R2, call_m5R2, call_m6R2, call_m7R2,
  call_m0R1, call_m1R1, call_m2R1, call_m3R1, call_m4R1, call_m5R1, call_m6R1, call_m7R1,
  call_m0F, call_m1F, call_m2F, call_m3F, call_m4F, call_m5F, call_m6F, call_m7F,
  call_mRa, call_mRb, call_mRc, call_mRd,call_mRe,
  call_mFa, call_mFb, call_mFc, call_mFd,call_mFe)
names(modelNames)<- modelNamesLabels

