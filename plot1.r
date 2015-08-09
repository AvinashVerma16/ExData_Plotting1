# Load libraries and  input data

library(gsubfn)
library(sqldf)
source("http://sqldf.googlecode.com/svn/trunk/R/sqldf.R")
data <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')",header = TRUE, sep = ";")
data1 <- data
data1 <- transform(data1,Date = as.Date(Date,"%d/%m/%Y"))
data1$DateTime <- paste(data1$Date,data$Time, sep = " ")

data1 <- transform(data1,DateTime = strptime(DateTime,"%Y-%m-%d %H:%M:%S"))

#Plot 1

png("plot1.png", width = 480, height = 480)
hist(data1$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power",col = "red")
dev.off()