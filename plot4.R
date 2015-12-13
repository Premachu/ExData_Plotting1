Read in data 

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("data")){dir.create("data")}
download.file(url, destfile= "data/power.csv")
unzip("data/power.csv")

power <- read.table("household_power_consumption.txt", stringsAsFactors = F, sep = ";", header = T,)

Convert date and time variables to Date/Time class. 

power$Date <- as.Date(power$Date, "%d/%m/%Y") 

Subset data from  the dates 2007-02-01 and 2007-02-02 

condition <- which(power$Date == "2007-02-01" | power$Date == "2007-02-02")
powersub <- power[condition,]

create datetime variable 

x <- paste(powersub$Date,powersub$Time)
datetime <- strptime(x, "%Y-%m-%d %H:%M:%S")

plot 4: a plot with four charts. The fourth chart is Global Reactive Power over datetime. 

  par(mfrow = c(2, 2))
  
  
  plot(datetime, powersub$Global_active_power, type="l", ylab = "Global Active Power", xlab = "")
  
  
  plot(datetime, powersub$Voltage, type="l", ylab = "Voltage", xlab = "datetime")
  
  plot(datetime, powersub[,7], type="n", ylab = "Energy sub metering", xlab = "")
  points(datetime, powersub[,7], type="l")
  points(datetime, powersub[,8], type="l", col = "red")
  points(datetime, powersub[,9], type="l", col = "blue")
  
  plot(datetime, powersub$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")

  dev.copy(png,"plot4.png", width=480, height=480)
  dev.off()