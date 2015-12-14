## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##### Make a plot to address the below question #####
#Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

# Subset motor vehicle sources data from SCC and subset that data from NEI
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

#get the data for Baltimore (fips == "24510") and los angeles (fips == "06037").
citiesVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips %in% c("24510", "06037"),]

#Aggregate Emissions by Year
totalEmissionsByYear <- aggregate(Emissions ~ year + fips, data = citiesVehiclesNEI, FUN = "sum")
totalEmissionsByYear$fips[totalEmissionsByYear$fips == "06037"] <- "Los Angeles County, CA"
totalEmissionsByYear$fips[totalEmissionsByYear$fips == "24510"] <- "Baltimore City, MD"

# Set appropriate column name for graph
library(data.table)
setnames(totalEmissionsByYear, "fips", "city")

#Plot the graph and save.
png("plot6.png",width=800, height=480)
library(ggplot2)
g <- ggplot(totalEmissionsByYear, aes(factor(year), Emissions, color = city)) +
    geom_point(size = 4) + 
    facet_grid(. ~ city) + 
    theme_bw() + 
    labs(x = "years", y = expression('total PM'[2.5]*' emission')) +
    labs(title=expression('Total PM'[2.5]*' emissions from motor vehicle sources in Baltimore City vs Los Angeles County for 1999–2008.'))
print(g)
dev.off()
