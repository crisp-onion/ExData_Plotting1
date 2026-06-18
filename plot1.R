require(readr)
require(dplyr)
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
) |> filter(Date == '2007-02-01' | Date == '2007-02-02')

png('plot1.png')
hist(
  df$Global_active_power,
  col = 'red',
  xlab = "Global Active Power (kilowatts)",
  main = "Global Active Power"
)
dev.off()
