
# main function -----------------------------------------------------------

### A function that you can input the chinese name of the species and look up for its scientific name based on bbs species list
bbs_translation <- function(species) {

  bird_info |>
    dplyr::filter(species_ori == species) |>
    dplyr::pull(scientificName)
}


# requires ----------------------------------------------------------------

### user package: dplyr and readr
### local dataset: bbs dataset
