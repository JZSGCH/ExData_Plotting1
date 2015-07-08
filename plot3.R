##Downloading tha data and using a temp extraction
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <-tempfile()
download.file(fileURL, temp)

## reading the csv file
dataset <- read.csv(file = unz(temp,"household_power_consumption.txt"), sep = ";" , colClasses = "character")
unlink(temp)

##Converting first column to usable dates
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

##subsetting data from 2007-02-01 to 2007-02-02
sampleassign <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

##Concatenation of date and time to create a Datetime column names Datetime
sampleassign$Datetime <- paste(as.character(sampleassign$Date), sampleassign$Time, sep = " ")
sampleassign$Datetime <- strptime(sampleassign$Datetime , format = "%Y-%m-%d %H:%M:%S")

##opening png creation with transprent background such as in rdpeng repo
png("plot3.png" , width = 480, height = 480 ,units = "px", bg = "transparent" )

##plotting the frame with sub_metering_1 as 2 and 3 will fit in that frame
plot(sampleassign$Datetime,sampleassign$Sub_metering_1, type = "n", xlab ="", ylab = "Energy sub metering")

##Drawing each lines of data
lines(sampleassign$Datetime ,sampleassign$Sub_metering_1, col="black")
lines(sampleassign$Datetime ,sampleassign$Sub_metering_2, col="red")
lines(sampleassign$Datetime ,sampleassign$Sub_metering_3, col="blue")

##Adding the legend in the top righ hand corner
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(1,1,1),col = c("black","red","blue") )

##close writing to png to save file
dev.off()