test_that("app_server", {
  server <- app_server
  expect_true(inherits(server, "function"))
  # Check that formals have not been removed
  fmls <- formals(app_server)
  for (i in c("input", "output", "session")){
    expect_true(i %in% names(fmls))
  }
})

testServer(app_server, {
  expect_null(r$test)
  expect_null(r$input_vessel$name)
  
  r$input_vessel$name <- "PALLAS GLORY"
  session$flushReact()
  expect_true(inherits(r$output_map$ships, "data.table"))
})
