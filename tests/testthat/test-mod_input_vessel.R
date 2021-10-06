test_that("mod_input_vessel_ui", {
  expect_error(mod_input_vessel_ui())
  expect_s3_class(mod_input_vessel_ui("id"), "shiny.tag.list")
})

test_that("mod_input_vessel_server", {
  expect_true(inherits(mod_input_vessel_server, "function"))
})

testServer(mod_input_vessel_server, args = list(r = reactiveValues()), {
  # Check calculation
  session$setInputs(id_ship_type = "Tanker")
  expect_equal(
    unique(ships[ship_type == input$id_ship_type, SHIPNAME]),
    unique(ships[ship_type == "Tanker", SHIPNAME])
  )
  
  # check "r" Output
  session$setInputs(id_vessel = "PALLAS GLORY")
  expect_equal(r$input_vessel$name, "PALLAS GLORY")
})
