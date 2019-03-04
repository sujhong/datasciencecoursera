# plot 4 - Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999–2008?

library("data.table")
library("ggplot2")

summary_scc <- data.table::as.data.table(x = readRDS(file = "data/summarySCC_PM25.rds"))
source_data <- data.table::as.data.table(x = readRDS(file = "data/Source_Classification_Code.rds"))

# Subset data
combustion <- grepl("comb", source_data[, SCC.Level.One], ignore.case=TRUE)
coal <- grepl("coal", source_data[, SCC.Level.Four], ignore.case=TRUE) 
combustion_source <- source_data[combustion & coal, SCC]
combustion_summary <- summary_scc[summary_scc[,SCC] %in% combustion_source]

png("plot4.png")

ggplot(combustion_summary,
       aes(x = factor(year),
           y = Emissions/10^5)) +
        geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()



