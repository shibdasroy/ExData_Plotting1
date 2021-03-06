## Load the dataset from the flat file.
library(data.table)
data <- fread("./household_power_consumption.txt",sep=";",na.strings="?")
#head(data)

## Subset the dataset for the desired date range and add a DateTime field.
library(dplyr)
subData <- filter(data,as.Date(Date,format="%d/%m/%Y")>=as.Date("2007-02-01"),as.Date(Date,format="%d/%m/%Y")<as.Date("2007-02-03"))
subData[,DateTime := as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")]
#head(subData)

## Plot to the default screen device.
par(bg="white") # Set the background color as white
plot(subData$DateTime,as.numeric(subData$Sub_metering_1),xlab="",ylab="Energy sub metering",type="n")
points(subData$DateTime,as.numeric(subData$Sub_metering_1),type="l",col="black")
points(subData$DateTime,as.numeric(subData$Sub_metering_2),type="l",col="red")
points(subData$DateTime,as.numeric(subData$Sub_metering_3),type="l",col="blue")
legend("topright",pch="_",col=c("black","red","blue"),legend=c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "))

## Save the plot to a PNG file and close the PNG graphics device.
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()