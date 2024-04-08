

# source the functions ----------------------------------------------------

source(here::here("R", "bbs_translation.R"))
source(here::here("R", "bbs_subset.R"))


# example code for demonstration ------------------------------------------

bbs_translation(species = "白頭翁")
bbs_translation(species = "烏頭翁")



# parameters for development ----------------------------------------------

occurrence_sub <- bbs_GBIF_subset(folder = here::here("data", "dwca-bbstaiwan_dataset-v1.9"),
                                  from = 2010,
                                  to = 2012,
                                  species_list = c("Pycnonotus sinensis", "Pycnonotus taivanus"))


# main code for development -----------------------------------------------

## transform the data into spatial info
all_site <- site_info |>
  dplyr::select(site, X_wgs84, Y_wgs84) |>
  tidyr::drop_na() |>
  terra::vect(geom=c("X_wgs84", "Y_wgs84"), crs = terra::crs(tw_map))

bird_site <- occurrence_sub |>
  dplyr::select(site, scientificName, X_wgs84, Y_wgs84) |>
  dplyr::distinct(.keep_all = TRUE) |>
  tidyr::drop_na() |>
  terra::vect(geom=c("X_wgs84", "Y_wgs84"), crs = terra::crs(tw_map))

## create map
distribution_map <- ggplot2::ggplot() +
  tidyterra::geom_spatvector(data = tw_map, fill = "white") +
  #tidyterra::geom_spatvector(data = bird_map, fill = "green", alpha = 0.2, col = NA) +
  tidyterra::geom_spatvector(data = all_site, fill = "grey", alpha = 0.1) +
  tidyterra::geom_spatvector(data = bird_site, ggplot2::aes(col = scientificName)) +
  ggplot2::theme_bw()


distribution_map



