# Exploring data - project 1
# 

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "file.zip"
file <- "household_power_consumption.txt"
download.file(url, destination, method = "curl")    ##don't forget to use method="curl" when you use a mac
data <- read.table(unz(destination, file),header = TRUE, sep = ";")

# data <- read.csv(file, header = TRUE, sep = ";")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
filtdata <- data[(data$Date == "2007-02-01") | (data$Date == "2007-02-02"), ]
histdata <- sub ("?", "", filtdata$Global_active_power)
histdata <- as.numeric(histdata)

png(
  "plot1.png",
  width     = 480,
  height    = 480,
  units     = "px",
  res       = NA
)

hist(histdata, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

dev.off()

