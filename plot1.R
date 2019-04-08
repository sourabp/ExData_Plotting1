library(dplyr)

# Fetching Input dataset
get_input_data<-function(){
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile = 'input.zip')
  unzip('input.zip')
  df<-read.csv('household_power_consumption.txt', colClasses = 'character', sep = ';')%>%
    mutate(Date=as.Date(Date, '%d/%m/%Y'))
    
  feb_df<-filter(df, Date>='2007-02-01' & Date<'2007-02-03')
  return(feb_df)
}

file_name<-'plot1.png'
# Initiating PNG Device
png(filename = file_name, width = 480, height = 480, units="px")

# Building graph
ipdf<-get_input_data()
hist(as.numeric(ipdf$Global_active_power), col='red', main = "Global Active Power",xlab = 'Global Active Power(kilowatts)', ylab = 'Frequency')

dev.off()
