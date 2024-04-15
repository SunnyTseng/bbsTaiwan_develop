
# main function -----------------------------------------------------------

bbs_GBIF_subset <- function(folder, from, to, species_list) {

  # read data ---------------------------------------------------------------

  event <- readr::read_tsv(paste0(folder, "/event.txt"), lazy = TRUE)
  occurrence <- readr::read_tsv(paste0(folder, "/occurrence.txt"), lazy = TRUE)
  measurementorfacts <- readr::read_tsv(paste0(folder, "/measurementorfacts.txt"), lazy = TRUE)
  extendedmeasurementorfact <- readr::read_tsv(paste0(folder, "/extendedmeasurementorfact.txt"), lazy = TRUE)


  # clean data --------------------------------------------------------------

  ## Q1 The measurementorfacts is exactly the same as extended measurementorfact
  ## Q2 There are some non-systematic naming in the id column, a mixed id for event and occurrence
  ## Q3 There are some id with duplicated weather measurement
  ## I guess there was a mixed up with both sheets. These codes needs to be updated once new data is up on GBIF

  event_info <- measurementorfacts |>
    dplyr::mutate(type = stringr::str_length(id)) |> # two lines to retain only event related measurement, like weather
    dplyr::filter(type == 23) |>
    dplyr::select(id, measurementType, measurementValue) |>
    tidyr::pivot_wider(names_from = measurementType, values_from = measurementValue) |>
    dplyr::rename(weather = "天氣代號", wind = "風速代號", habitat = "棲地代號")

  occurrence_info <- extendedmeasurementorfact |>
    dplyr::mutate(type = stringr::str_length(id)) |> # two lines to retain occurrence related measurement, like
    dplyr::filter(type == 30) |>
    dplyr::select(id, measurementType, measurementValue) |>
    tidyr::pivot_wider(names_from = measurementType, values_from = measurementValue) |>
    dplyr::rename(time_slot = "時段", distance = "距離", flock = "結群")

  site_info <- event |>
    dplyr::mutate(site = stringr::str_split_i(id, pattern = "_", i = 3)) |>
    dplyr::mutate(plot = stringr::str_split_i(id, pattern = "_", i = 4)) |>
    dplyr::select(site, plot, locationID, locality, decimalLatitude, decimalLongitude) |>
    tidyr::drop_na() |>
    dplyr::distinct(site, plot, locationID, .keep_all = TRUE)

# site, city, district, location, region, elevation, X_wgs84, Y_wgs84

  # filter occurrence to a given species and year ---------------------------

  occurrence_filter <- occurrence |>
    dplyr::mutate(year = stringr::str_split_i(id, pattern = "_", i = 2) |> as.numeric()) |>
    dplyr::filter(year %in% c(from, to)) |>
    dplyr::filter(scientificName %in% species_list) |>
    dplyr::mutate(locationID =
                    paste0(stringr::str_split_i(id, pattern = "_", i = 3)
                           ,"_",
                           stringr::str_split_i(id, pattern = "_", i = 4)))



  # link event info, occurrence info, bird info, and site info --------------

  occurrence_add_var <- occurrence_filter |>
    dplyr::left_join(event_info, by = dplyr::join_by(id == id)) |>
    dplyr::left_join(occurrence_info, by = dplyr::join_by(occurrenceID == id)) |>
    dplyr::left_join(site_info, by = dplyr::join_by(locationID == locationID)) |>
    dplyr::select(year, eventID, occurrenceID, scientificName, vernacularName, individualCount,
                  weather, wind, habitat, time_slot, distance, flock,
                  site, plot, locationID, locality, decimalLatitude, decimalLongitude)

  return(list(occurrence = occurrence_add_var,
              site_info = site_info))
}


# requires ----------------------------------------------------------------

### user package: here, dplyr, readr, tidyr

