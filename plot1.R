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
          and save it into the same directory as the plot1.R script,
          then run plot1.R again.")
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
# for this plot, we don't need to cast date strings to date format
print("Subsetting to 1/2/2007 and 2/2/2007 data only...")
sourceTable <- subset(sourceTable, Date %in% c("1/2/2007", "2/2/2007"))
print("Done")

# build the plot
print("Building the histogram...")
hist(sourceTable$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="Red",
     main="Global Active Power",
     cex.axis = .8,
     cex.lab = .8)

# copy the plot into file
print("Saving the histogram as plot1.png...")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

print("Cleaning up...")
rm(sourceTable)

print("Done")


