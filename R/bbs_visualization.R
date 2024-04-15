
# main function -----------------------------------------------------------

bbs_visualization <- function(data) {

  ## transform the data into spatial info
  all_site <- data$site_info |>
    terra::vect(geom=c("decimalLongitude", "decimalLatitude"), crs = "epsg:4326")

  bird_site <- data$occurrence |>
    dplyr::select(site, scientificName, decimalLatitude, decimalLongitude) |>
    dplyr::distinct(.keep_all = TRUE) |>
    tidyr::drop_na() |>
    terra::vect(geom=c("decimalLongitude", "decimalLatitude"), crs = "epsg:4326")

  ## create map
  distribution_map <- ggplot2::ggplot() +
    tidyterra::geom_spatvector(data = tw_map, fill = "white") +
    tidyterra::geom_spatvector(data = all_site, fill = "grey", alpha = 0.1) +
    tidyterra::geom_spatvector(data = bird_site, ggplot2::aes(col = scientificName), alpha = 0.3) +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position="bottom",
                   legend.title = ggplot2::element_blank())
}


# requires ----------------------------------------------------------------

### user package: terra, dplyr, tidyr, tidyterra, ggplot2
