dsL<-readRDS("./Data/Derived/dsL.rds")
attcol8<-c("#4575b4","#74add1","#abd9e9", "#e0f3f8", "#fee090", "#fdae61" ,"#f46d43", "#d73027")

p<-ggplot(subset(dsL,year==2000), aes(x=attendF, fill=attendF ))
p<-p+geom_bar()
p + scale_fill_manual(values=attcol8)
p<-p+coord_flip()
p<-p+xlab("Church attendance") 
p<-p+ylab("Count")
p<-p+labs(title="How often did you attend a place of worship in the last year? (2000)")
p



# from Chang:
# The order of the items in the values vector matches the order of the factor levels for the
# discrete scale. In the preceding example, the order of sex is f, then m, so the first item
# in values goes with f and the second goes with m. Here’s how to see the order of factor
# levels:
#   levels(heightweight$sex)
# "f" "m"
# If the variable is a character vector, not a factor, it will automatically be converted to a
# factor, and by default the levels will appear in alphabetical order.
# It’s possible to specify the colors in a different order by using a named vector:
#   h + scale_colour_manual(values=c(m="blue", f="red"))