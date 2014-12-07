## save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")

## set English locale in order to have labels printed in English
Sys.setlocale("LC_TIME", "English")


## download file from source
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_comsumption.zip")
unzip("exdata_data_household_power_comsumption.zip")
a<-read.csv("household_power_consumption.txt", sep=";", na.strings="?")
## convert Date to PosiXlt
a$dateTime <- paste(a$Date, a$Time)
a$dateTimePOSIX<-strptime(a$dateTime, "%d/%m/%Y %H:%M:%S", tz="")
a$Date<-strptime(a$Date,"%d/%m/%Y",tz="")
## subset to desired dates
b <- subset(a, as.Date(a$Date) >= as.Date("2007-02-01") & as.Date(a$Date) <= as.Date("2007-02-02"))
## rm(a)
## adjust time variable to Posixlt
b$Time <- strptime(b$Time, "%H:%M:%S", tz="")
## build the plots
## Plot 3
png(file="plot3.png")
with(b, plot(dateTimePOSIX, Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
with(b, points(dateTimePOSIX, Sub_metering_1, type="l"))
with(b, points(dateTimePOSIX, Sub_metering_2, type="l", col="red"))
with(b, points(dateTimePOSIX, Sub_metering_3, type="l", col="blue"))
legend("topright", pch="", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
## restore system's original locale
Sys.setlocale("LC_TIME", locale)