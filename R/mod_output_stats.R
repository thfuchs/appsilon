#' output_stats UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_output_stats_ui <- function(id){
  ns <- NS(id)
  
  tagList(
    shiny.semantic::action_button(
      input_id = ns("button"),
      label = "What's more to see?", 
      class = c("fluid", "secondary")
    )
  )
}
    
#' output_stats Server Functions
#'
#' @param r Communication parameter
#' @noRd 
mod_output_stats_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    observeEvent(input$button, {
      shiny.semantic::create_modal(shiny.semantic::modal(
        id = "simple-modal",
        header = h2("Important message"),
        "This is an important message!"
      ))
    })
  })
}
