## Load the dataset from the flat file.
library(data.table)
data <- fread("./household_power_consumption.txt",sep=";",na.strings="?")
#head(data)

## Subset the dataset for the desired date range and add a DateTime field.
library(dplyr)
subData <- filter(data,as.Date(Date,format="%d/%m/%Y")>=as.Date("2007-02-01"),as.Date(Date,format="%d/%m/%Y")<as.Date("2007-02-03"))
subData[,DateTime := as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")]
#head(subData)

## Plot the histogram to the default screen device.
par(bg="white") # Set the background color as white
hist(as.numeric(subData$Global_active_power),main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")

## Save the plot to a PNG file and close the PNG graphics device.
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()