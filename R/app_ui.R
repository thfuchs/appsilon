#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#' @import shiny.semantic
#' @noRd
app_ui <- function(request) {
  tagList(
    add_external_resources(),
    semanticPage(
      grid(
        grid_template = grid_template(
          default = list(
            areas = rbind(
              c("title", "map"),
              c("input", "map"),
              c("description", "map"),
              c("statistics", "map")
            ),
            cols_width = c("400px", "1fr"),
            rows_height = c("50px", "220px", "100px", "auto")
          ),
          mobile = list(
            areas = rbind(
              "title",
              "input",
              "map",
              "description",
              "statistics"
            ),
            cols_width = c("100%"),
            rows_height = c("50px", "250px", "400px", "100px", "auto")
          )
        ),
        area_styles = list(
          title = "margin: 20px;", 
          input = "margin: 20px;",
          description = "margin: 20px",
          statistics = "margin: 20px"
        ),
        title = h2(icon("ship"), "Marine Data"),
        input = card(div(
          class = "content", 
          mod_input_vessel_ui("input_vessel_ui")
        )),
        description = card(div(
          class = "content", 
          mod_output_info_ui("output_info_ui")
        )),
        statistics = card(div(
          class = "content", 
          mod_output_stats_ui("output_stats_ui")
        )),
        map = mod_output_map_ui("output_map_ui")
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @importFrom shiny addResourcePath
#'
#' @noRd
add_external_resources <- function() {
  
  addResourcePath("www", system.file("app/www", package = "appsilon"))
 
  tags$head(
    # Favicon
    tags$link(rel = "shortcut icon", href = file.path("www", "favicon.ico")),
    # CSS file
    tags$link(rel = "stylesheet", type = "text/css", href = file.path("www", "style.css"))
  )
}
