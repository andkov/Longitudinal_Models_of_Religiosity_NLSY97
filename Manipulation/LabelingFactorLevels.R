# #These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
# rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
# 
# 
# ############################
# ## @knitr DeclareGlobals
#  
# 
# ############################
# ## @knitr LoadPackages
# require(RODBC)
# require(plyr)
# require(ggplot2)
# 
# ############################
# ## @knitr LoadData
# pathDir<-getwd()
# pathdsL<-file.path(pathDir,"Data/Derived/dsL.csv")
# dsL<-read.csv(file=pathdsL,header=T,sep=",")
# 


dsL$sample<-factor(dsL$sample,
                   levels = c(1,0),
                   labels = c("Cross-Sectional","Oversample"))

dsL$sex<-factor(dsL$sex,
                   levels = c(1,2,0),
                   labels = c("Male","Female","No Information"))

dsL$race<-factor(dsL$race,
                levels = c(1,2,3,4),
                labels = c("Black","Hispanic","Mixed (Non-H)","Non-B/Non-H"))

dsL$bmonth<-factor(dsL$bmonth,
                 levels = c(1:12),
                 labels = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))

# Attendance scale
attendLabels<-c("attendPR","attend")
for(i in attendLabels){
dsL[,i]<-factor(dsL[,i],
                     levels = c(1:8),
                     labels = c(
                       "Never",
                       "Once or Twice",
                       "< once/month",
                       "~ once/month",
                       "~ twice/month",
                       "~ once/week",
                       "Several times/week",
                       "Everyday"))
}

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
  "Other")


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

# Religion/Denomination Name
varlist<-c("relprefPR","relraisedPR","relpref")
for (i in varlist){
  dsL[,i]<-factor(dsL[,i],
                  levels = c(1:33),
                  labels = relprefLabels33) # relprefLabelsSmall or relprefLabels33 
}

# Binary True/False Scale
varlist<-c("values","todo","obeyed","decisions","pray")
for(i in varlist){
  dsL[,i]<-factor(dsL[,i],
                  levels = c(0:1),
                  labels = c(
                    "FALSE/less Religious",
                    "TRUE/more Religious"))
}

# Binary Yes/No Scale
varlist<-c("bornagain","internet")
for(i in varlist){
  dsL[,i]<-factor(dsL[,i],
                  levels = c(0:1),
                  labels = c(
                    "No",
                    "Yes"))
}

# How Important 5-Likert Scale
varlist<-c("faith")
for(i in varlist){
  dsL[,i]<-ordered(dsL[,i],
                  levels = c(1:5),
                  labels = c(
                    "Exrtemely",
                    "Very",
                    "Somewhat",
                    "Not very",
                    "Not at all"))
}

# How often. 4-Likert scale
varlist<-c("calm","blue","happy", "depressed","nervous")
for(i in varlist){
  dsL[,i]<-ordered(dsL[,i],
                  levels = c(1:4),
                  labels = c(
                    "All of the time",
                    "Most..",
                    "Some..",
                    "None of the time"))
}

# How many hours per week. Ordinal
varlist<-c("tv")
for(i in varlist){
  dsL[,i]<-ordered(dsL[,i],
                  levels = c(1:6),
                  labels = c(
                    "<2",
                    "3-10",
                    "11-20",
                    "21-30",
                    "31-40",
                    "40>"))
}

# How many hours per week.  Ordinal
varlist<-c("computer")
for(i in varlist){
  dsL[,i]<-ordered(dsL[,i],
                  levels = c(1:6),
                  labels = c(
                    "None",
                    "< 1",
                    "1-3",
                    "4-6",
                    "7-9",
                    "10>"))
}
# str(dsL)


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

