#! /usr/bin/Rscript

# Copyright statement : no copyright

# Last update : 6/22/2017
# Written by Benoît BAILLIF, based on the work of Yanli XU and Glen ROPELLA
# Purpose : Compare nectrig data from ISLJ, from different conditions
# Input : directory containing data reduced *_nectrig.csv files 
#   (from islj/bin/nectrig.R) for different experiments, name of each 
#   condition, color for each condition to plot
# Output : numerous plot comparing colunm1 VS column2 for all conditions 
#   (name chosen)

source("plot_two_columns_smooth.R") # Import PlotTwoColumns

# /home/bens/Documents/Internship/scripts_analysis
workDir <- readline(prompt = "Please input the working directory : ")
workDir <- unlist(strsplit(workDir, "[ ]+"))
setwd(workDir)

fileName <- readline("Name the output file (plot) : ")

files <- list.files(pattern = "[0-9]+_nectrig.csv", recursive = T)

i <- 1
# Large-list to stock our data frames. 
# The name of each data frame will be given by the user.
data <- list()


for(file in files) {
  # The double brackets creates a large list
  data[[i]] <- read.csv(file)
  names(data)[i] <- readline(paste("What is the name of the condition for the 
  file ", file, " ? (no space) "))
  i <- i + 1
}

if (!file.exists("graphics")) {
  dir.create("graphics")
}
setwd(paste(workDir, "/graphics", sep = ""))

colStr <- readline(paste("Please input", length(data), "different colors to 
represent the conditions. Colors available : black, blue, green, red, 
burlywood4, forestgreen, firebrick, blue4, purple, chocolate, cyan, gold, 
darkviolet, brown : \n")) 
plotColors <- unlist(strsplit(colStr, "[, ]+"))

column1 <- "Time_of_NecTrig"
columnsY <- c("Mean.Dist_from_PV","Median.Dist_from_PV", "Mean.Dist_from_CV", 
              "Median.Dist_from_CV", "Cumu_Nectrig")

for(column2 in columnsY) {
  PlotTwoColumns(data, column1, column2, plotColors)
}

q()