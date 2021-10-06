#' Run the Shiny Application
#'
#' @param ... arguments to pass to shinyApp
#' @inheritParams shiny::shinyApp
#'
#' @export
run_app <- function(
  onStart = NULL,
  options = list(), 
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
) {
  shiny::shinyApp(
    ui = app_ui,
    server = app_server,
    onStart = onStart,
    options = options, 
    enableBookmarking = enableBookmarking, 
    uiPattern = uiPattern,
    ...
  )
}
