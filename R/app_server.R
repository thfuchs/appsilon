#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#' @import shiny
#' @import data.table
#' @noRd
app_server <- function( input, output, session ) {
  r <- reactiveValues()
  
  mod_input_vessel_server("input_vessel_ui", r = r)
  mod_output_map_server("output_map_ui", r = r)
  mod_output_info_server("output_info_ui", r = r)
  mod_output_stats_server("output_stats_ui", r = r)
}
