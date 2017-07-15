
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

## Create the histogram plot1 "Global Active Power"

hist(consumo$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")


## Save file and close device

dev.copy(png,"plot_1.png", width=480, height=480)
dev.off()

