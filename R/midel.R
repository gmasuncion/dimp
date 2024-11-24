#' @title Multiple Imputation and Deletion
#' @description This function performs multiple imputation (including the outcome variable) and deletes any imputed outcome values prior to analysis.
#' @param x The raw dataset before imputation.
#' @param mice_obj <TODO>
#' @param y The desired outcome variable.
#' @return The imputed datasets with outcomes set back to NA, if they were initially missing.
#' @author Group A
#' @examples

library(mice)

dimp <- function(original_data, mice_obj, y){
  
  # Identify the indices of missing values in the original data for variable y
  missing_y_indices <- which(is.na(original_data[[y]]))
  
  # Retrieve the imputed datasets
  imputed_datasets <- complete(mice_obj, action = 'all')  # List of imputed datasets
  
  # Delete (set to NA) the values in the variable y where they were originally missing
  deleted_datasets <- lapply(imputed_datasets, function(df) {
    df[[y]][missing_y_indices] <- NA
    return(df)
  })
  
  return(deleted_datasets)
}