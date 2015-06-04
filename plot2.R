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

linedata <- sub ("?", "", filtdata$Global_active_power)
filtdata$Global_active_power <- as.numeric(linedata)


png(
  "plot2.png",
  width     = 480,
  height    = 480,
  units     = "px",
  res       = NA
)


plot(filtdata$Date.Time, filtdata$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")


dev.off()
