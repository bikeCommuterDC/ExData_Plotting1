library(dplyr)
library(sqldf)

##Import Code##

setwd("C:/Users/rbechtel/Dropbox/Coursera/4_Exploratory_Data_Analysis/Project_1")


power_complete <-file("household_power_consumption.txt")

power_selected <- sqldf("select * from power_complete where Date =='1/2/2007' or Date = '2/2/2007'"
                        ,file.format = list(header = TRUE,sep = ";"))

#Convert Date and Time variables from character strings to date/time variable classes
power_selected$Date <-as.Date(power_selected$Date, format = "%d/%m/%Y")

power_selected$DateTimeChar <- paste(power_selected$Date, power_selected$Time)

power_selected$DateTime <-strptime(power_selected$DateTimeChar, format = "%Y-%m-%d %H:%M:%S" )

power_selected <- power_selected %>%
        select(-DateTimeChar)


##Code to create plot##

png("plot2.png", width = 480, height = 480)

with(power_selected,plot(x = DateTime
                         ,y = Global_active_power
                         ,type = "l"
                         ,xlab = ""
                         ,ylab = "Global Active Power (kilowatts)"))


dev.off()
