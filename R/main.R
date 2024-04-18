

# source the functions ----------------------------------------------------

source(here::here("R", "bbs_translation.R"))
source(here::here("R", "bbs_subset.R"))
source(here::here("R", "bbs_visualization.R"))


# call the package datasets -----------------------------------------------

load(file = here::here("data", "package_data", "bird_info.rda"))
load(file = here::here("data", "package_data", "tw_map.rda"))

# example code for demonstration ------------------------------------------

bbs_translation(species = c("小虎鶇", "台灣朱雀"))

occurrence_sub <- bbs_GBIF_subset(folder = here::here("data", "dwca-bbstaiwan_dataset-v1.9"),
                                  y_min = 2009,
                                  y_max = 2016,
                                  target_species = c("Zoothera dauma dauma", "Carpodacus formosanus"))

bird_plot <- bbs_visualization(data = occurrence_sub)
bird_plot

