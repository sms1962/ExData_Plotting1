# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot.
# Your code file should include code for reading the data so that the plot can be fully reproduced. 
# You should also include the code that creates the PNG file.

# Download & unzip file

temp <- tempfile() # temporary file for loading zip file in.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
hpc <- read.table(unz(temp,"household_power_consumption.txt"),header=T,sep=";",na.strings="?", stringsAsFactors=F)
# free memory
unlink(temp)
rm(temp)

# create new variable with date&time
hpc$DateTime <- paste(hpc$Date,hpc$Time)
# convert DateTime var to POSIXlt class
hpc$DateTime <- strptime(hpc$DateTime,format="%d/%m/%Y %H:%M:%S")
# subsetting rows from 2007-02-01 00:00:00 to -02-03 00:00:00
yhpc <- na.omit(hpc[hpc$DateTime >= as.POSIXlt("2007-02-01 00:00:00") & hpc$DateTime <= as.POSIXlt("2007-02-03 00:00:00"), ])

# set locale to us. Weekdays will'be in english
Sys.setlocale("LC_TIME","us")

# plot 3 
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
png(filename="plot3.png",width=480, height=480)
with(yhpc,plot(DateTime, Sub_metering_1,ylab="Energy sub metering",xlab="",type="l"))
with(yhpc,points(DateTime, Sub_metering_2,col="Red",type="l"))
with(yhpc,points(DateTime, Sub_metering_3,col="Blue",type="l"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","blue","red"),lwd=1)
dev.off()
