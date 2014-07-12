# rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

require(ggplot2)
require(dplyr)
require(reshape2)

BuildLine <- function( modelName, baseSize=12 ) {
  # Traditional reading in the files
  # getModels<- c("m7R1")
  
#   for(i in getModels){
#     modelName<- i
#     #   pathdsmInfo <- file.path("./Models/LCM/models/datasets",paste0(i,"_mInfo.rds"))
#     #   pathdsFERE  <- file.path("./Models/LCM/models/datasets",paste0(i,"_FERE.rds"))
#     pathdsp  <- file.path("./Models/LCM/models/datasets",paste0(i,"_dsp.rds"))
#     #   mInfoTemp<- readRDS(pathdsmInfo)
#     #   FERETemp<- readRDS(pathdsFERE)
#     dspTemp<- readRDS(pathdsp)
#     
#     #   assign(paste0(i,"_mInfo"),mInfoTemp)
#     #   assign(paste0(i,"_FERE"),FERETemp)
#     assign(paste0(i,"_dsp"),dspTemp)
#     #   rm(list = c("mInfoTemp", "FERETemp", "dspTemp"))
#   }
  pathdsp  <- file.path("./Models/LCM/models/datasets", paste0(modelName,"_dsp.rds"))
  dsp <- readRDS(pathdsp)

  ###############################################
  ### graph of prediction
  
  #bgColour<-gray(.95)   # background color
  indLineSz <-.08        # individual line size
  indLineAl <-.06        # individual line alpha
  
  themeLine <- ggplot2::theme_bw(base_size=baseSize) +
    ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = 12)) +
    ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40")) +
    ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40")) +
    ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80")) +
    ggplot2::theme(axis.ticks.length = grid::unit(0, "cm")) +
    ggplot2::theme(text = element_text(size =25)) +
    # ggplot2::theme(panel.background=element_rect(fill=bgColour,colour=NA)) +
    ggplot2::theme(legend.position=c(.95,.90),legend.direction="vertical") +
    ggplot2::theme(legend.background = element_rect(fill=NA)) +
    ggplot2::theme(legend.text = element_text(size = 15),legend.title.align =(-3.3))# +
    # ggplot2::theme(panel.grid = element_line(linetype = 1,size=rel(3)))
  
  ds<- dsp %>% dplyr::filter(id %in% c(1:500))
  head(ds)
  p<- ggplot2::ggplot(ds, aes(x=timec, y=attend, group=id))
  # geoms
  p<- p + geom_line(aes(x=timec,y=yHat),colour="red",alpha=indLineAl,size=indLineSz, na.rm=T)
  p<- p + geom_line(aes(y=yFE), fill=NA, na.rm=T)
  # scales
  p <- p + scale_x_continuous(breaks=seq(0,10, 1),limits=c(0,10)) 
  p <- p + scale_y_continuous(breaks=seq(0, 8, 1),limits=c(.5,8.5)) 
  # themes, guide, and annotations
  p <- p + themeLine 
  p <- p + labs(title="How often have you attended a worship service (2000)?", 
                x="Church attendance", 
                y="Count")
  return( p )
}
# BuildLine("m5F")
# BuildLine("m7R1")
# BuildLine("m7R2")
