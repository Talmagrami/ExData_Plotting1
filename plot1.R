# read the text file "household_power_consumption.txt" after uncompressed
DT <- read.table("./data/household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

# subset the data to include the first two days of Feb 2007 and remove useless data.
DT_Feb <- subset(DT, Date=="1/2/2007" | Date=="2/2/2007")
rm(DT)

datetime <- paste(DT_Feb$Date, DT_Feb$Time) ## Create new variable to combined 'Date' and 'Time' of DT.
DT_Feb <- cbind(datetime, DT_Feb) ## Bind new variable "datetime" to the DT
DT_Feb <- DT_Feb[,-c(2, 3)] ## Remove useless variables 
DT_Feb <- transform(DT_Feb, datetime = strptime(datetime, format = "%d/%m/%Y %H:%M:%S"))

# Plot Histogram for Global Active Power data into file device PNG 'plot1.png'
png("./Projects/project1/plot1.png", width = 480, height = 480)
hist(DT_Feb$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()