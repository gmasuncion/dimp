
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Overview

`dimp` is a package that builds on the `mice` library, allowing users to
delete imputed values in a specified outcome variable. It contains one
primary function:

- `dimp()` modify and return a passed in `mids` object to delete imputed
  outcome values.

## Installation

``` r
# The easiest way to get dimp is to install the whole package via devtools:
install.packages("devtools")
libary(devtools)
devtools::install_github("gmasuncion/dimp")
library(dimp)
```

## Example

``` r
library(mice)
library(dimp)

# Create a mids object
exampledata <- airquality
mice_obj <- mice(exampledata, m = 5, maxit = 5, seed = 123)

# Deletion
mice_obj_deleted <- dimp(mice_obj, "Ozone") # datasets in this object have missing outcomes
```
