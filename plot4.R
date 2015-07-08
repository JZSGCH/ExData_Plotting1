##Download the data and using a temp extraction
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <-tempfile()
download.file(fileURL, temp)

##Read the csv file
dataset <- read.csv(file = unz(temp,"household_power_consumption.txt"), sep = ";" , colClasses = "character")
unlink(temp)

##Convert first column to usable dates
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

##Subset data from 2007-02-01 to 2007-02-02
sampleassign <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

##Concatenate of date and time to create a Datetime column names Datetime
sampleassign$Datetime <- paste(as.character(sampleassign$Date), sampleassign$Time, sep = " ")
sampleassign$Datetime <- strptime(sampleassign$Datetime , format = "%Y-%m-%d %H:%M:%S")

##Open png creation with transprent background such as in rdpeng repo
png("plot4.png" , width = 480, height = 480 ,units = "px", bg = "transparent" )

##preparation of the plotting zone (2 rows, 2 columns), adding graphs column wise
par(mfcol = c(2,2))

##Plot the plot2 exercise
plot(sampleassign$Datetime,sampleassign$Global_active_power, typ = "n", xlab = "" , ylab = "Global Active Power (kilowatts)")
lines(sampleassign$Datetime,sampleassign$Global_active_power)

##Plot the plot3 exercise but trick is without legend border
plot(sampleassign$Datetime,sampleassign$Sub_metering_1, type = "n", xlab ="", ylab = "Energy sub metering")


lines(sampleassign$Datetime ,sampleassign$Sub_metering_1, col="black")
lines(sampleassign$Datetime ,sampleassign$Sub_metering_2, col="red")
lines(sampleassign$Datetime ,sampleassign$Sub_metering_3, col="blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(1,1,1),col = c("black","red","blue"), bty = "n" )

##Plot the third graph (top right hand corner)
plot(sampleassign$Datetime,sampleassign$Voltage, typ = "n", xlab = "datetime" , ylab = "Voltage")
lines(sampleassign$Datetime,sampleassign$Voltage)

##Plot the last
plot(sampleassign$Datetime,sampleassign$Global_reactive_power, typ = "n", xlab = "datetime" , ylab = "Global_reactive_power")
lines(sampleassign$Datetime,sampleassign$Global_reactive_power)

##Close writing to png to save file
dev.off()
