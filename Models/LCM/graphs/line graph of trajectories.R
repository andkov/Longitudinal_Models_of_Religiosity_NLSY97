# rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

require(ggplot2)
require(dplyr)
require(reshape2)

BuildLine <- function( modelName, baseSize=12 ) {
  # Traditional reading in the files
  pathdsp  <- file.path("./Models/LCM/models/datasets", paste0(modelName,"_dsp.rds"))
  dsp <- readRDS(pathdsp)

  ###############################################
  ### graph of prediction
  
  # bgColour<-gray(.95)   # background color
  indLineSz <-.08        # individual line size
  indLineAl <-.06        # individual line alpha
  
  themeLine <- ggplot2::theme_bw(base_size=baseSize) +
    ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = 12)) +
    ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40")) +
    ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40")) +
    ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80")) +
    ggplot2::theme(axis.ticks.length = grid::unit(0, "cm")) +
    ggplot2::theme(text = element_text(size =25)) #+
    # ggplot2::theme(panel.background=element_rect(fill=bgColour,colour=NA)) +
    # ggplot2::theme(legend.position=c(.95,.90),legend.direction="vertical") +
    # ggplot2::theme(legend.background = element_rect(fill=NA)) +
    # ggplot2::theme(legend.text = element_text(size = 15),legend.title.align =(-3.3))# +
    # ggplot2::theme(panel.grid = element_line(linetype = 1,size=rel(3)))
  
  ds<- dsp %>% dplyr::filter(id %in% c(1:500))
  # ds<- dsp
  # head(ds)

  p<- ggplot2::ggplot(ds, aes(x=timec, y=attend, group=id))
  # geoms
  p <- p + geom_line(aes(x=timec,y=yHat),colour="red",alpha=indLineAl,size=indLineSz, na.rm=T)
  p <- p + geom_line(aes(y=yFE), fill=NA, na.rm=T)
  # scales & coordinates
  p <- p + scale_x_continuous(breaks=c(0,1,3,5,7,9,11)) 
  p <- p + scale_y_continuous(breaks=seq(0, 8, 1)) 
  p <- p + coord_cartesian(xlim=c(-.5, 11.5), ylim=c(.5, 8.5))
  # themes, guide, and annotations
  p <- p + themeLine 
  p <- p + labs(title="How often have you attended a worship service?", x="Years Since 2000", y="Church Attendance")
  return( p )
}
# BuildLine("m5F")
# BuildLine("m7R1")
# BuildLine("m7R2")
