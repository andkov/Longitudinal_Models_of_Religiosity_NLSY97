dsL<-readRDS("./Data/Derived/dsL.rds")
attcol8<-c("Never"="#4575b4",
           "Once or Twice"="#74add1",
           "Less than once/month"="#abd9e9",
           "About once/month"="#e0f3f8",
           "About twice/month"="#fee090",
           "About once/week"="#fdae61",
           "Several times/week"="#f46d43",
           "Everyday"="#d73027")

ds<- dsL
p<-ggplot(ds, aes(x=factor(year), fill=attendF))
p<-p+ geom_bar(position="fill")
p<-p+ scale_fill_manual(values = attcol8,
                        name="Response category" )
p<-p+ scale_y_continuous("Prevalence: proportion of total",
                         limits=c(0, 1),
                         breaks=c(.1,.2,.3,.4,.5,.6,.7,.8,.9,1))
p<-p+ scale_x_discrete("Waves of measurement",
                       limits=as.character(c(2000:2011)))
p<-p+ labs(title=paste0("In the past year, how often have you attended a worship service?"))
p

