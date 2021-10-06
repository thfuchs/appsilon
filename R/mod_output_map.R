#' output_map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_output_map_ui <- function(id){
  ns <- NS(id)
  leafletOutput(ns("map"))
}
    
#' output_map Server Functions
#'
#' @param r communication parameter
#'
#' @import leaflet
#' @import data.table
#'
#' @noRd 
mod_output_map_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    r$output_map <- reactiveValues()
    ships <- appsilon::ships
    # data.table NOTES
    DISTANCE <- SHIPNAME <- DATETIME <- NULL
    
    output$map <- renderLeaflet({
      vessel <- r$input_vessel$name
      
      # create icon
      oceanIcon <- awesomeIcons(
        icon = "fa-ship", 
        library = "fa",
        markerColor = c("green", "red")
      )

      m <- if(is.null(vessel)) {
        # Initiate (Default) Map
        leaflet() %>% addTiles() %>% 
          # default to Warsaw :-)
          setView(lng = 21.0122, lat = 52.2297, zoom = 12)
      } else {
        # Recreate Map and add Markers as soon as Vessel is selected
        
        # Select the max distance and observation just before (start and end)
        max_val <- ships[SHIPNAME == vessel, max(DISTANCE, na.rm = TRUE)]
        max_val_id <- ships[SHIPNAME == vessel & DISTANCE == max_val, id, .SD[which.max(DATETIME)]]
        ships_selected <- ships[SHIPNAME == vessel & id %in% c(max_val_id - 1, max_val_id)]
        
        # Output data.table containing the two observations
        r$output_map$ships <- ships_selected
        
        # New Map
        leaflet(data = ships_selected) %>% addTiles() %>%  
          addAwesomeMarkers(
          lng = ~ LON, 
          lat = ~ LAT, 
          icon = oceanIcon,
          label = ~ "Click for more information",
          popup = ~ sprintf(
            "Last known <em>%s</em> point of <b>%s</b><br/>
            Travelling from %s to %s at %s knots.",
            ifelse(id == min(id), "departing", "arriving"),
            SHIPNAME, port, DESTINATION, SPEED
          )
        )
      }
      
      # Design Map with mapbox
      m <- m %>% 
        leaflet.mapboxgl::addMapboxGL(style = "mapbox://styles/mapbox/streets-v9") %>%
        addEasyButton(easyButton(
          icon = "fa-globe",
          title = "Zoom to Level 1",
          onClick = JS("function(btn, map){ map.setZoom(1); }")
        )) %>%
        addEasyButton(easyButton(
          icon = "fa-crosshairs",
          title = "Locate Me",
          onClick = JS("function(btn, map){ map.locate({setView: true}); }")
        ))
      
      m
    })
  })
}
