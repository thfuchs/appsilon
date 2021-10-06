#' ships
#'
#' @docType data
#' @usage data(ships)
#' @keywords datasets
#'
#' @format A data.table with 3102887 rows and 20 variables (xz-compressed):
#' \describe{
#'   \item{LAT}{ship’s latitude}
#'   \item{LON}{ship’s longitude}
#'   \item{SPEED}{ship’s speed in knots}
#'   \item{COURSE}{ship’s course as angle}
#'   \item{HEADING}{ship’s compass direction}
#'   \item{DESTINATION}{ship’s destination (reported by the crew)}
#'   \item{FLAG}{ship’s flag}
#'   \item{LENGTH}{ship’s length in meters}
#'   \item{SHIPNAME}{ship’s name}
#'   \item{SHIPTYPE}{ship’s type}
#'   \item{SHIP_ID}{ship’s unique identifier}
#'   \item{WIDTH}{ship’s width in meters}
#'   \item{DWT}{ship’s deadweight in tones}
#'   \item{DATETIME}{date and time of the observation}
#'   \item{PORT}{current port reported by the vessel}
#'   \item{Date}{date extracted from DATETIME}
#'   \item{Week_nb}{week number extracted from date}
#'   \item{Ship_type}{ship’s type from SHIPTYPE}
#'   \item{Port}{current port assigned based on the ship’s location}
#'   \item{Is_parked}{indicator whether the ship is moving or not}
#'   \item{LAT_lag}{ship’s latitude lagged by 1}
#'   \item{LON_lag}{ship’s longitude lagged by 1}
#'   \item{DISTANCE}{ship’s distance (in meters) from last to current observation, measured by Haversine method}
#'   \item{id}{ids for SHIP_ID}
#' }
"ships"