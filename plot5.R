## The R script code for plot 5:
## How have emissions from motor vehicle sources changed 
##      from 1999-2008 in Baltimore City? (fips = "24510")

# Loading some libraries:
library(dplyr)
library(ggplot2)

# Reading data from the current directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Getting needed Data
grp_m <- grep("motor|Motor", SCC$Short.Name, value = TRUE)
SCC_motor <- SCC %>% select(SCC, Short.Name) %>% filter(Short.Name %in% grp_m)
NEI_Balt_sel <- NEI %>% filter(fips == "24510") %>% select(SCC, Emissions, year)
NEI_Balt_motor <- merge(NEI_Balt_sel, SCC_motor)
data <- NEI_Balt_motor %>% group_by(year) %>% summarize(Motor_Emission = sum(Emissions, na.rm = TRUE))

# Creating Plot:
png(file = "plot5.png")
print(qplot(year, Motor_Emission, data = data) + geom_line() + ggtitle("Motor Vehicle Emissions (1999-2008) in Baltimore"))
dev.off()