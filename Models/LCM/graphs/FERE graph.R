# run sequenceLCM.R if don't get some objcets

i<- "m6R3"
pathdsFERE  <- file.path("./Models/LCM/models/datasets",paste0(i,"_FERE.rds"))
m6R3_FERE<- readRDS(pathdsFERE)

ds<- m6R3_FERE
ds<- ds %>% dplyr::select( Coefficient, Estimate, Std.Error, t.value, sdRE,intVarRE, timecVarRE, timec2VarRE, sigma )
head(ds,10)
# I will enforce this order, it's importance
target <- c("(Intercept)", "timec", "timec2", "timec3", "cohort",
            "timec:cohort", "timec2:cohort", "timec3:cohort")
ds<-ds[match(target, ds$Coefficient),]
ds


ds <- melt(ds, id.vars=("Coefficient")) 
head(ds, 10)

head(ds,20)
roundingDigits<- 2
ds <- ds %>% mutate(labels= as.character(round(value,roundingDigits)))
lt<- length(target) # legnth of target
a<- rep(1,8)
b<- c(a, a*2, a*3, a*4, a*5, a*6, a*7, a*8)
ds <- ds %>% mutate(row= rep(c(1:lt),lt), col=b)
ds




###############################################################
# # playground down there
# 
# ds$Positive <- ifelse(ds$value >= 0, "Positive", "Negative") #Or see Recipe 10.8
# ds$LoadingAbs <- abs(ds$value) # Long form
# ds$LoadingPretty <- round(abs(ds$value), roundingDigits) # Long form
# # colors <- c("FALSE"="darksalmon" ,"TRUE"="lightskyblue") # The colors for negative and positve values of factor loadings for ggplot
# colorsFill <- c("Positive"="#A6CEE3" ,"Negative"="#B2DF8A") # The colors for negative and positve values of factor loadings for ggplot
# colorsColor <- c("Positive"="#00CEE3" ,"Negative"="#00DF8A") # The colors for negative and positve values of factor loadings for ggplot
# 
# p <- ggplot(ds, aes(x=variable, y=LoadingAbs, fill=Positive, color=Positive, label=LoadingPretty)) +
# p <- p + geom_bar(stat="identity") +
# p <- p +   geom_text(y=0, vjust=-.1) +
# p <- p +  scale_color_manual(values=colorsColor, guide="none") +
# p <- p +   scale_fill_manual(values=colorsFill) +
#   #   scale_fill_discrete(h=c(0,360)+15, c=100, l=65, h.start=0, direction=1, na.value="grey50") + #http://docs.ggplot2.org/0.9.3/scale_hue.html
# # p <- p +   scale_y_continuous(limits=c(0,1.2), breaks=c(.5, 1), expand=c(0,0)) +
# p <- p +   facet_grid(VariablePretty ~ .) +
# p <- p + labs(title=title, x="FFF", y="Loadings (Absolute)", fill=NULL) + 
# p <- p + theme_bw() +
# p <- p + theme(panel.grid.minor=element_blank()) + 
# #   theme(axis.label=element_text(color="gray30")) +  
# p <- p + theme(axis.text.y=element_text(color="gray50")) +   
# p <- p + theme(strip.text.y=element_text(angle=0, size=stripSize))
# 
# {
#     if( k < p ) {
#       p <- p + theme(legendmelt.position=c(1, 0), legend.justification=c(1, 0)) 
#       p <- p + theme(legend.background=element_rect(fill="gray70"))
#     }
#     else {
#       p <- p + theme(legend.position="left")
#     }
#   }
# print(p)