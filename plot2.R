## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

#get the data for Baltimore City, Maryland (fips == "24510")
baltimoreNEI <- NEI[NEI$fips == "24510",]

#Aggregate Emissions by Year
totalEmissionsByYear <- aggregate(Emissions ~ year, data = baltimoreNEI, FUN = "sum")

#Plot the graph and save.
png("plot2.png" , width=680, height=480)
barplot(height=totalEmissionsByYear$Emissions, 
        names.arg=totalEmissionsByYear$year, 
        xlab="years", 
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions in Baltimore City, Maryland from 1999 to 2008'))
dev.off()
