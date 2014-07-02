# t<-17
barVal<- 1
ds<- dsL %.%
  dplyr::mutate(ageF = as.factor(round(agemon/12 ))) %>%
  dplyr::filter(year %in% c(2000:2011), !is.na(attend), race !=3) %.%   
  dplyr::group_by(sampleF,raceF,ageF) %.%
  dplyr::summarize(count = n()) %>% 
  dplyr::mutate(curtime= ifelse(ageF==t,barVal,0)) %>%
  dplyr::arrange(ageF)
ds



# canvas
p<- ggplot( ds, aes(x=ageF, y=count, fill=factor(curtime)))
# geoms
p<- p + geom_bar(stat="identity")
p<- p+ facet_grid(sampleF~raceF)
# scales
# p<- p+ scale_fill_manual(values = c(basicDark,"white")) 
p<- p+ scale_y_continuous(limits=c(0, 4500),
                          breaks=c(1000,2000,3000,4000))
p<- p+ scale_x_discrete(limits=as.character(c(16:32)))
p<- p+ scale_fill_manual(values=c("0"="grey","1"="black"))
# # annotations
p<- p + guides(fill = guide_legend(reverse=FALSE, title="Response category")) 
p<- p + guides(color = FALSE, fill=FALSE) 
p<-  p+ labs(title = "In the past year, how often have you attended a worship service?",
             x="Ages. Bin = 1 year",
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
# p
# k<-grid.arrange(m,p)

