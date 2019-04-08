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

file_name<-'plot2.png'
# Initiating PNG Device
png(filename = file_name, width = 480, height = 480, units="px")

# Building graph
ipdf<-get_input_data()
plot(x=ipdf$timestamp, y=as.numeric(ipdf$Global_active_power), type='l')
dev.off()
