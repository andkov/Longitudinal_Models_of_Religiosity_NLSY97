# rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
require(ggplot2)
require(dplyr)
require(reshape2)

BuildBar <- function( modelName = NA ) {
  
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
  
  mF<-   c("m0F",  "m1F",  "m2F",  "m3F",  "m4F",    "m5F",    "m6F",    "m7F")
  mFi<-  c("mFa",  "mFb",  "mFc",  "mFf",  "mFd",    "mFe")
  mR1<-  c("m0R1", "m1R1", "m2R1", "m3R1", "m4R1",   "m5R1",   "m6R1",   "m7R1") 
  mR1i<- c("mR1a", "mR1b", "mR1c", "mR1f", "mR1d",   "mR1e") 
  mR2<-  c("m1R2", "m2R2", "m3R2", "m4R2", "m5R2",   "m6R2",   "m7R2")
  mR2i<- c("mR2b", "mR2c", "mR2f", "mR2d", "mR2e")
  mR3<-  c("m2R3", "m3R3", "m4R3", "m5R3", "m6R3",   "m7R3")              
  mR3i<- c("mR3f", "mR3d", "mR3e")
  mR4<-  c("m3R4", "m4R4", "m5R4", "m6R4", "m7R4")   
  
  ## Composite lists of models
  mOrder1 <- c(mF, mFi, mR1, mR1i, mR2, mR2i, mR3, mR3i, mR4)

  excludeModels <- NA # c(mF, mFi)
  axisModels  <- c(mOrder1)
  ######################################
  dsWide <- dsInfo  
  ds <- reshape2::melt(dsWide, id.vars=c('Coefficient'))
  ds <- plyr::rename(ds, replace=c( variable = "model"))

  ds<- ds %>% 
    dplyr::filter(Coefficient %in% c( "BIC","AIC","deviance")) 
  ds<- ds[!(ds$model %in% excludeModels),] # exclude models from dataset
  ds$Highlight <- (ds$model==modelName)  
  ds$Coefficient <- factor(x=ds$Coefficient, levels=c("BIC"="BIC","AIC"="AIC","deviance"="deviance"))

  
  # possible pallets
  # colorFit <- c("BIC"="#8da0cb", "AIC"="#fc8d62", "deviance"="#66c2a5")
  colorFit <- c("BIC"="plum", "AIC"="goldenrod", "deviance"="lavender")
  # colorFit <- c("BIC"="#bebada", "AIC"="#8dd3c7", "deviance"="#ffffb3") 
  # colorFit <- c("BIC"="#8da0cb", "AIC"="#d95f02", "deviance"="#b2df8a")
  
  # floor <- 1000 #Watchout when AIC is negative
  floor <- min(ds$value, na.rm=T)  
  longestBar <- max(ds$value, na.rm=T)  
  barHeight <- abs(longestBar - floor)
  ceiling <- longestBar + barHeight * .05 * sign(longestBar)  #Account for cases when AIC is negative
  
  barTheme <- theme_bw() +
    theme(axis.text = element_text(colour="gray40")) +
    theme(axis.text.x = element_text(angle=90, vjust = .5)) +
    theme(axis.title = element_text(colour="gray40")) +
    theme(panel.border = element_rect(colour="gray80")) +
    theme(panel.grid.major.x = element_blank()) +
    # theme(axis.ticks = element_line(colour="gray80")) +
    theme(axis.ticks.length = grid::unit(0, "cm")) +
    theme(legend.position=c(0,0), legend.justification=c(0,0)) +
    # theme(legend.background = element_rect(fill = '#99999933')) +
    theme(legend.background = element_rect(fill = NA)) +
    theme(legend.text = element_text(colour = 'gray40'))
  
  g <- ggplot2::ggplot(ds, aes(x= reorder(model, value), y=value, fill= Coefficient, group=model)) +
    geom_bar(stat="identity", position="identity", alpha=1) + #This line draw the distant skyscrapers
    geom_bar(data=ds[ds$Highlight, ], stat="identity", position="identity", alpha=.2) + #This line draw the skyskraper that pops out.
    scale_fill_manual(values=colorFit) +
    scale_x_discrete(limits=mOrder1) +
    scale_y_continuous(label=scales::comma) +
    #Andrey:  almost never use `scale_zzzz()` to zoom.  It essentially deletes variables from the dataset, which can affect loess. p<- p + scale_y_continuous( limits = c(80000, 110000))
    coord_cartesian(ylim=c(floor, ceiling)) + 
    guides(fill=guide_legend(title=NULL)) + 
    barTheme +
    labs(x=NULL, y="Misfit")
  
  return( g )
}
# BuildBar()
# BuildBar(modelName="m5F")
