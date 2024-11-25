#' @title Multiple Imputation and Deletion
#' @description This function performs multiple imputation (including the outcome variable) and deletes any imputed outcome values prior to analysis.
#' @param x The raw dataset before imputation.
#' @param mice_obj <TODO>
#' @param y The desired outcome variable.
#' @return The imputed datasets with outcomes set back to NA, if they were initially missing.
#' @author Group A
#' @examples
#'<TODO>
#' @export

dimp <- function(mice_obj, y){
  original_data <- complete(mice_obj, action = 0)
  # Identify the indices of missing values in the original data for variable y
  missing_y_indices <- is.na(original_data[[y]])

  # Retrieve the imputed datasets in long format
  imputed_dataset <- complete(mice_obj, action = 'long', include=FALSE)

  # Delete (set to NA) the values in the variable y where they were originally missing
  imputed_dataset[[y]][rep(missing_y_indices, times = length(unique(imputed_dataset$.imp)))] <- NA

  original_data$.imp <- 0
  original_data$.id <- 1:nrow(original_data)
  imputed_data_combined <- rbind(original_data, imputed_dataset)
  mice_modified <- as.mids(imputed_data_combined)


  return(mice_modified)
}
