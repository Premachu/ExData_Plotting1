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

Create plot 1: a histogram of Global Active Power.
First convert the var from char to numeric

    powersub[,3] <- as.numeric(powersub[,3])
  
    hist(powersub[,3], col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

    dev.copy(png,"plot1.png", width=480, height=480)
    dev.off()