#' @title Multiple Imputation and Deletion
#' @description This function performs multiple imputation (including the outcome variable) and deletes any imputed outcome values prior to analysis.
#' @param mice_obj A `mids` object created using the `mice()` function.
#' @param y The desired outcome variable.
#' @return The imputed datasets with outcomes set back to NA, if they were initially missing.
#' @author Mark Asuncion, Ting Lin, John Fei, Luke Bai, Jason Dang
#' @examples
#' # Load in the mice library
#' library(mice)
#'
#' # Create a mids object
#' data <- airquality
#' mice_obj <- mice(data, m = 5, maxit = 5, seed = 123)
#'
#' mice_obj_deleted <- dimp(mice_obj, "Ozone")
#' @export

dimp <- function(mice_obj, y){

  original_data <- complete(mice_obj, action = 0)

  # Identify observations with missing outcomes in the original dataset
  missing_y_indices <- is.na(original_data[[y]])

  # Retrieve the imputed datasets in long format
  imputed_dataset <- complete(mice_obj, action = 'long', include=FALSE)

  # Deletion (revert imputed outcome values back to NA)
  imputed_dataset[[y]][rep(missing_y_indices, times = length(unique(imputed_dataset$.imp)))] <- NA

  # Updating the datasets in the passed in mice() object
  original_data$.imp <- 0
  original_data$.id <- 1:nrow(original_data)
  imputed_data_combined <- rbind(original_data, imputed_dataset)
  mice_modified <- as.mids(imputed_data_combined)


  return(mice_modified)
}
