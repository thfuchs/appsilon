#' output_info UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_output_info_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(outputId = ns("ui"))
  )
}
    
#' output_info Server Functions
#'
#' @param r communication parameter
#'
#' @noRd 
mod_output_info_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    # data.table NOTES
    DISTANCE <- SHIPNAME <- NULL
    
    output$ui <- renderUI({
      ships_selected <- r$output_map$ships
      req(ships_selected)
      
      p(HTML(sprintf(
        "The longest distance between 2 observations <b>%s</b> sailed is <b>%sm</b>.",
        ships_selected[2, SHIPNAME],
        format(round(ships_selected[2, DISTANCE]), big.mark = ",")
      )))
    })
  })
}
