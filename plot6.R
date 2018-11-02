## The R script for plot 6:
## Compare emissions from motor vehicle sources in Baltimore City 
##      with emissions from motor vehicle sources in Los Angeles County, 
##              California (fips=="06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

# Loading some libraries:
library(dplyr)

# Reading data from the current directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Getting needed data  
grp_m <- grep("motor|Motor", SCC$Short.Name, value = TRUE)
SCC_motor <- SCC %>% select(SCC, Short.Name) %>% filter(Short.Name %in% grp_m)
NEI_Balt_sel <- NEI %>% filter(fips == "24510") %>% select(SCC, Emissions, year)
NEI_LosAng_sel <- NEI %>% filter(fips == "06037") %>% select(SCC, Emissions, year)
NEI_Balt_motor <- merge(NEI_Balt_sel, SCC_motor)
NEI_LosAng_motor <- merge(NEI_LosAng_sel, SCC_motor)
data_Balt <- NEI_Balt_motor %>% group_by(year) %>% summarize(Motor_Emission = sum(Emissions, na.rm = TRUE))
data_LosAng <- NEI_LosAng_motor %>% group_by(year) %>% summarize(Motor_Emission = sum(Emissions, na.rm = TRUE))
rng <- range(data_Balt$Motor_Emission, data_LosAng$Motor_Emission, na.rm = TRUE)

# Creating Plot
png(file = "plot6.png")
par(mfrow = c(1, 2), mar = c(4,4,2,1))
with(data_Balt, plot(year, Motor_Emission, ylim = rng, main = "Baltimore", pch = 19))
abline(h = median(data_Balt$Motor_Emission), lwd = 2, lty = 2, col = "blue")
lines(data_Balt$year, data_Balt$Motor_Emission)
with(data_LosAng, plot(year, Motor_Emission, ylim = rng, main = "Los Angeles", pch = 19))
abline(h = median(data_LosAng$Motor_Emission), lwd = 2, lty = 2, col = "blue")
lines(data_LosAng$year, data_LosAng$Motor_Emission)
dev.off()
