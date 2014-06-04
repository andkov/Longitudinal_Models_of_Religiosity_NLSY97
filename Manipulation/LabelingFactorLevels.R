#  The following script declares the factor labels to be used with  **dsL**
#
###########################################################################

#### SCALES  ####

## sample ##
sampleLevels<-  c(1,0)
sampleLabels<-  c("Cross-Sectional","Oversample")

## sex ##
sexLevels<- c(1,2,0)
sexLabels<- c("Male","Female","No Information")

## race ##
raceLevels<- c(1,2,3,4)
raceLabels<- c("Black","Hispanic","Mixed (Non-H)","Non-B/Non-H")
dsL$race<-factor(dsL$race,
                levels = raceLevels,
                labels = raceLabels)

## birth month ##
bmonthLevels<- c(1:12)
bmonthLabels<- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
dsL$bmonth<-factor(dsL$bmonth,
                 levels = bmonthLevels,
                 labels = bmonthLabels)

## church attendance ##
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

attendLabelsVars<-c("attendPR","attend")

## religious preference ##
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
relprefLabelsSmall<-c(
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

relprefLabelsVars<-c("relprefPR","relraisedPR","relpref")


## Binary True/False Scale for religous attitude items ##
truefalseLevels< - c(0,1)
truefalseLabels<-c("FALSE/less Religious",
                    "TRUE/more Religious")


truefalseLevelsVars<-c("values","todo","obeyed","decisions","pray")

## basic binary No/Yes Scale ##
noyesLevels< - c(0,1)
noyesLabels<-c("NO", "YES")

noyesLevelsVars<-c("bornagain","internet")

## How Important 5-Likert Scale ##
importantLevels<- c(1:5)
importantLevels<- c("Exrtemely",   
                "Very",   
                "Somewhat",   
                "Not very",   
                "Not at all")

importantLevelsVars<-c("faith")

## How often. 4-Likert scale ##
importantLevels<- c(1:4)
importantLevels<- c("All of the time",
                    "Most..",
                    "Some..",
                    "None of the time"))



##  hours of tv per week. Ordinal ##
varlist<-c("tv")
for(i in varlist){
  dsL[,i]<-ordered(dsL[,i],
                  levels = c(1:6),
tvhoursLabels c(
                    "less than 2",
                    "3-10",
                    "11-20",
                    "21-30",
                    "31-40",
                    "40 and higher"))
}

# How many hours per week.  Ordinal
computerLevels<- c(1:6)
computerLabels<- c( "None",
                    "less than 1",
                    "1-3",
                    "4-6",
                    "7-9",
                    "10 and more")

varlist<-c("computer")
for(i in varlist){
  dsL[,i]<-ordered(dsL[,i],
                  levels = c(1:6),
                  labels = )
}
# str(dsL)

listLevels<- c(all objects with *Levels suffix)
listLabels<- c( all objects with *Labels suffix)
  
listFactors<- c(listLevels, listLabels)  
# sample
# ds<-dsL

# ggplot(subset(ds,year==1997), aes(x=sample))+geom_bar()

# ggplot(subset(ds,year==1997), aes(x=sex))+geom_bar()

# ggplot(subset(ds,year==1997), aes(x=race))+geom_bar()

# ggplot(subset(ds,year==1997), aes(x=bmonth))+geom_bar()

# ggplot(subset(ds,year==1997), aes(x=factor(byear)))+geom_bar()

# ggplot(subset(ds,year==1997), aes(x=attendPR))+geom_bar()

# ggplot(subset(ds,year==1997), aes(x=relprefPR))+geom_bar()+coord_flip()

# ggplot(subset(ds,year==1997), aes(x=relraisedPR))+geom_bar()+coord_flip()

############################
## @knitr RenameFactors

# List of variables that must be converted to factors

