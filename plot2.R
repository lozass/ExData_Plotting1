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
## Plot 2
png(file = "plot2.png")
plot(b$dateTimePOSIX, b$Global_active_power, type = "l", ylab ="Global Active Power (kilowatts)", xlab="")
dev.off()
## restore system's original locale
Sys.setlocale("LC_TIME", locale)