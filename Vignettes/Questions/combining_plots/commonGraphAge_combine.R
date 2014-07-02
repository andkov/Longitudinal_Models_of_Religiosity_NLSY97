##define multiplot function
multiplot <- function(..., plotlist=NULL, cols) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # Make the panel
  plotCols = cols                          # Number of columns of plots
  plotRows = ceiling(numPlots/plotCols) # Number of rows needed, calculated from # of cols
  
  # Set up the page
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(plotRows, plotCols)))
  vplayout <- function(x, y)
    viewport(layout.pos.row = x, layout.pos.col = y)
  
  # Make each plot, in the correct location
  for (i in 1:numPlots) {
    curRow = ceiling(i/plotCols)
    curCol = (i-1) %% plotCols + 1
    print(plots[[i]], vp = vplayout(curRow, curCol ))
  }
  
}




# dummy data for the counter graph
counterAge<- c("0"="white","1"="#23c8b2")
age<- c(16:32)
time<- c(1:length(age))
dummy<-rep(0,length(age))
d<- data.frame(time, age,dummy)

# COUNTER
dd<-d
dd[d$age==t,"dummy"]<- 1
m<- ggplot(dd, aes(x=time, y=factor(dummy)))
m<- m+ geom_bar(stat="identity", fill="#23c8b2")  

m<- m+ geom_text(aes(label=age),vjust=0)  
# m<- m+ scale_fill_manual(values=counterAge, guide="none")  
# m<- m+ scale_x_discrete(expand=c(0,0),"Age")
m<- m+ scale_y_discrete(limits=c(0,1)) 
# m<- m+ theme_minimal()
# m <- m + ggplot2::theme(axis.ticks= element_blank(), axis.text.y = element_blank())
# m <- m + ggplot2::theme(axis.text.x = element_blank())
# m <- m + ggplot2::theme(axis.title.y = element_blank())
m

# MAIN GRAPH
ds<- dsL %.%
  dplyr::mutate(ageF = as.factor(round(agemon/12 ))) %>%
  dplyr::filter(ageF %in% c(t), !is.na(attend), race !=3) %.%   
  dplyr::group_by(sampleF,ageF,raceF,attendF) %.%
  dplyr::summarize(count = n()) %.%
  dplyr::mutate(total = sum(count),
                percent= count/total)
# canvas
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
p<-  p+ labs(title = paste0("In the past year, how often have you attended a worship service? (age ", t, ")"),
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

k<-grid.arrange(m,p)

png(filename = "counter.jpg", pointsize =12,res = 70, height = 2)
multiplot(m,p,cols=1)
dev.off()




