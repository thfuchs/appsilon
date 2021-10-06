library(data.table)

# read data
# fread("XXX/ships.csv", encoding = "UTF-8")

# Order based on Ship and Datetime
setorder(ships, SHIP_ID, DATETIME)

# Add lagged LAT and LON to calculate Distance
ships[, LAT_lag := shift(LAT, 1), by = SHIP_ID]
ships[, LON_lag := shift(LON, 1), by = SHIP_ID]

ships[
  , DISTANCE := geosphere::distHaversine(
  # , DISTANCE := geosphere::distVincentyEllipsoid(
    cbind(LON, LAT),
    cbind(LON_lag, LAT_lag)
  )
]

# set ID per group
ships[, id := rowid(SHIP_ID)]

# save to rda
save(ships, file = "data/ships.rda", compress = "xz")
