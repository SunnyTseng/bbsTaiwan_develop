
# main function -----------------------------------------------------------

### A function that you can input the chinese name of the species and look up for its scientific name based on bbs species list
bbs_translation <- function(species_name) {


  # sub function ----------------------------------------------------------

  decision <- function(species_name) {
    if(!species_name %in% (bird_info$chineseName |> unlist())) {
      return("The bird is not in the BBS list")
    }

    bird_name <- bird_info |>
      dplyr::mutate(in_out = purrr::map_lgl(.x = chineseName, .f =~ species_name %in% .x)) %>%
      dplyr::filter(in_out) %>%
      dplyr::pull(scientificName)
    return(bird_name)
  }


  # argument check --------------------------------------------------------

  checkmate::assert_character(
    species_name,
    min.len = 1,
    unique = TRUE
  )


  # main function body ----------------------------------------------------

  bird_name <- species_name |>
    map_chr(decision)

  return(bird_name)
}


# requires ----------------------------------------------------------------

### user package: dplyr, purrr
### local dataset: bbs dataset
