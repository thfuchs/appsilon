test_that("mod_output_info_ui", {
  expect_error(mod_output_info_ui())
  expect_s3_class(mod_output_info_ui("id"), "shiny.tag.list")
})

test_that("mod_output_info_server", {
  expect_true(inherits(mod_output_info_server, "function"))
})
