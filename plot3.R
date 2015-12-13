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

Plot 3: scatterplot of submetering (three vars) over time. 
First I set up a blank canvas and then add each var one by one.

    plot(datetime, powersub[,7], type="n", ylab = "Energy sub metering", xlab = "")

Now add three plots of each var. type = 'l` makes a line plot.
Note that "points()" must be used once the canvas is set up.

    points(datetime, powersub[,7], type="l")
    points(datetime, powersub[,8], type="l", col = "red")
    points(datetime, powersub[,9], type="l", col = "blue")

Add legend. `lty` = line type. I.e solid line. For `legend =..` I subsetted the variable names to save my self writing them out. 

    legend("topright", lty = 1, col = c("black","blue", "red"), legend = names(powersub) [7:9])
    
    dev.copy(png,"plot3.png", width=480, height=480)
    dev.off()

