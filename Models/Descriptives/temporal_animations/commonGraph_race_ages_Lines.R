# t<- 16
barVal<- .5
ds<- dsL %.%
  dplyr::mutate(ageF = as.factor(round(agemon/12 ))) %>%
  dplyr::filter(year %in% c(2000:2011), !is.na(attend), race !=3) %.%   
  dplyr::group_by(sampleF,ageF,raceF,attendF) %.%
  dplyr::summarize(count = n()) %.%
  dplyr::mutate(total = sum(count),
                percent= count/total) %>%
  dplyr::mutate(curtime= ifelse(ageF==t,barVal,0)) %>%
  dplyr::arrange(ageF)
# ds
# canvas
p<- ggplot( ds, aes(x=ageF, y=percent, color=attendF)) 
# geoms
p<- p+ geom_line(aes(group=attendF), stat="identity", size=.4)
p<- p+ geom_point(aes(fill=attendF), shape=21, size=2.5, linesize=1,alpha=.8)
p<- p+ facet_grid(sampleF ~ raceF)
# scales
p<- p+ scale_color_manual(values = attendCol8,na.value=NACol)
p<- p+ scale_fill_manual(values = attendCol8,na.value=NACol)
p<- p+ scale_y_continuous(limits=c(0, .5),
                          breaks=c(0,.1,.2,.3,.4,.5))
p<- p+ scale_x_discrete(limits=as.character(c(16:32)))
# # annotations
p<- p + guides(fill = guide_legend(reverse=FALSE, title="Response category")) 
p<- p + guides(color = FALSE) 
p<-  p+ labs(title = "In the past year, how often have you attended a worship service?",
             x="Ages. Bin = 1 year.",
             y="Proportion of total")
# # themes
p <- p + ggplot2::theme_bw()
p <- p + ggplot2::theme_bw(base_size=baseSize)
p <- p + ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = 12)) 
p <- p + ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80"))
p <- p + ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))
p <- p + ggplot2::theme(axis.text.x = element_text(angle=90, hjust=1, vjust=.5, size=8))
p
# counters
p<-  p + geom_bar(aes(y=curtime),stat="identity",
                  color=NA, alpha=.2)