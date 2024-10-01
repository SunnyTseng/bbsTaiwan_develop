

# installation and load  --------------------------------------------------

# install.packages("devtools")
# devtools::install_github("SunnyTseng/bbsTaiwan")
library(bbsTaiwan)



# demonstration of the functions ------------------------------------------

## bbs_plotmap
bbs_plotmap(NULL)


## bbs_sites
site_data <- bbs_sites()


## more about bbs_plotmap
bbs_plotmap("紅嘴黑鵯")
bbs_plotmap(c("烏頭翁", "白頭翁")) # have to put c() when putting more than one species
bbs_plotmap(c("烏頭翁", "白頭翁", "白喉笑鶇")) # you can add up to 5 species
bbs_plotmap(c("烏頭翁", "白頭翁", "臺灣白喉噪眉")) # different common names also work!


## bbs_history
bbs_history("plot") # check how many sites were surveyed each year
bbs_history() # the plot is the default setting
bbs_history("table") # but you can also get the table if you want


## bbs_fetch
bird_data <- bbs_fetch("家八哥") # fetch one single species data
?bbs_fetch # show how to use the help function when having questions


##
## additional analysis
##

library(poptrend)
library(tidyverse)

count <- bird_data %>%
  group_by(year) %>%
  summarize(averaged_count = mean(individualCount, na.rm = TRUE)) %>%
  drop_na() 
  # the plots that surveyed without Black Bulbul is also included

count_average <- count %>%
  ggplot() + 
  geom_col(aes(x = year, y = averaged_count)) +
  theme_bw()

count_average

model <- ptrend(data = bird_data,
                formula = individualCount ~ 
                  trend(year, k = 5, tempRE = TRUE, type = "smooth"))


plot(model, plotGrid = FALSE)


change(model, 
       min(bird_data$year, na.rm = TRUE), 
       max(bird_data$year, na.rm = TRUE))


# show the raw data -------------------------------------------------------

# Link to the BBS Taiwan website
# https://www.gbif.org/zh-tw/dataset/f170f056-3f8a-4ef3-ac9f-4503cc854ce0

occurrence
event
measurementorfacts



