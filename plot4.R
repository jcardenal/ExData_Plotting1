#turning off locale specific info
Sys.setlocale("LC_MESSAGES", "C");
Sys.setlocale("LC_ALL", "C");

## Read file in data.frame directly from .zip
## File location is assumed to be the same folder as this script
## It will take about 90 secs.

x <- read.table(unz("exdata_data_household_power_consumption.zip","household_power_consumption.txt"),sep=";",header=T,nrows=2075259,colClasses=c("character","character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?");

## convert Date from string to Date data type

x$Date <- as.Date(x$Date,format="%d/%m/%Y");

## subset just for dates 2007-02-01 and 2007-02-02
d <-x[((x$Date == "2007-02-01") | (x$Date == "2007-02-02")),];

## set Time to meaningful Date data type
d$Time <- strptime(paste(d$Date,d$Time), format="%Y-%m-%d %H:%M:%S")

## open graphic device for png output
## default is 480 x 480 pixels as required
png("plot4.png");

## Set layout for required graphics
## four graphics: upper-left, upper-right, bottom-left and bottom-right
par(mfrow = c(2, 2))

## plot the 4 required graphics

with(d, {
  ## This for plot upper-left
  plot(Time,Global_active_power,type="l",ylab="Global Active Power",xlab="")
  
  ## This for plot upper-right
  plot(Time,Voltage,type="l",ylab="Voltage",xlab="datetime")

  ## This for plot bottom-left
  plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
  points(Time, Sub_metering_2,type="l",col="red")
  points(Time,Sub_metering_3,type="l",col="blue")
  legend("topright",bty="n",lwd=1,lty=1,pch=NA,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"));

  ## This for plot bottom-right
  plot(Time,Global_reactive_power,type="l",xlab="datetime")  
  }
);

## close device
dev.off();
