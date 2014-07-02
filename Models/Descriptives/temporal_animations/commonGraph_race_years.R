# # dummy data for the counter graph
# counterAge<- c("0"="white","1"="#23c8b2")
# age<- c(16:32)
# time<- c(1:length(age))
# dummy<-rep(0,length(age))
# d<- data.frame(time, age,dummy)
# 
# # COUNTER
# dd<-d
# dd[d$age==t,"dummy"]<- 1
# m<- ggplot(dd, aes(x=factor(time), y=1, fill=factor(dummy)))
# m<- m+ geom_tile(color="white")  
# m<- m+ geom_text(data=subset(d, age==t), aes(x=factor(time), y=1, label=age))  
# m<- m+ scale_fill_manual(values=counterAge, guide="none")  
# m<- m+ scale_x_discrete(expand=c(0,0),"Age")
# m<- m+ scale_y_continuous("box") 
# m<- m+ theme_minimal()
# m <- m + ggplot2::theme(axis.ticks= element_blank(), axis.text.y = element_blank())
# m <- m + ggplot2::theme(axis.text.x = element_blank())
# m <- m + ggplot2::theme(axis.title.y = element_blank())
# m
# require(ggplot2) 
# t<- 2000
# MAIN GRAPH
# inRfile<-getwd()
ds<- dsL %.%
  dplyr::filter(year %in% c(t), !is.na(attend), race !=3) %.%   # comment out to count NA in the total
  dplyr::group_by(sampleF,yearF,raceF,attendF) %.%
  dplyr::summarize(count = n()) %.%
  dplyr::mutate(total = sum(count),
                percent= count/total)
# ds
p<- ggplot( ds, aes(x=attendF, y=percent, fill=attendF)) 
# geoms
p<- p+ geom_bar(stat="identity")
p<- p+ facet_grid(sampleF ~ raceF)
p<- p+ geom_text(aes(label=round(percent,2)), position=position_dodge(.9), vjust=-.2, size=3.5)
# scales

p<- p+ scale_fill_manual(values = attendCol8,na.value=NACol)
p<- p+ scale_y_continuous(limits=c(0, .5),
                          breaks=c(0,.1,.2,.3,.4,.5))
# # annotations
p<- p + guides(fill = guide_legend(reverse=FALSE, title="Response category")) 
p<- p + guides(color = FALSE) 
p<-  p+ labs(title = paste("In the past year (",t,") how often have you attended a worship service?"),
             x="Church attendance",
             y="Proportion of total")
# # themes
p <- p + ggplot2::theme_bw()
p <- p + ggplot2::theme_bw(base_size=baseSize)
p <- p + ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = 12)) 
p <- p + ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80"))
p <- p + ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))
p <- p + ggplot2::theme(axis.text.x = element_blank())
# mark ups
# p<- p + annotate("text", label="Group 1", family="serif",
#                  fontface="italic", colour="darkred", size=3)
#  p<- p + annotate("rect", xmin=1, xmax=30, ymin=-1, ymax=1, alpha=.9,
#               fill="green")
 
#  p

 
 
 
# k<-grid.arrange(m,p)

