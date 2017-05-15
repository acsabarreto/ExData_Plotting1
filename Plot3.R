library(lubridate)
library(tidyverse)
holding <- read.table("household_power_consumption.txt", header = TRUE, skip = 66636, nrows = 2881, sep = ";", na.strings = c("?",""))
colnames(holding) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
holding <- mutate(holding, Date = dmy(Date)) %>% 
  mutate(
    Time = parse_time(Time),
    DateTime = ymd_hms(paste(Date,Time,' ')),
    Global_active_power = parse_number(Global_active_power),
    Global_reactive_power = parse_number(Global_reactive_power),
    Global_intensity = parse_number(Global_intensity),
    Sub_metering_1 = parse_number(Sub_metering_1),
    Sub_metering_2 = parse_number(Sub_metering_2),
    Sub_metering_3 = parse_number(Sub_metering_3)
  )
png("plot3.png")
with(holding, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub metering"))
with(holding, points(DateTime, Sub_metering_2, col="red", type = "l"))
with(holding, points(DateTime, Sub_metering_3, col="blue", type = "l"))
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty=1, lwd=2.5, col=c('black','red','blue')
)
dev.off()