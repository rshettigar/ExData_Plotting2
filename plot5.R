## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##### Make a plot to address the below question #####
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

# Subset motor vehicle sources data from SCC and subset that data from NEI
vehicles <- grepl("vehicle", SCC$Short.Name, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

#get the data only for Baltimore City, Maryland (fips == "24510")
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "24510",]

#Aggregate Emissions by Year
totalEmissionsByYear <- aggregate(Emissions ~ year, data = baltimoreVehiclesNEI, FUN = "sum")

#Plot the graph and save.
png("plot5.png",width=800, height=480)
library(ggplot2)
g <- ggplot(totalEmissionsByYear, aes(factor(year), Emissions)) +
    geom_bar(stat="identity", fill="black", width=0.25) + 
    theme_bw() + 
    labs(x = "years", y = expression('total PM'[2.5]*' emission')) +
    labs(title=expression('Total PM'[2.5]*' emissions from motor vehicle sources for 1999–2008 in Baltimore City'))
print(g)
dev.off()
