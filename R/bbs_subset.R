
# main function -----------------------------------------------------------

bbs_GBIF_subset <- function(y_min = 2009, y_max = 2029, target_species = NULL) {


  # argument check ----------------------------------------------------------

  checkmate::assert_number(
    y_min,
    na.ok = FALSE,
    lower = 2009,
    upper = 2029
  )

  checkmate::assert_number(
    y_max,
    na.ok = FALSE,
    lower = 2009,
    upper = 2029
  )

  if (is.null(target_species)) {
    target_species <- bird_info %>% pull(scientificName)
  } else {
    checkmate::assert_character(
      target_species,
      min.len = 1
    )
  }

  # clean data --------------------------------------------------------------

  ## I guess there was a mixed up with both sheets. These codes needs to be updated once new data is up on GBIF

  event_info <- measurementorfacts |>
    dplyr::mutate(type = stringr::str_length(id)) |> # two lines to retain only event related measurement, like weather
    dplyr::filter(type == 23) |>
    dplyr::select(id, measurementType, measurementValue) |>
    tidyr::pivot_wider(names_from = measurementType,
                       values_from = measurementValue,
                       values_fn =~ dplyr::first(na.omit(.x))) |>
    dplyr::rename(weather = "天氣代號", wind = "風速代號", habitat = "棲地代號")

  occurrence_info <- extendedmeasurementorfact |>
    dplyr::mutate(type = stringr::str_length(id)) |> # two lines to retain occurrence related measurement, like
    dplyr::filter(type == 30) |>
    dplyr::select(id, measurementType, measurementValue) |>
    tidyr::pivot_wider(names_from = measurementType,
                       values_from = measurementValue,
                       values_fn =~ dplyr::first(na.omit(.x))) |>
    dplyr::rename(time_slot = "時段", distance = "距離", flock = "結群")

  site_info <- event |>
    dplyr::mutate(site = stringr::str_split_i(id, pattern = "_", i = 3)) |>
    dplyr::mutate(plot = stringr::str_split_i(id, pattern = "_", i = 4)) |>
    dplyr::select(site, plot, locationID, locality, decimalLatitude, decimalLongitude,
                  eventDate, eventTime) |>
    tidyr::drop_na() |>
    dplyr::distinct(site, plot, locationID, .keep_all = TRUE)

# site, city, district, location, region, elevation, X_wgs84, Y_wgs84

  # filter occurrence to a given species and year ---------------------------

  occurrence_filter <- occurrence |>
    dplyr::mutate(year = stringr::str_split_i(id, pattern = "_", i = 2) |> as.numeric()) |>
    dplyr::filter(year %in% seq(y_min, y_max)) |>
    dplyr::filter(scientificName %in% target_species) |>
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
                  eventDate, eventTime, weather, wind, habitat, time_slot, distance, flock,
                  site, plot, locationID, locality, decimalLatitude, decimalLongitude)

  return(list(occurrence = occurrence_add_var,
              site_info = site_info))
}


# requires ----------------------------------------------------------------

### user package: here, dplyr, readr, tidyr

