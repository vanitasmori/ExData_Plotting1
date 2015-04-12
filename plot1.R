## The first part and second part of this code are the preparatory steps before
## plotting, and are the same as in the other three codes ("plot2", "plot3" and 
## "plot4"). 


## The first part of the code is to
## 1) download zip file from given link;
## 2) unzip the file and read it into R, store it in a variable call "d";
## exploratary notes: 
## About temp: in case you will test-run the code, I create a temp
##    file("temp") to store the zip file, and remove the temp by "unlink" after  
##    reading data so that you won't need to actually download the zip file onto   
##    your pc, and delete it manually after the test.
## About colClasses: To facilitate the date conversion (character to Date) 
##    in the second part, "Date" and "Time" columns are set to be "character".
temp <- tempfile()
download.file(
"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
temp)
d <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, 
                sep = ";",na.strings = "?", check.names = FALSE, 
                stringsAsFactors = FALSE,
                colClasses = c(rep("character", 2), rep("numeric", 7)))
unlink(temp)

## The second part of the code is to 
## 1) subset the required data according to specific date;
## 2) create a new "Date_Time" column by merging "Date" and "Time";
## 3) convert "Date_Time" column to Date format, using strptime function.
data <- subset(d, Date == "1/2/2007" | Date =="2/2/2007")  
data$Date_Time <- paste(data$Date, data$Time)
data$Date_Time <- strptime(data$Date_Time, format="%d/%m/%Y %H:%M:%S")


## The third part is for plotting.
png(filename = "plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", main="Global Active Power", 
           xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()