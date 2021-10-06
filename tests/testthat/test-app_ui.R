test_that("app_ui", {
  ui <- app_ui()
  expect_s3_class(ui, "shiny.tag.list")
  # Check that formals have not been removed
  fmls <- formals(app_ui)
  for (i in c("request")){
    expect_true(i %in% names(fmls))
  }
})
