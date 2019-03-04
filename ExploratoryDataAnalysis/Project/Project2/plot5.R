# plot 5 - How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library("data.table")
library("ggplot2")

summary_scc <- data.table::as.data.table(x = readRDS(file = "data/summarySCC_PM25.rds"))
scc <- data.table::as.data.table(x = readRDS(file = "data/Source_Classification_Code.rds"))


# subset of the source_data on vehicles
condition <- grepl("vehicle", scc[, SCC.Level.Two], ignore.case=TRUE)
vehicles_scc <- scc[condition, SCC]
vehicles_summary <- summary_scc[summary_scc[, SCC] %in% vehicles_scc,]

# Subset the vehicles NEI data to Baltimore's fip
baltimore_veh_summary <- vehicles_summary[fips=="24510",]

png("plot5.png")

ggplot(baltimore_veh_summary,
       aes(factor(year),
           Emissions)) +
        geom_bar(stat="identity", 
                 fill ="#FF9999",
                 width=0.75) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()