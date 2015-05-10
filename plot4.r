plot4  <- function(makePNG = TRUE) {
  ## Goal: examine how household energy usage varies over a 2-day period 
  
  ## File Description: Measurements of electric power consumption in one household with a one-minute sampling rate 
  ## over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
  
  # The dataset has 2,075,259 rows and 9 columns.
  # We will only be using data from the dates 2007-02-01 and 2007-02-02 ==> 2 days ==> 60 minutes * 24 hours *2 days = 2880
  
  # read data
  energy <- read.table("household_power_consumption.txt", sep=";", 
                       skip=grep("31/1/2007;23:59:00",readLines("household_power_consumption.txt")), nrows=2880)
  # label columns
  colnames(energy) = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                       "Sub_metering_1", "Sub_metering_2","Sub_metering_3")
  
  # convert the Date and Time variables to Date/Time classes in R 
  energy$DateTime  <- paste(energy$Date, energy$Time)
  energy$DateTime  <- strptime(energy$DateTime, format="%d/%m/%Y %H:%M:%S")
  
  if (makePNG == TRUE) {
    png(filename="plot4.png")  # set as graphics device a PNG file
  }
    # set the parameters to allow a grid of multile plots
  par(mfrow=c(2,2))  # two rows and two columns
  
    # first row, first column
  plot(energy$DateTime, energy$Global_active_power, type="l", xlab="", ylab="Global Active Power")
   
    # first row, second column
  plot(energy$DateTime, energy$Voltage, type="l", xlab="", ylab="Voltage")
  
    # second row, first column
  plot(energy$DateTime, energy$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(energy$DateTime, energy$Sub_metering_2, col="red")
  lines(energy$DateTime, energy$Sub_metering_3, col="blue") 
      # add the legend
  legend("topright", legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col=c("black","red", "blue"), lwd=1,bty="n")
  
    # second row, second column
  plot(energy$DateTime, energy$Global_reactive_power, type="l", xlab="", ylab="Global reactive power")
  
  if (makePNG == TRUE) {
    dev.off() # close and save the graphics device
  }
}
plot4(FALSE) # plot on screen
plot4(TRUE)  # plot on file
