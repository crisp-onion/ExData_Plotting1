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

png('plot2.png')
plot(
  df$datetime,
  df$Global_active_power,
  type = 'l',
  xlab = "",
  ylab = 'Global Active Power (kilowatts)',
  xaxt = 'n'
)
axis.POSIXct(1,
             at = seq(trunc(min(df$datetime)), trunc(max(df$datetime)) + days(1), by = 'day'),
             format = '%a')
dev.off()
