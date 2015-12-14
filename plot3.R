## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

#get the data for Baltimore City, Maryland (fips == "24510")
baltimoreNEI <- NEI[NEI$fips == "24510",]

#Aggregate Emissions by Year
totalEmissionsByYearAndType <- aggregate(Emissions ~ year + type, data = baltimoreNEI, FUN = "sum")

#Plot the graph and save.
png("plot3.png",width=800, height=480)
library(ggplot2)
g <- ggplot(totalEmissionsByYearAndType, aes(factor(year), Emissions, fill = type)) +
    geom_bar(stat="identity", width=0.25) + 
    facet_grid(. ~ type) + 
    theme_bw() + 
    labs(x = "years", y = expression('total PM'[2.5]*' emission')) +
    labs(title=expression('Total PM'[2.5]*' emissions in Baltimore City, Maryland for 1999-2008 by Source Type'))
print(g)
dev.off()
