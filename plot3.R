# Exploring data - project 1
# 

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "file.zip"
file <- "household_power_consumption.txt"
download.file(url, destination, method = "curl")    ##don't forget to use method="curl" when you use a mac
data <- read.table(unz(destination, file),header = TRUE, sep = ";")

# file <- "household_power_consumption.txt"
# data <- read.csv(file, header = TRUE, sep = ";")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Date.Time <- paste(data$Date, data$Time)
filtdata <- data[(data$Date == "2007-02-01") | (data$Date == "2007-02-02"), ]
filtdata$Date.Time <- as.POSIXct(filtdata$Date.Time, format="%Y-%m-%d %H:%M:%S")

sub1 <- sub ("?", "", filtdata$Sub_metering_1)
filtdata$Sub_metering_1 <- as.numeric(sub1)
sub2 <- sub ("?", "", filtdata$Sub_metering_2)
filtdata$Sub_metering_2 <- as.numeric(sub2)

png(
  "plot3.png",
  width     = 480,
  height    = 480,
  units     = "px",
  res       = NA
)


plot(filtdata$Date.Time, filtdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(filtdata$Date.Time, filtdata$Sub_metering_2, type="l", col="red")
lines(filtdata$Date.Time, filtdata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  lty=c(1,1,1), # gives the legend appropriate symbols (lines)
  lwd=c(2.5,2.5,2.5),
  col=c("black","red","blue"))

dev.off()
