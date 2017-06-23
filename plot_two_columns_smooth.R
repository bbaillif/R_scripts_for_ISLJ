#! /usr/bin/Rscript

# Last update : 6/22/2017
# Written by Benoît BAILLIF, based on the work of Yanli XU and Glen ROPELLA
# Used by the compare_nectrig.R script

# Taken from Yanli XU scripts, smoothen the data
mav <- function(x, n = 50){
  filter(x, rep(1 / n, n), sides = 2)
}

PlotTwoColumns <- function(data, column1, column2, plotColors) {
  # Plot the 2 identical columns of the data frames, using the colors given
  #
  # Args :
  #   data : Large list, each element is a data frame, and the name of each 
  #     element is the name of the condition
  #   column1 : x to plot
  #   column2 : y to plot
  #   plotColors : vector containing the colors in order for each condition
  #
  # No return
  
  # Get the maximums for each condition, to set the lim of the plot
  max.x <- -1
  max.y <- -1
  for (i in 1:length(data)) {
    c1 <- data[[i]][column1]
    data[[i]][column2] <- mav(data[[i]][column2]) #smoothen the data
    c2 <- data[[i]][column2]
    c2 <- c2[!is.na(c2)]
    max.x <- max(max.x, max(c1))
    max.y <- max(max.y, max(c2))
    i <- i + 1
  }
  
  titleFigure <- paste(column1, "_VS_", column2, sep = "")
  
  plot(x    = c(), 
       y    = c(), 
       type = "l", 
       main = titleFigure, 
       xlab = column1, 
       ylab = column2, 
       xlim = c(0, max.x), 
       ylim = c(0,max.y))
  
  # Draw each condition
  for(i in 1:length(files)) {
    yData <- get(column2, data[[i]])
    xData <- get(column1, data[[i]])
    lines(yData ~ xData, col = plotColors[i])
  }
  
  legendStr <- readline("Input x and y coordinates to generate legends : ")
  legendCoord <- as.numeric(unlist(strsplit(legendStr, "[, ]+")))
  legend(x         = legendCoord[1], 
         y         = legendCoord[2], 
         legend    = names(data), 
         col       = plotColors, 
         text.font = 1, 
         lty       = c(1, 1), 
         bg        = 'lightblue')
  
  dev.print(jpeg, 
            paste(fileName, "_", titleFigure, ".jpeg", sep = ""), 
            width = 700)
} # end of PlotTwoColumns
