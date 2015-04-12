## download and read data
temp <- tempfile()
download.file(
      "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
      temp)
d <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, 
                sep = ";",na.strings = "?", check.names = FALSE, 
                stringsAsFactors = FALSE,
                colClasses = c(rep("character", 2), rep("numeric", 7)))
unlink(temp)

## subsetting and converting Date format.
data <- subset(d, Date == "1/2/2007" | Date =="2/2/2007")  
data$Date_Time <- paste(data$Date, data$Time)
data$Date_Time <- strptime(data$Date_Time, format="%d/%m/%Y %H:%M:%S")

## plotting
png(filename = "plot2.png", width=480, height=480, bg = "transparent")
plot(data$Date_Time, data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)" )
dev.off()