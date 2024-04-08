

# BBS species list form Jerome Ko -----------------------------------------

bird_info <- readr::read_csv(here::here("data", "bbs_species_list_v0.csv")) |>
  dplyr::mutate(vernacularName = stringr::str_replace_all(vernacularName,
                                                          c("台" = "臺",
                                                            "臺灣/大陸畫眉" = "臺灣畫眉",
                                                            "白氏/虎斑地鶇" = "虎鶇")))


# BBS site list from Jerome Ko --------------------------------------------

site_info <- readr::read_csv(here::here("data", "bbs_site_list_v2.7.csv"), lazy = TRUE) |>
  tidyr::drop_na("樣區編號...7") |>
  dplyr::mutate(region = dplyr::case_when(
    ELEV == 3 ~ 5,
    ELEV == 2 ~ 4,
    ELEV == 1 & HJHsiu3 == "West" ~ 3,
    ELEV == 1 & HJHsiu3 == "East" ~ 2,
    ELEV == 1 & HJHsiu3 == "North" ~ 1,
    ELEV == 1 & HJHsiu3 == "Lanyu" ~ 6,
    .default = 7
  )) |>
  dplyr::rename(site = "樣區編號...7",
                city = "縣市",
                district = "鄉鎮",
                location = "地點 (樣區名稱)",
                elevation = "樣區所屬海拔段")


# map of Taiwan -----------------------------------------------------------

## From: https://geodata.mit.edu/catalog/stanford-dz142zj5454
## CRS: lon/lat WGS 84 (EPSG:4326)
tw_map <- terra::vect(here::here("data", "taiwan"))


# map of important bird region --------------------------------------------

## From: https://age.triwra.org.tw/Page/MapLayerDataList
## CRS: lon/lat WGS 84 (EPSG:4326)
bird_map <- terra::vect(here::here("data", "重要野鳥棲地"))
