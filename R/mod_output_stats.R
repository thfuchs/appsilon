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
      label = "Interested in the data?", 
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
    # data.table NOTES
    ship_type <- NULL
    ships <- appsilon::ships
    
    # Input Variable
    selection <- c("SPEED", "COURSE", "HEADING", "DESTINATION", "FLAG", "LENGTH", 
                   "SHIPNAME", "WIDTH", "DWT", "PORT", "date", "DISTANCE")
    
    # Modal in observer
    observeEvent(input$button, {
      if (is.null(r$input_vessel$type)) {
        shiny.semantic::toast(
          title = "Select a vessel type first",
          message = NULL,
          class = "red",
          duration = 3,
          action = list(list(text = "Sure", class = "fluid inverted", icon = "check"))
        )
        return(NULL)
      }
      type <- r$input_vessel$type
      
      shiny.semantic::create_modal(shiny.semantic::modal(
        id = "simple-modal", 
        header = h3(HTML(sprintf(
          "Create your statistics on the Marine Data Set for type <em>>>%s<<</em>",
          type
        ))),
        
        # Input
        shiny.semantic::selectInput(
          inputId = ns("id_select"), 
          label = "Select variables you would like to compare", 
          choices = selection, 
          selected = c("SPEED", "DISTANCE"),
          multiple = TRUE
        ),
        # Output
        uiOutput(ns("id_summary")),
        # Footer
        footer = grid(
          grid_template = grid_template(
            default = list(
              areas = cbind("source", "button"),
              cols_width = c("50%", "50%"),
              rows_height = c("auto")
            )
          ),
          area_styles = list(
            source = "text-align: left;", 
            button = "text-align: right;"
          ),
          source = shiny::tags$em(shiny::tags$a(
            "Additional information and explanations",
            href = "https://www.marinetraffic.com/blog/information-transmitted-via-ais-signal/",
            target = "_blank",
            style = "vertical-align: -moz-middle-with-baseline;"
          )),
          button = div(class = "ui button positive", HTML('<i class="fa fa-times"></i>'))
        )
      ))
    })
    
    # Summary statistics
    output$id_summary <- renderUI({
      req(input$id_select)
      
      user_selection <- input$id_select
      type <- r$input_vessel$type
      
      tryCatch(
        print(
          summarytools::dfSummary(
            ships[ship_type == type, .SD, .SDcols = user_selection],
            graph.magnif = 0.8,
            varnumbers = FALSE,
            headings = FALSE,
            display.labels = FALSE
          ),
          method = "render",
          omit.headings = TRUE,
          bootstrap.css = FALSE
        ),
        error = function(err) {
          print(err)
          return(div(
            "Oops...that should not have happened!", 
            style = "text-align: center; margin: 20px 20px 0; font-size: larger; color: red;"
          ))
        }
      )
    })
  })
}
