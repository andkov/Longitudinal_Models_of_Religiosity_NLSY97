#  The following script declares the factor labels to be used with  **dsL**
#
###########################################################################
dsL<-readRDS("./Data/Derived/dsL.rds")
dsLF<- dsL
#### SCALES  ####

## sample ###################################################### sample ####
sampleLevels<-  c(1,0)
sampleLabels<-  c("Cross-Sectional",
                  "Oversample")
varlist<-c("sample")
for(i in varlist){
  dsLF[,paste0(i,"F")]<-ordered(dsLF[,i],
                   levels = sampleLevels,
                   labels = sampleLabels)
}
## sex ###################################################################
sexLevels<- c(1,2,0)
sexLabels<- c("Male","Female","No Information")

varlist<-c("sex")
for(i in varlist){
  dsLF[,paste0(i,"F")]<-ordered(dsLF[,i],
                   levels = sexLevels,
                   labels = sexLabels)
}
## race ##################################################################
raceLevels<- c(1,2,3,4)
raceLabels<- c("Black","Hispanic","Mixed (Non-H)","Non-B/Non-H")
dsLF$race<-factor(dsLF$race,
                levels = raceLevels,
                labels = raceLabels)

varlist<-c("race")
for(i in varlist){
  dsLF[,paste0(i,"F")]<-ordered(dsLF[,i],
                               levels = raceLevels,
                               labels = raceLabels)
}
## birth month ###########################################################
bmonthLevels<- c(1:12)
bmonthLabels<- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

varlist<-c("bmonth")
for(i in varlist){
  dsLF[,paste0(i,"F")]<-ordered(dsLF[,i],
                               levels = bmonthLevels,
                               labels = bmonthLabels)
}

## church attendance #####################################################
attendLevels<- c(1:8)
attendLabelsShort<-c("Never",
                    "Once or Twice",
                    "< once/month",
                    "~ once/month",
                    "~ twice/month",
                    "~ once/week",
                    "Several times/week",
                    "Everyday")
attendLabels<-c( "Never",
                    "Once or Twice",
                    "Less than once/month",
                    "About once/month",
                    "About twice/month",
                    "About once/week",
                    "Several times/week",
                    "Everyday")
varlist<- c("attendPR","attend")
for(i in varlist){
  dsLF[,paste0(i,"F")]<-ordered(dsLF[,i],
                               levels = attendLevels,
                               labels = attendLabels)
}
## religious preference ##################################################
relprefLevels<- c(1:33)
relprefLabels33<-c(
  "Catholic",
  "Baptist",
  "Methodist",
  "Lutheran",
  "Presbyterian",
  "Episcopal",
  "C.Christ",
  "D.Christ",
  "Reformed",
  "Holiness",
  "Pentecostal",
  "Non-Denom",
  "OtherProt",
  "JewishOrth",
  "JewishCons",
  "JewishRef",
  "JewishOth",
  "Mormon",
  "EastOrth",
  "Unitarian",
  "Muslim",
  "Hindu",
  "NATribal",
  "Agnostic",
  "Atheist",
  "PersPhil",
  "Bah'ai",
  "Myth",
  "Satanic",
  "Witchcraft",
  "Scientology",
  "Sikh",
  "Other"
  )
# some responses are combined for simplicity #
relprefLabels19<-c(
  "Catholic",
  "Baptic",
  "Methodist",
  "Lutheran",
  "Presbyterian",
  "Episcopal",
  "C.Christ",
  "D.Christ",
  "Reformed",
  "Holiness",
  "Pentecostal",
  "Non-Denom",
  "OtherProt",
  "Jewish",
  "Jewish",
  "Jewish",
  "Jewish",
  "Mormon",
  "EastOrth",
  "Unitarian",
  "Muslim",
  "Other",
  "Other",
  "Other",
  "Other",
  "Other",
  "Other",
  "Other",
  "Other",
  "Other",
  "Other",
  "Other",
  "Other"
)

