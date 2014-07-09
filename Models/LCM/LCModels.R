### m7R ###
call_m7R <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + cohort:timec2  + cohort:timec3 + (1 | id)"
### m6R ###
call_m6R <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec  + cohort:timec2  + (1 | id)"
### m5R ###
call_m5R <- "attend ~ 1  + timec + timec2 + timec3 + cohort + cohort:timec + (1 | id)"
### m4R ###
call_m4R <- "attend ~ 1  + timec + timec2 + timec3 + cohort + (1 | id)"
### m3R ###
call_m3R <- "attend ~ 1  + timec + timec2 + timec3 + (1 | id)"
### m2R ###
call_m2R <- "attend ~ 1  + timec + timec2 + (1 | id)"
### m1R ###
call_m1R <- "attend ~ 1  + timec + (1 | id)"
### m0R ###
call_m0R <- "attend ~ 1 + (1 | id)"

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
  "m0R", "m1R", "m2R", "m3R", "m4R", "m5R", "m6R", "m7R",
  "m0F", "m1F", "m2F", "m3F", "m4F", "m5F", "m6F", "m7F",
  "mRa", "mRb", "mRc", "mRd","mRe",
  "mFa", "mFb", "mFc", "mFd","mFe")

modelNames<- c(
  call_m0R, call_m1R, call_m2R, call_m3R, call_m4R, call_m5R, call_m6R, call_m7R,
  call_m0F, call_m1F, call_m2F, call_m3F, call_m4F, call_m5F, call_m6F, call_m7F,
  call_mRa, call_mRb, call_mRc, call_mRd,call_mRe,
  call_mFa, call_mFb, call_mFc, call_mFd,call_mFe)
names(modelNames)<- modelNamesLabels

