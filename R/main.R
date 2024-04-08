

source(here::here("R", "bbs_translation.R"))
source(here::here("R", "bbs_subset.R"))


bbs_translation(species = "紅頭山雀")
bbs_translation(species = "棕面鶯")

my_data <- bbs_GBIF_subset(folder = here::here("data", "dwca-bbstaiwan_dataset-v1.9"),
                           from = 2010,
                           to = 2012,
                           species_list = c("Aegithalos concinnus", "Abroscopus albogularis"))


library(terra)
