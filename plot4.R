##Setting up my working directory to the folder where my data is
setwd("../Data/exdata-data-household_power_consumption")

## reading the csv file
dataset <- read.csv(file = "household_power_consumption.txt", sep = ";" , colClasses = "character")

##Converting first column to usable dates
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

##subsetting data from 2007-02-01 to 2007-02-02
sampleassign <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

##concatenation of date and time to create a Datetime column names Datetime
sampleassign$Datetime <- paste(as.character(sampleassign$Date), sampleassign$Time, sep = " ")
sampleassign$Datetime <- strptime(sampleassign$Datetime , format = "%Y-%m-%d %H:%M:%S")


png("plot4.png" , width = 480, height = 480 ,units = "px", bg = "transparent" )

##preparation of the plotting zone (2 rows, 2 columns), adding graphs column wise
par(mfcol = c(2,2))

## plotting the plot2 exercise
plot(sampleassign$Datetime,sampleassign$Global_active_power, typ = "n", xlab = "" , ylab = "Global Active Power (kilowatts)")
lines(sampleassign$Datetime,sampleassign$Global_active_power)

## plotting the plot3 exercise but trick is without legend border
plot(sampleassign$Datetime,sampleassign$Sub_metering_1, type = "n", xlab ="", ylab = "Energy sub metering")


lines(sampleassign$Datetime ,sampleassign$Sub_metering_1, col="black")
lines(sampleassign$Datetime ,sampleassign$Sub_metering_2, col="red")
lines(sampleassign$Datetime ,sampleassign$Sub_metering_3, col="blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(1,1,1),col = c("black","red","blue"), bty = "n" )

##plotting the third graph (top right hand corner)
plot(sampleassign$Datetime,sampleassign$Voltage, typ = "n", xlab = "datetime" , ylab = "Voltage")
lines(sampleassign$Datetime,sampleassign$Voltage)

##plotting the last
plot(sampleassign$Datetime,sampleassign$Global_reactive_power, typ = "n", xlab = "datetime" , ylab = "Global_reactive_power")
lines(sampleassign$Datetime,sampleassign$Global_reactive_power)

##close writing to png to save file
dev.off()
