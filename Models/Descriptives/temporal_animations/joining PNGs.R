pathFolder<- file.path(getwd(),"Models/Descriptives/temporal_animations/")
joinThese<- c(file.path(pathFolder,"Agemon_Years/agemon_2000.png"),
             file.path(pathFolder,"Agemon_Years_Stabilized/agemon_2000.png"))
rl = lapply(joinThese, png::readPNG)
gl = lapply(rl, grid::rasterGrob)
do.call(gridExtra::grid.arrange(), gl) 

?sprintf

