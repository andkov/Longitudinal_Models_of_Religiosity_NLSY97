# rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

require(ggplot2)
require(dplyr)
require(reshape2)

BuildFERE <- function( modelName, dsWide ) {
  
  emptyTheme <- ggplot2::theme_minimal() +
    theme(axis.text = element_blank()) +
    theme(axis.title = element_blank()) +
    theme(panel.grid = element_blank()) +
    theme(panel.border = element_blank()) +
    theme(axis.ticks.length = grid::unit(0, "cm"))
  
  paletteColor <- c("0"=NA, "2"="#7ebea5", "3"="tomato","99"=NA) #http://colrd.com/image-dna/23557/
  paletteFill <- c("0"=NA, "1"="#1c5f83", "3"="tomato", "99"=NA)
  
  borderCode <- c(0,0,0,0,2,2,2,2,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,99,99,99,99,0,0,0,0,99,99,99,99,0,0,0,0,99,99,99,99,0,0,0,0,99,99,99,99,3,99,99,99,99,99,99,99)
  fillCode <- c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,3,3,3,3,99,99,99,99,3,3,3,3,99,99,99,99,3,3,3,3,99,99,99,99,3,3,3,3,99,99,99,99,3,99,99,99,99,99,99,99)
  
  
  # run sequenceLCM.R if don't get some objcets
  #   modelName <- "m6R3"
  # pathdsFERE  <- file.path("./Models/LCM/models/datasets", paste0(modelName, "_FERE.rds"))
  # m6R3_FERE<- readRDS(pathdsFERE)
  # 
  # dsWide<- m6R3_FERE

  #dsWide <- dsWide %>% dplyr::select( Coefficient, Estimate, Std.Error, t.value, sdRE,intVarRE, timecVarRE, timec2VarRE, sigma )
  dsWide <- dsWide[, c("Coefficient", "Estimate", "Std.Error", "t.value", "sdRE", "intVarRE", "timecVarRE", "timec2VarRE", "timec3VarRE", "sigma")]

  # head(dsWide,10)
  # I will enforce this order, it's important
  target <- c("(Intercept)", "timec", "timec2", "timec3", "cohort", "timec:cohort", "timec2:cohort", "timec3:cohort")
  dsWide<-dsWide[match(target, dsWide$Coefficient), ]
  # dsWide
  
  
  ds <- melt(dsWide, id.vars=("Coefficient"), value.name="value") 
  # head(ds, 10)
  
  # roundingDigits<- 2
  # ds <- ds %>% mutate(label= as.character(round(value,roundingDigits))) #I don't think there's a need to use mutate here, but some people do.
  ds$label <- sprintf("% .2f", ds$value) #format(x=round(ds$value,roundingDigits), trim=FALSE)
  ds$label[is.na(ds$value)] <- ""
  ds$borderCode <- factor(ifelse(!is.na(ds$value), borderCode, 99))
  ds$fillCode <- factor(ifelse(!is.na(ds$value), fillCode, 99))
  
  uniqueCoefficientCount <- 8
  uniqueVariableCount <- length(unique(ds$variable))
  ds$row <- rep(x=seq_len(uniqueCoefficientCount), times=uniqueVariableCount)
  ds$col <- rep(x=seq_len(uniqueVariableCount), each=uniqueCoefficientCount)
    
  # ggplot(ds, aes(x=col, xmin=col-.5, xmax=col+.5, y=-row, ymin=-row-.5, ymax=-row+.5, label=label)) +
  #   geom_rect(aes(color=borderCode, fill=fillCode)) +
  g <- ggplot(ds, aes(x=col,y=-row, label=label)) +
    geom_tile(aes(color=borderCode, fill=fillCode)) +
    geom_text(na.rm=T, color="black", hjust=.5, vjust=.5, size=5, family="mono") +
    scale_color_manual(values=paletteColor) +
    scale_fill_manual(values=paletteFill) +
    emptyTheme +
    theme(legend.position="none")
  # ggsave(filename="./Models/LCM/graphs/equationTiles.png", plot=last_plot())
  return( g )
}