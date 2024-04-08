

source(here::here("R", "bbs_translation.R"))
source(here::here("R", "bbs_subset.R"))


bbs_translation(species = "紅頭山雀")
bbs_translation(species = "棕面鶯")

my_data <- bbs_GBIF_subset(folder = here::here("data", "dwca-bbstaiwan_dataset-v1.9"),
                           from = 2010,
                           to = 2012,
                           species_list = c("Aegithalos concinnus", "Abroscopus albogularis"))


library(terra)
library(here)
library(tidyverse)
library(tidyterra)

## map of taiwan, from https://geodata.mit.edu/catalog/stanford-dz142zj5454
## CRS: lon/lat WGS 84 (EPSG:4326)
twmap <- terra::vect(here::here("data", "taiwan"))


## map of important bird region, from https://age.triwra.org.tw/Page/MapLayerDataList
## CRS: lon/lat WGS 84 (EPSG:4326)
birdmap <- terra::vect(here::here("data", "重要野鳥棲地"))


## create SpatExtent
aoi <- birdmap %>%
  ext() %>%
  + c(0 , 0.1, 0, -1)


## create map
distribution_map <- ggplot() +
  geom_spatvector(data = twmap %>% crop(aoi), fill = "white") +
  geom_spatvector(data = birdmap %>% crop(aoi), fill = "green", alpha = 0.2, colour = NA) +
  theme_bw()
distribution_map



