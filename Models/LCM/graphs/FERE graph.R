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
  
  columnNamesWide <- c("Estimate", "Std.Error", "t.value", "sdRE", "intVarRE", "timecVarRE", "timec2VarRE", "timec3VarRE", "sigma")
  columnNamesWideWithCoefficient <- c("Coefficient", columnNamesWide)
  dsWide2 <- dsWide[, columnNamesWideWithCoefficient]

  # I will enforce this order, it's important
  target <- c("(Intercept)", "timec", "timec2", "timec3", "cohort", "timec:cohort", "timec2:cohort", "timec3:cohort")
  dsWide2<-dsWide2[match(target, dsWide2$Coefficient), ]

  ds <- melt(dsWide2, id.vars=("Coefficient"), value.name="value") 

  ds$label <- sprintf("% .2f", ds$value) #format(x=round(ds$value,2), trim=FALSE)
  ds$label[is.na(ds$value)] <- ""
  
  uniqueCoefficientCount <- 8
  uniqueVariableCount <- length(unique(ds$variable))
  ds$row <- rep(x=seq_len(uniqueCoefficientCount), times=uniqueVariableCount)
  ds$col <- rep(x=seq_len(uniqueVariableCount), each=uniqueCoefficientCount)
  
  dsHeaderColumn <- data.frame(label=columnNamesWide, row=0, col=seq_len(uniqueVariableCount))
  dsHeaderRow <- data.frame(label=target, row=seq_along(target), col=0)
  
  ds <- plyr::rbind.fill(ds, dsHeaderColumn)
  ds <- plyr::rbind.fill(ds, dsHeaderRow)
  
  ds$borderCode <- factor(ifelse(!is.na(ds$value), borderCode, 99))
  ds$fillCode <- factor(ifelse(!is.na(ds$value), fillCode, 99))
    
  g <- ggplot(ds, aes(x=col,y=-row, label=label)) +
    geom_tile(aes(color=borderCode, fill=fillCode)) +
    geom_text(na.rm=T, color="black", hjust=.5, vjust=.5, size=5, family="mono") +
    scale_color_manual(values=paletteColor) +
    scale_fill_manual(values=paletteFill) +
    emptyTheme +
    theme(legend.position="none")
  
  # ggsave(filename="./Models/LCM/graphs/equationTiles.png", plot=g)
  return( g )
}