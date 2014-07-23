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
  ## Elementals
  modelsFE <- c("m0F",  "m1F",  "m2F",  "m3F",  "m4F", "m5F", "m6F", "m7F")
  otherFE <- c( "mFa",  "mFb",  "mFc",  "mFd",  "mFe")
  modelsR1 <- c("m0R1", "m1R1", "m2R1", "m3R1", "m4R1", "m5R1", "m6R1", "m7R1")
  otherR1 <- c ("mR1a", "mR1b", "mR1c", "mR1d", "mR1e")
  modelsR2 <- c(        "m1R2", "m2R2", "m3R2", "m4R2", "m5R2", "m6R2", "m7R2")
  modelsR3 <- c(                "m2R3", "m3R3", "m4R3", "m5R3", "m6R3", "m7R3")  
  modelsR4 <- c(                        "m3R4", "m4R4", "m5R4", "m6R4", "m7R4")  
  ### Compilers
  modelList1 <- c(modelsFE, modelsR1, modelsR2, modelsR3, modelsR4, otherFE, otherR1)
  modelList2 <- c("m0F", "m0R1", 
                  "m1F", "m1R1", "m1R2",
                  "m2F", "m2R1", "m2R2", 
                  "m3F", "m3R1", "m3R2", "m3R3", "m3R4",
                  "m4F", "m4R1", "m4R2", "m4R3", "m4R4",
                  "m5F", "m5R1", "m5R2", "m5R3", "m5R4",
                  "m6F", "m6R1", "m6R2", "m6R3", "m6R4",
                  "m7F", "m7R1", "m7R2", "m7R3", "m7R4",
                  "mFa", "mR1a", "mFb",  "mR1b", "mFc", "mR1c","mFd", "mR1d", "mFe", "mR1e"    
                  ) 
  mlstMap<-c(otherFE, modelsFE,modelsR1,otherR1 )
  ### Assigners
  includeModels <- otherR1
  axisModels<- mlstMap
  ###########################################################################################
  dsWide <- dsInfo  
  ds <- reshape2::melt(dsWide, id.vars=c('Coefficient'))
  ds <- plyr::rename(ds, replace=c( variable = "model"))
  ds <- ds[ds$model %in% includeModels,] # define what models will go into graph

  ds<- ds %>% 
    dplyr::filter(Coefficient %in% c( "BIC","AIC","deviance")) 
  
  ds$Highlight <- (ds$model==modelName)  
  ds$Coefficient <- factor(x=ds$Coefficient, levels=c("BIC","AIC","deviance"))

  # possible pallets
  # colorFit <- c("BIC"="#8da0cb", "AIC"="#fc8d62", "deviance"="#66c2a5")
  colorFit <- c("BIC"="blue", "AIC"="tomato", "deviance"="yellow")
  # colorFit <- c("BIC"="#bebada", "AIC"="#8dd3c7", "deviance"="#ffffb3") 
  # colorFit <- c("BIC"="#8da0cb", "AIC"="#d95f02", "deviance"="#b2df8a")
  
  # floor <- 1000 #Watchout when AIC is negative
  floor <- min(ds$value, na.rm=T)  
  longestBar <- max(ds$value, na.rm=T)  
  ceiling <- longestBar* 1.05 * sign(longestBar) #Account for cases when AIC is negative
  
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
    geom_bar(stat="identity", position="identity", alpha=.1) + #This line draw the distant skyscrapers
    geom_bar(data=ds[ds$Highlight, ], stat="identity", position="identity", alpha=.2) + #This line draw the skyskraper that pops out.
    scale_fill_manual(values=colorFit) +
    scale_x_discrete(limits=axisModels) +
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
