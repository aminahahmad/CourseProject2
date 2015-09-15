## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("NEISCC")){
  NEI_SCC <- merge(NEI, SCC, by="SCC")
}

library (ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEI_SCC$Short.Name, ignore.case=TRUE)
subsetNEI_SCC <- NEI_SCC[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI_SCC, sum)



png("plot4.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity",fill = "blue") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from Year 1999 to 2008')
print(g)
dev.off()
