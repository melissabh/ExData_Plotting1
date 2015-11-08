
# this function reads the "household_power_consumption.txt" file, which is
# assumed to be in your current working directory and creates a "plot3.png"
# file (also in your current working directory)
plot3 <- function() {
    # file is large and we only want data in date range 2/1/2007 - 2/2/2007
    # so only read the line numbers that are in the date range (we know this by
    # opening up the file in a text editor first and finding the appropriate line numbers)
    file            = "household_power_consumption.txt"
    library(data.table)    
    firstLineNumber = 66638
    lastLineNumber  = 69517
    
    # get the headers only. then get the subset of lines we want. then put the headers on our data
    df1 <- fread(file, sep=";", header=TRUE,  nrows=0)
    df2 <- fread(file, sep=";", header=FALSE, nrows=lastLineNumber-firstLineNumber+1, skip=firstLineNumber-1)    
    names(df2) <- names(df1)   
    
    # convert Date column to date type
    df2$Date <- as.Date(df2$Date, format="%d/%m/%Y")
    
    # add a datetime column to use in graphing
    t <- as.POSIXct(paste(df2$Date,df2$Time))
    df2 <- cbind(df2,t)       
    
    # plot the data, plot3
    png(filename="plot3.png", height=480, width=480, bg="white")
    plot(df2$t, df2$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    lines(df2$t, df2$Sub_metering_2, col="red")
    lines(df2$t, df2$Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty=1, lwd=2)    
    dev.off() # turn off device driver (to flush output to png)
}