# to speed up file load, colClasses are defined and used, which in turn requires setAs Data coercion function definition

setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
classes <- c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
epw_data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", colClasses = classes, header = TRUE)

# data is subsetted, then Time coerced to the right format

epw_data1 <- subset(epw_data, epw_data$Date <= as.Date("2007-02-02") & epw_data$Date >= as.Date("2007-02-01") )
epw_data1$Time  <- strptime(paste(as.character(epw_data1$Date), epw_data1$Time, sep = " "), "%Y-%m-%d %H:%M:%S")

# Plot 2
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
with(epw_data1, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)") )
dev.off()