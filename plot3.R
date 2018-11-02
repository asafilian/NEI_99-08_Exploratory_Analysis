## The R script for Plot 3:
## Of the four types of sources indicated by the type 
##    (point, nonpoint, onroad, nonroad) variable, 
##        which of these four sources have seen decreases 
##              in emissions from 1999-2008 for Baltimore city? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

# Loading some libraries:
library(dplyr)
library(ggplot2)

# Reading data from the current directory
NEI <- readRDS("summarySCC_PM25.rds")

# Getting needed data
data <- NEI %>% group_by(type, year) %>% summarize(totalPM2.5 = sum(Emissions, na.rm = TRUE))

# Creating Plot:
png(file = "plot3.png")
print(qplot(year, totalPM2.5, data = data, facets = type~.) + geom_line() + ggtitle("Emissions in Balitomore (1999-2008) for different types"))
dev.off()
