test_that("mod_output_map_ui", {
  expect_error(mod_output_map_ui())
  expect_s3_class(mod_output_map_ui("id"), "shiny.tag.list")
})

test_that("mod_output_map_server", {
  expect_true(inherits(mod_output_map_server, "function"))
})

testServer(mod_output_map_server, args = list(r = reactiveValues()), {
  options(mapbox.accessToken = "pk.eyJ1IjoidGhvbWFzZnVjaHMiLCJhIjoiY2t1ZTdidWhuMWVxczJ2bXh5eGd6c3M5MiJ9.igHuJfSearKiaqlVM8pQKQ")
  
  # vessel NULL
  expect_true(inherits(output$map, "json"))
  output$map
  expect_null(r$output_map$ships)
  
  # vessel not NULL
  r$input_vessel$name <- "PALLAS GLORY"
  session$flushReact()
  expect_true(inherits(output$map, "json"))
  output$map
  
  # check "r" Output
  expect_true(inherits(r$output_map$ships, "data.table"))
  expect_equal(dim(r$output_map$ships), c(2, 24))
  expect_equal(unique(r$output_map$ships$SHIPNAME), "PALLAS GLORY")
})
