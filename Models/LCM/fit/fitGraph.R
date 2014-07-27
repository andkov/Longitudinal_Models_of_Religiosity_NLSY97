modelName<- "m0R3"  
# Read in different REDS files and join them all together
pathDataDirectory <- file.path("./Models/LCM/models/datasets")
# filenamePattern <- ".+\\.rds" #All RDS files
filenamePattern <- "m.{1,}Info\\.rds" #All RDS files

retrievedFilenames <- list.files(path=pathDataDirectory, pattern=filenamePattern)
filePaths <- file.path(pathDataDirectory, retrievedFilenames)

dsInfo <- readRDS(filePaths[1])
for( i in 1:length(filePaths) ) {
  # To debug, change the '6' to some number to isolate the problem: for( i in 2:6 ) {
  # message("About to read", filePaths[i], "\\")
  dsInfoSingle <- readRDS(filePaths[i])
  dsInfo <- plyr::join(x=dsInfo, y=dsInfoSingle, by="Coefficient", type="left", match="all")
  rm(dsInfoSingle)
}


# take data produced by model estimation
dsWide <- dsInfo  
ds <- reshape2::melt(dsWide, id.vars=c('Coefficient'))
ds <- plyr::rename(ds, replace=c( variable = "model"))
str(ds)
ds<- ds %>% 
  dplyr::filter(Coefficient %in% c( "BIC","AIC","deviance")) 
ds<- ds[!(ds$model %in% excludeModels),] # exclude models from dataset
ds$Highlight <- (ds$model==modelName)  
ds$Coefficient <- factor(x=ds$Coefficient, levels=c("BIC","AIC","deviance"))
ds$pretty<- format(round(ds$value,2), nsmall = 1,big.mark = ",")


# possible pallets

# colorFit <- c("BIC"="blue", "AIC"="red", "deviance"="grey")
colorFit <- c("BIC"="#8da0cb", "AIC"="#fc8d62", "deviance"="#66c2a5") # Colorbrewer, 3 cat, qualit, colorblind and print friendly


# floor <- 1000 #Watchout when AIC is negative
floor <- min(ds$value, na.rm=T)  
longestBar <- max(ds$value, na.rm=T)  
barHeight <- abs(longestBar - floor)
ceiling <- longestBar + barHeight * .2 * sign(longestBar)  #Account for cases when AIC is negative

barTheme <- theme_bw() +
  theme(axis.text = element_text(colour="gray40", size=15)) +
  theme(axis.text.x = element_text(angle=0, vjust = .5)) +
  theme(axis.title = element_text(colour="gray40")) +
  theme(panel.border = element_rect(colour="gray80")) +
  theme(panel.grid.major.x = element_blank()) +
  # theme(axis.ticks = element_line(colour="gray80")) +
  theme(axis.ticks.length = grid::unit(0, "cm")) +
  theme(legend.position=c(.85,.8), legend.justification=c(0,0)) +
  # theme(legend.background = element_rect(fill = '#99999933')) +
  theme(legend.background = element_rect(fill = NA)) +
  theme(legend.text = element_text(colour = 'gray40'))

# g <- ggplot2::ggplot(ds, aes(x= reorder(model, value), y=value, fill= Coefficient, group=model)) +
g <- ggplot2::ggplot(ds, aes(x= reorder(model, value), y=value, color= Coefficient, fill=Coefficient)) +
  geom_bar(aes(fill=Coefficient),stat="identity", position="dodge", alpha=.5) + #This line draw the distant skyscrapers
  #   geom_bar(data=ds[ds$Highlight, ], stat="identity", position="identity", alpha=.2) + #This line draw the skyskraper that pops out.
  
  scale_fill_manual(values=colorFit) +
  scale_color_manual(values=colorFit) +  
  scale_x_discrete(limits=axisModels) +
  scale_y_continuous(label=scales::comma) +
  
  #Andrey:  almost never use `scale_zzzz()` to zoom.  It essentially deletes variables from the dataset, which can affect loess. p<- p + scale_y_continuous( limits = c(80000, 110000))
  geom_text(aes(label=pretty), hjust=0, angle=90, position=position_dodge(width=1)) +
  coord_cartesian(ylim=c(floor, ceiling)) + 
  guides(fill=guide_legend(title=NULL), color=FALSE) + 
  barTheme +
  labs(x=NULL, y="Misfit")

# g
