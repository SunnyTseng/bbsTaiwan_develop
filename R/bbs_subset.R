


file = "./data/0057383-240321170329656.csv"
from = 2010
to = 2012
species_list = c("Abroscopus albogularis", "Stachyridopsis ruficeps")


data_subset <- readr::read_tsv(file = file, lazy = TRUE) |>
  dplyr::filter(year %in% c(from, to)) |>
  dplyr::filter(species %in% species_list)


data_cleaned <- data_subset |>