varlist <- c("relprefPR","relraisedPR","relpref")
for(i in varlist){
  dsLF[,paste0(i,"F")]<-ordered(dsLF[,i],
                               levels = relprefLevels,
                               labels = relprefLabels33)
}


## Binary True/False Scale for religous attitude items ###################
truefalseLevels<- c(0,1)
truefalseLabels<- c("FALSE/less Religious",
                    "TRUE/more Religious")

varlist <- c("values","todo","obeyed","decisions","pray")
for(i in varlist){
  dsLF[,paste0(i,"F")]<-ordered(dsLF[,i],
                               levels = truefalseLevels,
                               labels = truefalseLabels)
}

## basic binary No/Yes Scale #############################################
noyesLevels<- c(0,1)
noyesLabels<- c("NO", "YES")

varlist <- c("bornagain","internet")
for(i in varlist){
  dsLF[,paste0(i,"F")]<- ordered(dsLF[,i],
                               levels = noyesLevels,
                               labels = noyesLabels)
}
## How Important 5-Likert Scale ##########################################
importantLevels<- c(1:5)
importantLevels<- c("Exrtemely",   
                "Very",   
                "Somewhat",   
                "Not very",   
                "Not at all")

varlist <- c("faith")
for(i in varlist){
  dsLF[,paste0(i,"F")]<- ordered(dsLF[,i],
                               levels = importantLevels,
                               labels = importantLevels)
}


## How often. 4-Likert scale ##########################################
howoftenLevels<- c(1:4)
howoftenLevels<- c("All of the time",
                    "Most..",
                    "Some..",
                    "None of the time")

varlist <- c("calm", "blue", "happy", "depressed","nervous")
for(i in varlist){
  dsLF[,paste0(i,"F")]<-ordered(dsLF[,i],
                               levels = howoftenLevels,
                               labels = howoftenLevels)
}


##  hours of tv per week. Ordinal ##########################################
hpweekLevels<- c(1:6)
hpweekLabels<- c("less than 2",
                "3-10",
                "11-20",
                "21-30",
                "31-40",
                "40 and higher")
varlist <- c("tv")
for(i in varlist){
  dsLF[,paste0(i,"F")]<- ordered(dsLF[,i],
                               levels = hpweekLevels,
                               labels = hpweekLabels)
}
# How many hours per week.  Ordinal ########################################
computerLevels<- c(1:6)
computerLabels<- c( "None",
                    "less than 1",
                    "1-3",
                    "4-6",
                    "7-9",
                    "10 and more")
varlist<- c("computer")
for(i in varlist){
  dsLF[,paste0(i,"F")]<- ordered(dsLF[,i],
                               levels = computerLevels,
                               labels = computerLabels)
}
# Currently have internet? ########################################
internetLevels<- c(0,1)
internetLabels<- c( "No",
                    "Yes")
varlist<- c("internet")
for(i in varlist){
  dsLF[,paste0(i,"F")]<- ordered(dsLF[,i],
                                 levels = internetLevels,
                                 labels = internetLabels)
}
#############################################################################

varlist <- c("id","agemon", "ageyear","byear","year","famrel")
for (i in varlist){
  dsLF[,paste0(i,"F")]<- factor(dsLF[,i])
}

# this must match the definition of "dsL_order" object given in "Derive_dsL_from_Extract.R"
dsL_orderF<- c("sampleF"  ,"idF"  ,"sexF"	,"raceF"	,"bmonthF"	,"byearF"	,"attendPRF"	,"relprefPRF"	,"relraisedPRF"	,"yearF","agemonF"	,"ageyearF"	,"famrelF"	,"attendF"	,"valuesF"	,"todoF"	,"obeyedF"	,"prayF"	,"decisionsF"	,"relprefF"	,"bornagainF"	,"faithF"	,"calmF"	,"blueF"	,"happyF"	,"depressedF"	,"nervousF"	,"tvF"	,"computerF"	,"internetF")
dsLF<- dsLF[,dsL_orderF]
dsL<- cbind(dsL,dsLF)



