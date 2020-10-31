
#load tables data with intercept parameters from the Khamis-Roche method

require(readxl)

table <- read_excel("data-raw/maturation.xlsx", sheet = "table")

usethis::use_data(table, internal = TRUE, overwrite = TRUE)
