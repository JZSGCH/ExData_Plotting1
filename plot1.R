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

##Open png creation with transprent background such as in rdpeng repo
png("plot1.png" , width = 480, height = 480 ,units = "px", bg = "transparent" )

##Plot the histogram with the right x label and main title and bar fill color
hist(as.numeric(sampleassign$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)" , main = "Global Active Power")

##Close writing to png to save file
dev.off()