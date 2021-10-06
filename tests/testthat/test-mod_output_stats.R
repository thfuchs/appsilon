test_that("mod_output_stats_ui", {
  expect_error(mod_output_stats_ui())
  expect_s3_class(mod_output_stats_ui("id"), "shiny.tag.list")
})

test_that("mod_output_stats_server", {
  expect_true(inherits(mod_output_stats_server, "function"))
})

testServer(mod_output_stats_server, args = list(r = reactiveValues()), {

  session$setInputs(button = 1)
})
