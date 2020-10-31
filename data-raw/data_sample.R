
#load dataset sample for demo purposes. The data on this sample is not real

require(readxl)

data_sample <- read_excel("data-raw/maturation.xlsx", sheet = "maturation")

usethis::use_data(data_sample, overwrite = TRUE)
