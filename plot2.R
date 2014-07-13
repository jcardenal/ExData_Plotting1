#turning off locale specific info
#this affects labels related to weekdays

Sys.setlocale("LC_MESSAGES", "C");
Sys.setlocale("LC_ALL", "C");

## Read file in data.frame directly from .zip format
## File location is assumed to be the same folder as this script
## It will take about 90 secs.

x <- read.table(unz("exdata_data_household_power_consumption.zip","household_power_consumption.txt"),sep=";",header=T,nrows=2075259,colClasses=c("character","character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?");

## convert Date from string to Date type

x$Date <- as.Date(x$Date,format="%d/%m/%Y");

## subset just for dates 2007-02-01 and 2007-02-02
d <-x[((x$Date == "2007-02-01") | (x$Date == "2007-02-02")),];

## convert Time to a meaningful Date data type
d$Time <- strptime(paste(d$Date,d$Time), format="%Y-%m-%d %H:%M:%S")

## open graphic device for png output
## default is 480 x 480 pixels as required
png("plot2.png");

## plot required graphic
plot(d$Time,d$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="");

## close device
dev.off();
