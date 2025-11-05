library(readr)

metadatos_completos <- read_csv("https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/metadatos_completos.csv")
NH0472 <- read_csv("https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0472.csv")
NH0910 <- read_csv("https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0910.csv")
NH0046 <- read_csv("https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0046.csv")
NH0098 <- read_csv("https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0098.csv")
NH0437 <- read_csv("https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0437.csv")

usethis::use_data(metadatos_completos, NH0472, NH0910, NH0046, NH0098, NH0437, overwrite = TRUE)

