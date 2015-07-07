##Setting up my working directory to the folder where my data is
setwd("../Data/exdata-data-household_power_consumption")

## reading the csv file
dataset <- read.csv(file = "household_power_consumption.txt", sep = ";" , colClasses = "character")

##Converting first column to usable dates
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

##subsetting data from 2007-02-01 to 2007-02-02
sampleassign <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

##Concatenation of date and time to create a Datetime column names Datetime
sampleassign$Datetime <- paste(as.character(sampleassign$Date), sampleassign$Time, sep = " ")
sampleassign$Datetime <- strptime(sampleassign$Datetime , format = "%Y-%m-%d %H:%M:%S")

##opening png creation with transprent background such as in rdpeng repo
png("plot2.png" , width = 480, height = 480 ,units = "px", bg = "transparent" )

## plotting the frame with type ="n" to avoid the dots with axis labels
plot(sampleassign$Datetime,sampleassign$Global_active_power, typ = "n", xlab = "" , ylab = "Global Active Power (kilowatts)")

##drawing the lines on the graphic
lines(sampleassign$Datetime,sampleassign$Global_active_power)

##close writing to png to save file
dev.off()