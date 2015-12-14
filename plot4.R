## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##### Make a plot to address the below question #####
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Subset coal combustion-related data from SCC and subset that data from NEI
coal <- grepl("coal", SCC$Short.Name, ignore.case = TRUE)
coalCombustionSCC <- SCC[coal,]$SCC
coalConbutionNEI <- NEI[NEI$SCC %in% coalCombustionSCC,]

#Aggregate Emissions by Year
totalEmissionsByYear <- aggregate(Emissions ~ year, data = coalConbutionNEI, FUN = "sum")

#Plot the graph and save.
png("plot4.png",width=800, height=480)
library(ggplot2)
g <- ggplot(totalEmissionsByYear, aes(factor(year), Emissions)) +
    geom_bar(stat="identity", fill="black", width=0.25) + 
    theme_bw() + 
    labs(x = "years", y = expression('total PM'[2.5]*' emission')) +
    labs(title=expression('Total PM'[2.5]*' emissions from coal combustion-related sources for 1999–2008'))
print(g)
dev.off()
