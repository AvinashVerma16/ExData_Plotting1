# Load libraries and  input data

library(gsubfn)
library(sqldf)
source("http://sqldf.googlecode.com/svn/trunk/R/sqldf.R")
data <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')",header = TRUE, sep = ";")
data1 <- data
data1 <- transform(data1,Date = as.Date(Date,"%d/%m/%Y"))
data1$DateTime <- paste(data1$Date,data$Time, sep = " ")

data1 <- transform(data1,DateTime = strptime(DateTime,"%Y-%m-%d %H:%M:%S"))

#Plot 4

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(data1, {

plot(data1$Global_active_power, type = "l", xlab = "", xaxt = "n", ylab = "Global Active Power")
axis(1, at = c( 1, length(data1$Date) / 2, length(data1$Date)), labels = c("Thu", "Fri", "Sat"), las = 0)

plot(data1$Voltage, type = "l", xlab = "datetime", xaxt = "n", ylab = "Voltage", bg = "white")
axis(1, at = c( 1, length(data1$Date) / 2, length(data1$Date)), labels = c("Thu", "Fri", "Sat"), las = 0)

plot(data1$Sub_metering_1, type = "l", xlab = "", xaxt = "n", ylab = "Energy sub metering", col = "black")
lines(data1$Sub_metering_2, type = "l", col = "red")
lines(data1$Sub_metering_3, type = "l", col = "blue")
axis(1, at = c( 1, length(data1$Date) / 2, length(data1$Date)), labels = c("Thu", "Fri", "Sat"), las = 0)
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(data1$Global_reactive_power, type = "l", xlab = "datetime", xaxt = "n", ylab = "Global_reactive_power")
axis(1, at = c( 1, length(data1$Date) / 2, length(data1$Date)), labels = c("Thu", "Fri", "Sat"), las = 0)

})
dev.off()
