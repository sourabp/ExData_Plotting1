library(dplyr)

# Fetching Input dataset
get_input_data<-function(){
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile = 'input.zip')
  unzip('input.zip')
  df<-read.csv('household_power_consumption.txt', colClasses = 'character', sep = ';')%>%
    mutate(Date=as.Date(Date, '%d/%m/%Y'))
  
  feb_df<-filter(df, Date>='2007-02-01' & Date<'2007-02-03')%>%
    mutate(weekday = weekdays(Date))%>%
    mutate(timestamp = as.POSIXct(strptime(paste(Date, Time, sep=" "),"%Y-%m-%d %H:%M:%S")))
  
  return(feb_df)
}

file_name<-'plot4.png'

# Initiating PNG Device
png(filename = file_name, width = 480, height = 480, units="px")

par(mfrow=c(2,2))

# Building graph
ipdf<-get_input_data()
plot(x=ipdf$timestamp, y=as.numeric(ipdf$Global_active_power), type='l', ylab = "Global Active Power", xlab = "Timestamp")
plot(x=ipdf$timestamp, y=as.numeric(ipdf$Voltage), xlab = 'datetime', ylab = 'Voltage')

plot(x=ipdf$timestamp, y=as.numeric(ipdf$Sub_metering_1), type='l', ylab = "Energy sub metering", xlab = "Timestamp")
lines(x=ipdf$timestamp, y=as.numeric(ipdf$Sub_metering_2), col='red')
lines(x=ipdf$timestamp, y=as.numeric(ipdf$Sub_metering_3), col='blue')

legend(x = 1, y = 15, legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col = c('black','red','blue'))

plot(x=ipdf$timestamp, y=as.numeric(ipdf$Global_reactive_power), type='l', ylab = "Global_reactive_power", xlab = "Timestamp")

dev.off()
