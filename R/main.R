

# source the functions ----------------------------------------------------

source(here::here("R", "bbs_translation.R"))
source(here::here("R", "bbs_subset.R"))
source(here::here("R", "bbs_visualization.R"))


# example code for demonstration ------------------------------------------

bbs_translation(species = "白頭翁")
bbs_translation(species = "烏頭翁")

occurrence_sub <- bbs_GBIF_subset(folder = here::here("data", "dwca-bbstaiwan_dataset-v1.9"),
                                  from = 2010,
                                  to = 2012,
                                  species_list = c("Pycnonotus sinensis", "Pycnonotus taivanus"))

bird_plot <- bbs_visualization(data = occurrence_sub)
bird_plot

