plot2  <- function(makePNG = TRUE) {
  ## Goal: examine how household energy usage varies over a 2-day period 
  ## Plot the global active power timeline
  
  ## File Description: Measurements of electric power consumption in one household with a one-minute sampling rate 
  ## over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
  
  # The dataset has 2,075,259 rows and 9 columns.
  # We will only be using data from the dates 2007-02-01 and 2007-02-02 ==> 2 days ==> 60 minutes * 24 hours *2 days = 2880 data
  
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
    png(filename="plot2.png")  # set as graphics device a PNG file
  }
    # plot the timeline
  plot(energy$DateTime, energy$Global_active_power, type="l",
       main="Global Active Power by date and time", xlab="", ylab="Global Active Power (kilowatts)")
  
  if (makePNG == TRUE) {
    dev.off() # close and save the graphics device
  }
}
plot2(FALSE) # plot on screen
plot2(TRUE)  # plot on file
