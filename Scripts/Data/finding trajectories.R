a<- dsL %>% dplyr::filter(attend %in% c(7) & year==2000) %>%
   dplyr::select(id,year,attend)
a<-unique(a$id)

b<- dsL %>% dplyr::filter(attend %in% c(1) & year==2006) %>%
   dplyr::select(id,year,attend)
b<-unique(b$id)

c<- dsL %>% dplyr::filter(attend %in% c(3) & year==2011) %>%
  dplyr::select(id,year,attend)
c<-unique(c$id)

i<- intersect(intersect(a,b),c,)
print(i)

# interesting ids
# 611, 286, 41, 7499

ds<- dsL %>% 
  dplyr::filter(id==7499 ,year %in% c(2000:2011)) %>% 
  dplyr::select(id,year,attend,attendF) %>% 
  dplyr::mutate(time=year-2000)

# canvas
p<-ggplot(ds, aes(x=time,y=attend))
# geoms
p<- p+ geom_point(aes(fill=attendF), size=3.5, shape=21)
p<- p+ geom_line(aes(group=id), alpha=.6, linetype=2, size=.5)
# scales
p<- p+ scale_fill_manual(values=attendCol8)
p<- p+ scale_y_continuous("Church attendance",
                          limits=c(0, 8),
                          breaks=c(1:8))
p<- p+ scale_x_continuous("Years since 2000",
                          limits=c(0,11),
                          breaks=c(0:11))
# annotations
p<- p + labs(title=paste0("In the past year, how often have you attended a worship service?"))
p<- p + guides(fill = guide_legend(reverse=TRUE, title="Response category")) 
# # themes
p<- p + ggplot2::theme_bw()
p<- p + ggplot2::theme_bw(base_size=baseSize)
p<- p + ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = 12)) 
p<- p + ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40"))
p<- p + ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40"))
p<- p + ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80"))
trajD <- p + ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))
trajD # trajectory from Data
