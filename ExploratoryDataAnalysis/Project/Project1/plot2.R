library(data.table)
library(dplyr)

#read file and note that missing values are coded as "?" in the txt file
power <-fread("household_power_consumption.txt",
              na.strings = '?')


#dateTime <- strptime(paste(power$Date, power$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
#power <- cbind(power, dateTime)
# add dateTime column
power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#only intersted in data from dates 2007 -02-01 and 2007-02-02
power <- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]


# plot 2
png("plot2.png", width=480, height=480)
plot(x = power$dateTime,
     y = power$Global_active_power,
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()
