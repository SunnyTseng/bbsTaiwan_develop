

# source the functions ----------------------------------------------------

source(here::here("R", "bbs_translation.R"))
source(here::here("R", "bbs_subset.R"))
source(here::here("R", "bbs_visualization.R"))

source(here::here("R", "required_files_preparation.R"))

# example code for demonstration ------------------------------------------

bbs_translation(species = "山紅頭")
bbs_translation(species = "巨嘴鴉")

occurrence_sub <- bbs_GBIF_subset(folder = here::here("data", "dwca-bbstaiwan_dataset-v1.9"),
                                  from = 2010,
                                  to = 2012,
                                  species_list = c("Cyanoderma ruficeps", "Corvus macrorhynchos"))

bird_plot <- bbs_visualization(data = occurrence_sub)
bird_plot

