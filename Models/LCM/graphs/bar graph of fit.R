modelsFE <- c(  "m0F", "m1F", "m2F", "m3F", "m4F", "m5F", "m6F", "m7F",
                "mFa", "mFb", "mFc", "mFd","mFe")
modelsR1 <- c("m0R1", "m1R1", "m2R1", "m3R1", "m4R1", "m5R1", "m6R1", "m7R1",
              "mR1a", "mR1b", "mR1c", "mR1d","mR1e")
modelsR2 <- c(        "m1R2", "m2R2", "m3R2", "m4R2", "m5R2", "m6R2", "m7R2")

modelsR3 <- c(                "m2R3", "m3R3", "m4R3", "m5R3", "m6R3", "m7R3")

modelsR4 <- c(                        "m3R4", "m4R4", "m5R4", "m6R4", "m7R4")

allModels<- c(modelsFE, modelsR1, modelsR2, modelsR3, modelsR4)
a<- c( c(1:length(allModels)), allModels)

a<- c(1:3)
b<- c("a","b","c")
d<- c(a,b)
### graph of comparative fit
ds<-dsInfo
head(ds)
ds<- reshape2::melt(ds,id.vars=c('Coefficient'))
ds<-plyr::rename(ds, replace = c( variable = "model"))
head(ds,9)
ds<- ds %>% 
  dplyr::filter(Coefficient %in% c("AIC", "BIC","deviance")) 
head(ds,6)

# 
# ds$model<- ordered(allModels)
# ds$Coefficient<- ordered= c("BIC", "AIC","deviance")



head(ds,9)
# possible pallets
colorFit1 <- c("BIC"="#8da0cb", "AIC"="#fc8d62", "deviance"="#66c2a5")

p <- ggplot2::ggplot(ds, aes(x= reorder(model, value), y=value, fill= Coefficient, group=model))
p <- p + geom_bar( stat="identity", position="dodge")
                  
p<- p + scale_fill_manual(values=colorFit1)
p<- p + theme(axis.text.x = element_text(angle = 45, hjust = 1))
p

# p <- ggplot2::ggplot(ds, aes(x=model, y=value, fill= Coefficient, group=model))
# p <- p + geom_bar( data= dplyr::filter(ds,Coefficient=="BIC"),stat="identity", 
#                    alpha=1 )
# p <- p + geom_bar( data= dplyr::filter(ds,Coefficient=="AIC"),stat="identity", 
#                    alpha=1)
# p <- p + geom_bar( data= dplyr::filter(ds,Coefficient=="deviance"),stat="identity", 
#                    alpha=1)
# p<- p + scale_fill_manual(values=colorFit1)
# p<- p + theme(axis.text.x = element_text(angle = 45, hjust = 1))
# p

str(ds)



breadth_data <- read.table(textConnection("Stakeholder  Value
                                          'Grantseekers'  0.90
                                          'Donors'    0.89
                                          'Community' 0.55
                                          'Hurricane Relief Fund' 0.24
                                          'Media' 0.19
                                          'Employment Seekers'    0.12
                                          'Affiliates'    0.10
                                          'Youth' 0.09
                                          'Women' 0.02
                                          'Former Board Members'  0.01"), header=TRUE)

breadth_data


c <- ggplot(breadth_data, aes(x=Stakeholder, y=Value))
c + geom_bar(stat="identity") + coord_flip() + scale_y_continuous('') + scale_x_discrete('')



breadth_data <- transform(breadth_data, 
                          Stakeholder = reorder(Stakeholder, Value))



















