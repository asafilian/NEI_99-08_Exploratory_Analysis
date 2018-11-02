## The R script for plot 4:
## Across the United States, how have emissions from 
##      coal combustion-related sources changed from 1999-2008?

## grep("combustion", shortnames)


# Loading some libraries:
library(dplyr)
library(ggplot2)

# Reading data from the current directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Getting needed Data
grp_value <- grep("Coal|coal", SCC$Short.Name, value = TRUE)
SCC_coal <- SCC %>% select(SCC, Short.Name) %>% filter(Short.Name %in% grp_value)
NEI_sel <- NEI %>% select(SCC, Emissions, year)
NEI_SCC_coal <- merge(NEI_sel, SCC_coal)
data <- NEI_SCC_coal %>% group_by(year) %>% summarize(Coal_Emission = sum(Emissions, na.rm = TRUE))

# Creating Plot:
png(file = "plot4.png")
print(qplot(year, Coal_Emission, data = data) + geom_line() + ggtitle("Coal Related Emissions (1999-2008)"))
dev.off()