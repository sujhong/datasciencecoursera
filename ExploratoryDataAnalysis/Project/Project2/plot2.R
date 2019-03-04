#plot 2 addresses the total emissions from PM2.5 decreased in the Baltimore, MD
## US from 1999 to 20

library("data.table")

summary_scc <- data.table::as.data.table(x = readRDS(file = "data/summarySCC_PM25.rds"))

summary_scc[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

summary_scc <- summary_scc[fips=='24510', 
                           lapply(.SD, sum, na.rm = TRUE),
                           .SDcols = c("Emissions"),
                           by = year]

        
png(filename='plot2.png')

barplot(summary_scc[, Emissions]
        , names = summary_scc[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()