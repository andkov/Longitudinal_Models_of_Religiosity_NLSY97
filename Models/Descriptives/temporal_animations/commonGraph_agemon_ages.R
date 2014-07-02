# t<-16

require(dplyr)
require(ggplot2)
ds<- dsL %>% 
  dplyr::select(id,year,byearF,attend,agemon,ageyear) %>%
  mutate(time=year-2000, age=agemon/12, ageF=round(age,0)) %>%
  dplyr::filter(ageF==t)
ds

# canvas
p<- ggplot(ds, aes(x=age, fill=byearF))
p<- p + geom_bar(bin=1/12)
p<- p + scale_fill_manual(values=byearCol5)
# scales
p<- p + scale_x_continuous(limits=c(16,32), breaks=seq(16,32,1))
p<- p + scale_y_continuous(limits=c(0,600), breaks=seq(0,600,100))
# annotations
p<- p + guides(fill = guide_legend(reverse=TRUE, title="Birth year")) 
p<- p + labs(title = "Age and cohort structure",
             x="Age in years. Bin = 1 month",
             y="Count")
# themes
p <- p + ggplot2::theme_bw()
p <- p + ggplot2::theme_bw(base_size=baseSize)
p <- p + ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = 12)) 
p <- p + ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40"))
p <- p + ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80"))
p <- p + ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))


# p



# k<-grid.arrange(m,p)
