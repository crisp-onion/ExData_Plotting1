require(readr)
require(dplyr)
require(lubridate)
df <- read_delim(
  'household_power_consumption.txt',
  ';',
  col_types = list(
    col_date(format = "%d/%m/%Y"),
    't',
    'n',
    'n',
    'n',
    'n',
    'n',
    'n',
    'n'
  ),
  na = c("", "NA", '?')
) |> filter(Date == '2007-02-01' | Date == '2007-02-02') |>
  mutate(datetime = ymd_hms(paste(`Date`, `Time`)))

png('plot4.png')
par(mfrow = c(2, 2))

#topleft
plot(
  df$datetime,
  df$Global_active_power,
  type = 'l',
  xlab = "",
  ylab = 'Global Active Power',
  xaxt = 'n'
)
axis.POSIXct(1,
             at = seq(trunc(min(df$datetime)), trunc(max(df$datetime)) + days(1), by = 'day'),
             format = '%a')

#topright
plot(
  df$datetime,
  df$Voltage,
  type = 'l',
  xlab = 'datetime',
  ylab = 'Voltage',
  xaxt = 'n'
)
axis.POSIXct(1,
             at = seq(trunc(min(df$datetime)), trunc(max(df$datetime)) + days(1), by = 'day'),
             format = '%a')

#bottomleft
plot(
  df$datetime,
  df$Sub_metering_1,
  type = 'l',
  xlab = "",
  ylab = 'Energy sub metering',
  xaxt = 'n'
)
lines(df$datetime, df$Sub_metering_2, col = 'red')
lines(df$datetime, df$Sub_metering_3, col = 'blue')
legend(
  'topright',
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c('black', 'red', 'blue'),
  lty = 1,
  bty = 'n'
)
axis.POSIXct(1,
             at = seq(trunc(min(df$datetime)), trunc(max(df$datetime)) + days(1), by = 'day'),
             format = '%a')

#bottomright
plot(
  df$datetime,
  df$Global_reactive_power,
  type = 'l',
  xlab = "datetime",
  ylab = 'Global_reactive_power',
  xaxt = 'n'
)
axis.POSIXct(1,
             at = seq(trunc(min(df$datetime)), trunc(max(df$datetime)) + days(1), by = 'day'),
             format = '%a')

dev.off()
