# plot 6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
## vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater
## changes over time in motor vehicle emissions?

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
baltimore_veh_summary[, city := c("Baltimore City")]

# Subset the vehicles NEI data to LA's fip
vehiclesLA_summary <- vehicles_summary[fips == "06037",]
vehiclesLA_summary[, city := c("Los Angeles")]

# Combine data.tables into one data.table
both <- rbind(baltimore_veh_summary,vehiclesLA_summary)

png("plot6.png")

ggplot(both, 
       aes(x=factor(year), 
           y=Emissions, 
           fill=city)) +
        geom_bar(aes(fill=year), 
                 stat="identity") +
        facet_grid(scales="free", 
                   space="free", 
                   .~city) +
        labs(x="year", 
             y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()