## 0) Downloaded the files.

if (!file.exists("data")) {
  
  dir.create("data")
  
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./data/project.zip")

## Unzip data

unzip(zipfile = "./data/project.zip", exdir = "./data")

## 1) read file.
data <- read.csv("./data/household_power_consumption.txt",header = TRUE , sep = ";")

## 2) Convert data
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Date <- as.Date(data$Date, "%d/%m/%Y");

## 3) Extract only days 01-02-2007 and 02-02-2007.
extract <- subset(data , data$Date == as.Date("1/2/2007","%d/%m/%Y") |data$Date== as.Date("2/2/2007","%d/%m/%Y"))

## 4) Add column date.time
extract$date.time <- as.POSIXct(paste(extract$Date, extract$Time), format = "%Y-%m-%d %H:%M:%S")

## 5) Remove NA's.
extract <- na.omit(extract)

## 6) Create plot
##***Establish languaje, because my operative system is in spanish
Sys.setlocale(locale = "USA")
##***save file using the next line to get a best image that if we use dev.copy
png(file = "plot2.png",width = 480, height = 480, units = "px")
par(mfrow=c(1,1))
with(extract, plot(date.time,Global_active_power,type='l',xlab='',ylab='Global Active Power (kilowatts)') )

## 7) Create png file.
##dev.copy(png, file = "plot2.png" ,width = 480, height = 480, units = "px")

## 8) Close the file
dev.off()