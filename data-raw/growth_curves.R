
#load growth curves data from CDC

require(readxl)

curves <- read_excel("data-raw/maturation.xlsx", sheet = "curves")

usethis::use_data(curves, overwrite = TRUE)
