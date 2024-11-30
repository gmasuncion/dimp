library(mice)
library(dimp)

# Create a mids object
exampledata <- airquality
mice_obj <- mice(exampledata, m = 5, maxit = 5, seed = 123)

# Deletion
mice_obj_deleted <- dimp(mice_obj, "Ozone")

# Pooled model w/ deleted data
pool_mod <- pool(with(mice_obj_deleted, lm(Ozone ~ Wind + Temp + Month + Day)))
summary(pool_mod)
