##
## Prep
##

# set the working directory to script container
this.dir <- dirname(parent.frame(2)$ofile)
print(paste("Setting working directory to", this.dir))
setwd(this.dir)

# Download data
if(!file.exists("downloadData.R")) {
    print("The code to download the source file is missing.
          Get the downloadData.R script from the repository
          and save it into the same directory as the plot3.R script,
          then run plot3.R again.")
    stop
}

source("downloadData.R")


# Read data
print("Reading data as table into sourceTable variable...")
sourceTable <- read.table("household_power_consumption.txt",
                          sep = ";",
                          header = TRUE,
                          stringsAsFactors = FALSE,
                          dec = ".",
                          na.strings = c("?"))
print("Done")

# get only the dates we need
print("Subsetting to 1/2/2007 and 2/2/2007 data only...")
sourceTable <- subset(sourceTable, Date %in% c("1/2/2007", "2/2/2007"))
print("Done")

# convert date and time strings to date/time format
print("Combining the date and time strings into a new DateTime column...")
sourceTable$DateTime <- as.POSIXct(paste(as.Date(sourceTable$Date, format = "%d/%m/%Y"), sourceTable$Time))
print("Done")

# build the plot
print("Building the plot...")
plot(sourceTable$Sub_metering_1 ~ sourceTable$DateTime,
     col = "Black",
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     cex.axis = .8,
     cex.lab = .8
     )
lines(sourceTable$Sub_metering_2 ~ sourceTable$DateTime, col = "Red")
lines(sourceTable$Sub_metering_3 ~ sourceTable$DateTime, col = "Blue")
legend("topright",
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 3,
       cex = .8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
print("Done")

# copy the plot into file
print("Saving the plot as plot3.png")
dev.copy(png, file="plot3.png", height = 480, width = 480)
dev.off()

print("Cleaning up...")
rm(sourceTable)

print("Done")


