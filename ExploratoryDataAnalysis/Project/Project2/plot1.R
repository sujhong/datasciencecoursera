#plot 1 addresses the total emissions from PM2.5 decreased in the 
## US from 1999 to 2008

# using the base plotting system, make a plot showing the total PM2.5 emission from all sources
## for each of the years 1999, 2002, 2005, and 2008

library("data.table")

summary_scc <- data.table::as.data.table(x = readRDS(file = "data/summarySCC_PM25.rds"))
summary_scc[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

summary_scc <- summary_scc[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

png(filename='plot1.png')
barplot(summary_scc[, Emissions]
        , names = summary_scc[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()