library(testthat)
library(mice)
library(dimp)

test_that("dimp sets the originally missing 'Ozone' values to NA in all imputations", {

  mice_obj <- mice(airquality, m = 5, maxit = 5, seed = 123)

  mice_obj_deleted <- dimp(mice_obj, "Ozone")

  # This is the original data before imputation
  original_data <- complete(mice_obj, action = 0)

  # Calculate the number of missing values in the original 'Ozone' variable
  original_missing_ozone <- sum(is.na(original_data$Ozone))

  # Extract the imputed data (in long format) from the mice.mids object returned by dimp
  imputed_data <- complete(mice_obj_deleted, action = "long", include = FALSE)

  imputed_missing_ozone <- sapply(split(imputed_data$Ozone, imputed_data$.imp), function(x) sum(is.na(x)))

  expect_true(all(imputed_missing_ozone == original_missing_ozone),
              info = "Test Failed")
})
