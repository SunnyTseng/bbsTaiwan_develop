

# BBS species list form Jerome Ko -----------------------------------------

bbs_species_v0 <- readr::read_csv(here::here("data", "bbs_species_list_v0.csv"))

bbs_species_v1 <- bbs_species_v0 |>
  dplyr::mutate(vernacularName = str_replace_all(vernacularName,
                                                 c("台" = "臺",
                                                   "臺灣/大陸畫眉" = "臺灣畫眉",
                                                   "白氏/虎斑地鶇" = "虎鶇")))

readr::write_csv(bbs_species_v1, here::here("data", "bbs_species_list_v1.csv"))
