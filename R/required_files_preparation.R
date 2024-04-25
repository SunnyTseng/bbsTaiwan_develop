

# BBS species list form Jerome Ko -----------------------------------------

bird_full_list <- readr::read_csv(here::here("data", "taiwan_species_list_2023.csv")) |>
  dplyr::rename(chinese_name_t = "中文名", english_name_t = "英文名", scientific_name_t = "學名")

bird_info <- readr::read_csv(here::here("data", "bbs_species_list_v0.csv")) |>
  dplyr::mutate(vernacularName_2023 = vernacularName) |>
  dplyr::mutate(vernacularName_2023 = stringr::str_replace_all(vernacularName_2023,
                                                               c("台" = "臺",
                                                                 "臺灣/大陸畫眉" = "臺灣畫眉",
                                                                 "白氏/虎斑地鶇" = "虎鶇",
                                                                 "小虎鶇" = "虎斑地鶇",
                                                                 "銹胸藍姬鶲" = "鏽胸藍姬鶲"))) |>
  dplyr::left_join(bird_full_list, by = dplyr::join_by(vernacularName_2023 == chinese_name_t)) |>
  dplyr::group_nest(scientificName) |>
  dplyr::mutate(chineseName = purrr::map(.x = data, .f =~ c(.x |> dplyr::pull(species_ori),
                                                            .x |> dplyr::pull(vernacularName),
                                                            .x |> dplyr::pull(vernacularName_2023)) |>
                                           unique() |>
                                           stats::na.omit())) |>
  dplyr::mutate(englishName = purrr::map_chr(.x = data, .f =~ .x |>
                                               dplyr::pull(english_name_t) |>
                                               unique())) |>
  dplyr::mutate(scientificName_t = purrr::map_chr(.x = data, .f =~ .x |>
                                                    dplyr::pull(scientific_name_t) |>
                                                    unique())) |>
  dplyr::select(scientificName, chineseName, englishName, scientificName_t)


save(bird_info, file = here::here("data", "package_data", "bird_info.rda"))



# # BBS site list from Jerome Ko --------------------------------------------
#
# site_info <- readr::read_csv(here::here("data", "bbs_site_list_v2.7.csv"), lazy = TRUE) |>
#   tidyr::drop_na("樣區編號...7") |>
#   dplyr::mutate(region = dplyr::case_when(
#     ELEV == 3 ~ 5,
#     ELEV == 2 ~ 4,
#     ELEV == 1 & HJHsiu3 == "West" ~ 3,
#     ELEV == 1 & HJHsiu3 == "East" ~ 2,
#     ELEV == 1 & HJHsiu3 == "North" ~ 1,
#     ELEV == 1 & HJHsiu3 == "Lanyu" ~ 6,
#     .default = 7
#   )) |>
#   dplyr::rename(site = "樣區編號...7",
#                 city = "縣市",
#                 district = "鄉鎮",
#                 location = "地點 (樣區名稱)",
#                 elevation = "樣區所屬海拔段")



# map of Taiwan -----------------------------------------------------------

## From: https://geodata.mit.edu/catalog/stanford-dz142zj5454
## CRS: lon/lat WGS 84 (EPSG:4326)



tw_map <- sf::st_read(here::here("data", "taiwan")) |>
  sf::st_crop(c(xmin = 118.1, xmax = 122.1,
                ymin = 21.55, ymax = 25.69))

save(tw_map, file = here::here("data", "package_data", "tw_map.rda"))


# elevation of Taiwan -----------------------------------------------------

## From: https://github.com/WanJyunChen/Taiwan_environmental_dataset
## CRS: lon/lat WGS 84 (EPSG:4326)

elev <- raster::raster(here::here("data", "G1km_TWD97-121_DTM_ELE.tif"))



# map of important bird region --------------------------------------------

## From: https://age.triwra.org.tw/Page/MapLayerDataList
## CRS: lon/lat WGS 84 (EPSG:4326)
## bird_map <- terra::vect(here::here("data", "重要野鳥棲地"))



# BBS data on GBIF  -------------------------------------------------------

# read data ---------------------------------------------------------------

folder = here::here("data", "dwca-bbstaiwan_dataset-v1.9")

event <- readr::read_tsv(paste0(folder, "/event.txt"), lazy = TRUE)
occurrence <- readr::read_tsv(paste0(folder, "/occurrence.txt"), lazy = TRUE)
measurementorfacts <- readr::read_tsv(paste0(folder, "/measurementorfacts.txt"), lazy = TRUE)
extendedmeasurementorfact <- readr::read_tsv(paste0(folder, "/extendedmeasurementorfact.txt"), lazy = TRUE)

save(event, file = here::here("data", "package_data", "event.rda"))
save(occurrence, file = here::here("data", "package_data", "occurrence.rda"))
save(measurementorfacts, file = here::here("data", "package_data", "measurementorfacts.rda"))
save(extendedmeasurementorfact, file = here::here("data", "package_data", "extendedmeasurementorfact.rda"))






