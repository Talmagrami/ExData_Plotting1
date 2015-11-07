# read the text file "household_power_consumption.txt" after uncompressed
DT <- read.table("./data/household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

# subset the data to include the first two days of Feb 2007 and remove useless data.
DT_Feb <- subset(DT, Date=="1/2/2007" | Date=="2/2/2007")
rm(DT)

datetime <- paste(DT_Feb$Date, DT_Feb$Time) ## Create new variable to combined 'Date' and 'Time' of DT.
DT_Feb <- cbind(datetime, DT_Feb) ## Bind new variable "datetime" to the DT
DT_Feb <- DT_Feb[,-c(2, 3)] ## Remove useless variables 
DT_Feb <- transform(DT_Feb, datetime = strptime(datetime, format = "%d/%m/%Y %H:%M:%S"))

# Plot four Scatterplots for Household Power Consumption data into file device PNG 'plot4.png'
png("./Projects/project1/plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

# Plot1
plot(DT_Feb$datetime, DT_Feb$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")

# Plot2
with(DT_Feb, {
  plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black", "red", "blue"), box.lty=0)
  box()
})

# Plot3
with(DT_Feb, plot(datetime, Voltage, type = "l"))

# Plot4
with(DT_Feb, plot(datetime, Global_reactive_power, type = "l"))

dev.off()