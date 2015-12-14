## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##### Make a plot to address the below question #####
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#Aggregate Emissions by Year
totalEmissionsByYear <- aggregate(Emissions ~ year, data = NEI, FUN = "sum")

#Plot the graph and save.
png("plot1.png", width=680, height=480)
barplot(height=totalEmissionsByYear$Emissions, 
        names.arg=totalEmissionsByYear$year, 
        xlab="years",
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions from all Sources for 1999, 2002, 2005 and 2008'))
dev.off()
