
# this function reads the "household_power_consumption.txt" file, which is
# assumed to be in your current working directory and creates a "plot4.png"
# file (also in your current working directory)
plot4 <- function() {
    # file is large and we only want data in date range 2/1/2007 - 2/2/2007
    # so only read the line numbers that are in the date range (we know this by
    # opening up the file in a text editor first and finding the appropriate line numbers)
    library(data.table)    
    file            = "household_power_consumption.txt"
    firstLineNumber = 66638
    lastLineNumber  = 69517
    
    # get the headers only. then get the subset of lines we want. then put the headers on our data?
    df1 <- fread(file, sep=";", header=TRUE,  nrows=0)
    df2 <- fread(file, sep=";", header=FALSE, nrows=lastLineNumber-firstLineNumber+1, skip=firstLineNumber-1)    
    names(df2) <- names(df1)   
    
    # convert Date column to date type
    df2$Date <- as.Date(df2$Date, format="%d/%m/%Y")
    
    # add a datetime column to use in graphing
    t <- as.POSIXct(paste(df2$Date,df2$Time))
    df2 <- cbind(df2,t)       

    # plot the data, plot 4
    png(filename="plot4.png", height=480, width=480, bg="white")
    par(mfrow=c(2,2))
    plot(df2$t, df2$Global_active_power, type="l", ylab="Global Active Power", xlab="")
    par(new=F)
    plot(df2$t, df2$Voltage, ylab="Voltage", xlab="datetime", col="black", type="l")
    plot(df2$t, df2$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    par(new=T)
    lines(df2$t, df2$Sub_metering_2, col="red")
    par(new=T)
    lines(df2$t, df2$Sub_metering_3, col="blue")
    par(new=T)
    legend("topright", legend=c("Sub metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty=1, lwd=2, bty="n")    
    par(new=F)
    plot(df2$t, df2$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")    
    dev.off() # turn off device driver (to flush output to png)
}