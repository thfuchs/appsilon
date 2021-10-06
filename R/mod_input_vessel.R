#' input_vessel UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_input_vessel_ui <- function(id){
  ns <- NS(id)
  ships <- appsilon::ships
  
  tagList(
    h3("Select a vessel type:"),
    shiny.semantic::dropdown_input(
      input_id = ns("id_ship_type"), 
      choices = unique(ships$ship_type),
      default_text = "Vessel type"
    ),
    h3("Select a vessel:"),
    shiny.semantic::dropdown_input(
      input_id = ns("id_vessel"),
      choices = unique(ships$SHIPNAME), 
      default_text = "Vessel"
    )
  )
}
    
#' input_vessel Server Functions
#'
#' @param r communication parameter
#'
#' @noRd 
mod_input_vessel_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    r$input_vessel <- reactiveValues()
    ships <- appsilon::ships
    # data.table NOTES
    ship_type <- SHIPNAME <- NULL
    
    observe({
      req(input$id_ship_type)
      shiny.semantic::update_dropdown_input(
        session = session,
        input_id = "id_vessel",
        choices = unique(ships[ship_type == input$id_ship_type, SHIPNAME])
      )
    })
    
    # Module Output
    observe({
      req(input$id_ship_type)
      r$input_vessel$type <- input$id_ship_type
    })
    observe({
      req(input$id_vessel)
      r$input_vessel$name <- input$id_vessel
    })
    
  })
}
