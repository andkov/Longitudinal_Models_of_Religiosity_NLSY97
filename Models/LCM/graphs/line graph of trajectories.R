
# Traditional reading in the files
getModels<- c("m7R1")



for(i in getModels){
  modelName<- i
  #   pathdsmInfo <- file.path("./Models/LCM/models/datasets",paste0(i,"_mInfo.rds"))
  #   pathdsFERE  <- file.path("./Models/LCM/models/datasets",paste0(i,"_FERE.rds"))
  pathdsp  <- file.path("./Models/LCM/models/datasets",paste0(i,"_dsp.rds"))
  #   mInfoTemp<- readRDS(pathdsmInfo)
  #   FERETemp<- readRDS(pathdsFERE)
  dspTemp<- readRDS(pathdsp)
  
  #   assign(paste0(i,"_mInfo"),mInfoTemp)
  #   assign(paste0(i,"_FERE"),FERETemp)
  assign(paste0(i,"_dsp"),dspTemp)
  #   rm(list = c("mInfoTemp", "FERETemp", "dspTemp"))
}





###############################################
### graph of prediction

bgColour<-gray(.95)   # background color
indLineSz<-.08        # individual line size
indLineAl<-.06        # individual line alpha
baseSize <- 20


require(ggplot2)
ds<- m7R1_dsp %>% dplyr::filter(id %in% c(1:500))
head(ds)
p<- ggplot2::ggplot(ds, aes(x=timec, y=attend, group=id))
# geoms
p<- p + geom_line(aes(x=timec,y=yHat),colour="red",alpha=indLineAl,size=indLineSz)
p<- p + geom_line(aes(y=yFE), fill=NA)
# p<- p + geom_line(aes(y=gamma00),fill=NA, color="black",size=2)
# p<- p + geom_line(aes(y=gamma01),fill=NA, color="red", size=2)
# p<- p + geom_line(aes(y=gamma02),fill=NA, color="green", size=2)
# p<- p + geom_line(aes(y=gamma03),fill=NA, color="blue", size=2)
# p<- p + geom_line(aes(y=gamma10),fill=NA, color="black", size=1, linetype="dashed")
# p<- p + geom_line(aes(y=gamma11),fill=NA, color="red", size=1, linetype="dashed")
# p<- p + geom_line(aes(y=gamma12),fill=NA, color="green", size=1, linetype="dashed")
# p<- p + geom_line(aes(y=gamma13),fill=NA, color="blue",  size=1, linetype="dashed")
# scales
p<- p + scale_x_continuous(breaks=seq(0,10, 1),limits=c(0,10)) 
p<- p + scale_y_continuous(breaks=seq(0, 8, 1),limits=c(.5,8.5)) 
# themes, guide, and annotations
p <- p + ggplot2::theme_bw()
p <- p + ggplot2::theme_bw(base_size=baseSize)
p <- p + ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = 12)) 
p <- p + ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80"))
p <- p + ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))
p <- p + theme(text = element_text(size =25), panel.background=element_rect(fill=bgColour,colour=NA))
p<- p + ggplot2::theme(legend.position=c(.95,.90),legend.direction="vertical")
p<- p + ggplot2::theme(legend.background = element_rect(fill=NA))
p<- p + ggplot2::theme(legend.text = element_text(size = 15),legend.title.align =(-3.3))
p<- p + ggplot2::theme(panel.grid = element_line(linetype = 1,size=rel(3)))
p <- p + labs(title="How often have you attended a worship service (2000)?", 
              x="Church attendance", 
              y="Count")
p





