
##load Packages

library(dplyr)
library(data.table)
library (lubridate)

## set workingdirectory

setwd("C:/Users/NACHO/Documents/cursoR/graficos/")

## read and clean data

consumo <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type dd/mm/yy

consumo$Date <- as.Date(consumo$Date, "%d/%m/%Y")

## Filter dataset from dates 2007-02-01 and 2007-02-02

consumo <- subset(consumo,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Erase incomplete observation

consumo<- consumo[complete.cases(consumo),]

## Combine Date and Time column

dateTime <- paste(consumo$Date, consumo$Time)

## Name the vector

dateTime <- setNames(dateTime, "DateTime")

## EraseDate and Time column from consumo

consumo <- consumo[ ,!(names(consumo) %in% c("Date","Time"))]

## Add DateTime column to Consumo

consumo <- cbind(dateTime, consumo)

## Format dateTime Column

consumo$dateTime <- as.POSIXct(dateTime)

## Create the plot_4 

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(consumo, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})


## Save file and close device

dev.copy(png,"plot_4.png", width=480, height=480)
dev.off()

