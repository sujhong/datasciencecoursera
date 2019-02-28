library(data.table)
library(dplyr)

#read file and note that missing values are coded as "?" in the txt file
power <-fread("household_power_consumption.txt",
              na.strings = '?')

#only intersted in data from dates 2007 -02-01 and 2007-02-02
power$Date <- as.Date(power$Date, "%d/%m/%y")
power_dt <- power %>% filter(Date>= "2007-02-01" & Date <="2007-02-02")

# first plot is to make a histogram 
png("plot1.png", width=480, height = 480)

hist(power_dt$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

dev.off()