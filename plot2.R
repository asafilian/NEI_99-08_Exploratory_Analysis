## The R script for plot 2:
## Have total emissions from PM2.5 decreased in the Baltimore City, 
##    Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

# Loading some libraries:
library(dplyr)

# Reading data from the current directory
NEI <- readRDS("summarySCC_PM25.rds")

# Getting needed data
data <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarize(totalPM2.5 = sum(Emissions, na.rm = TRUE))

# Creating Plot:
png(file = "plot2.png")
with(data, plot(year, totalPM2.5))
lines(data$year, data$totalPM2.5)
title(main = "Total Emission from 1999-2008 in the Baltimore City")
dev.off()