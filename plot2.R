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
          and save it into the same directory as the plot2.R script,
          then run plot2.R again.")
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
plot(sourceTable$Global_active_power ~ sourceTable$DateTime,
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type="l",
     cex.axis = .8,
     cex.lab = .8)
print("Done")

# copy the plot into file
print("Saving the plot as plot2.png...")
dev.copy(png, file="plot2.png", height = 480, width = 480)
dev.off()

print("Cleaning up...")
rm(sourceTable)

print("Done")


