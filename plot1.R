### The R script for Plot 1:
## Have total emissions from PM2.5 decreased in the United States 
##      from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5
##      emission from all sources for each of the years 1999, 2002, 
##              2005, and 2008.

# Loading some libraries:
library(dplyr)

# Reading data from the current directory
NEI <- readRDS("summarySCC_PM25.rds")

# Getting needed data:
data <- NEI %>% group_by(year) %>% summarize(totalPM2.5 = sum(Emissions, na.rm = TRUE))

# Creating Plot:
png(file = "plot1.png")
with(data, plot(year, totalPM2.5))
lines(data$year, data$totalPM2.5)
title(main = "Total Emission from 1999-2008")
dev.off()