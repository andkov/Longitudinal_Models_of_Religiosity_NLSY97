ds <- read.table(header = TRUE, text ="
        Intercept        timec       timec2        timec3
    1.737039978  0.092280863 -0.041651389  2.682618e-03
        0.092280863  0.627165049 -0.120993155  6.208261e-03
      -0.041651389 -0.120993155  0.026098510 -1.416538e-03
       0.002682618  0.006208261 -0.001416538  7.949634e-05
")

ds<- m6R3_FERE
ds<- ds %>% dplyr::select( Coefficient, Estimate, Std.Error, t.value,varRE, sdRE,intVarRE, timecVarRE, timec2VarRE, sigma )
head(ds,10)

library(ggplot2)
library(reshape2)       # for melt(...)
library(RColorBrewer)   # for brewer.pal(...)
roundingDigits<- 2
ds <- melt(ds, id.vars=("Coefficient")) 
ds
ds$Positive <- ifelse(ds$value >= 0, "Positive", "Negative") #Or see Recipe 10.8
ds$LoadingAbs <- abs(ds$value) # Long form
ds$LoadingPretty <- round(abs(ds$value), roundingDigits) # Long form
# colors <- c("FALSE"="darksalmon" ,"TRUE"="lightskyblue") # The colors for negative and positve values of factor loadings for ggplot
colorsFill <- c("Positive"="#A6CEE3" ,"Negative"="#B2DF8A") # The colors for negative and positve values of factor loadings for ggplot
colorsColor <- c("Positive"="#00CEE3" ,"Negative"="#00DF8A") # The colors for negative and positve values of factor loadings for ggplot

p <- ggplot(ds, aes(x=variable, y=LoadingAbs, fill=Positive, color=Positive, label=LoadingPretty)) +
p <- p + geom_bar(stat="identity") +
p <- p +   geom_text(y=0, vjust=-.1) +
p <- p +  scale_color_manual(values=colorsColor, guide="none") +
p <- p +   scale_fill_manual(values=colorsFill) +
  #   scale_fill_discrete(h=c(0,360)+15, c=100, l=65, h.start=0, direction=1, na.value="grey50") + #http://docs.ggplot2.org/0.9.3/scale_hue.html
# p <- p +   scale_y_continuous(limits=c(0,1.2), breaks=c(.5, 1), expand=c(0,0)) +
p <- p +   facet_grid(VariablePretty ~ .) +
p <- p + labs(title=title, x="FFF", y="Loadings (Absolute)", fill=NULL) + 
p <- p + theme_bw() +
p <- p + theme(panel.grid.minor=element_blank()) + 
#   theme(axis.label=element_text(color="gray30")) +  
p <- p + theme(axis.text.y=element_text(color="gray50")) +   
p <- p + theme(strip.text.y=element_text(angle=0, size=stripSize))

{
    if( k < p ) {
      p <- p + theme(legendmelt.position=c(1, 0), legend.justification=c(1, 0)) 
      p <- p + theme(legend.background=element_rect(fill="gray70"))
    }
    else {
      p <- p + theme(legend.position="left")
    }
  }
print(p)