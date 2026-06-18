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

png('plot3.png')
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
  lty = 1
)
axis.POSIXct(1,
             at = seq(trunc(min(df$datetime)), trunc(max(df$datetime)) + days(1), by = 'day'),
             format = '%a')
dev.off()
