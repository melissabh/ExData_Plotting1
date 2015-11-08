
# this function reads the "household_power_consumption.txt" file, which is
# assumed to be in your current working directory and creates a "plot1.png"
# file (also in your current working directory)
plot1 <- function() {
    # file is large and we only want data in date range 2/1/2007 - 2/2/2007
    # so only read the line numbers that are in the date range (we know this by
    # opening up the file in a text editor first and finding the appropriate line numbers)
    library(data.table)
    file            = "household_power_consumption.txt"
    firstLineNumber = 66638
    lastLineNumber  = 69517

    # get the headers only. then get the subset of lines we want. then put the headers on our data
    df1 <- fread(file, sep=";", header=TRUE,  nrows=0)
    df2 <- fread(file, sep=";", header=FALSE, nrows=lastLineNumber-firstLineNumber+1, skip=firstLineNumber-1)    
    names(df2) <- names(df1)   
    
    # plot the data, plot1
    png(filename="plot1.png", height=480, width=480, bg="white")
    hist(df2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
    dev.off() # Turn off device driver (to flush output to png)
}