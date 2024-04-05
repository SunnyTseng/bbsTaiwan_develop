
# main function -----------------------------------------------------------

### A function that you can input the chinese name of the species and look up for its scientific name based on bbs species list
bbs_translation <- function(species) {
  bbs_species %>%
    dplyr::filter(species_ori == species) |>
    dplyr::pull(scientificName)
}



# example -----------------------------------------------------------------

bbs_species <- readr::read_csv("./data/bbs_species_list_v1.csv", lazy = TRUE)
bbs_translation(species = "灰喉山椒鳥")


# requires ----------------------------------------------------------------

### user package: dplyr and readr
### local dataset: bbs dataset
