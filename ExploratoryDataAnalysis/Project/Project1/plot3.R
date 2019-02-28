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

#plot3
png("plot3.png", width=480, height=480)
plot(power$dateTime, 
     power$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")

lines(power$dateTime, 
      power$Sub_metering_2,
      col="red")

lines(power$dateTime, 
      power$Sub_metering_3,
      col="blue")

legend("topright", 
       col=c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), 
       lwd=c(1,1))

dev.off()