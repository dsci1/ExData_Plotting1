##
# prep
##

# reset device settings
if(dev.cur() > 1) {
    print("Resetting device settings...")
    dev.off()
    print("Done")
}

# set the working directory to script container
this.dir <- dirname(parent.frame(2)$ofile)
print(paste("Setting working directory to", this.dir))
setwd(this.dir)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

dataFile <- "household_power_consumption.txt"

##
# download source data
##


if(!file.exists(dataFile)) {

    sourceFile <- "sourceData.zip"
    
    if(!file.exists(sourceFile)) {
        print(paste("Downloading source file from", url))
        download.file(url, sourceFile, mode = "wb")
    } else {
        print("Source ZIP file already downloaded")
    }
    
    print("Unzipping...")
    unzip(sourceFile, exdir = ".")
    print("Source file unzipped")
    
    if(!file.exists(dataFile)) {
        print("Something is wrong with the data file")
        unlink(sourceFile)
        unlink(dataFile)
        rm(this.dir, url, sourceFile, dataFile)
        stop
    } else {
        print("Data file ready")
        rm(sourceFile)
    }
} else {
    print("Data file already exists")
}

rm(this.dir, url, dataFile)
