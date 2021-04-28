##### Social Media Workshop ############
######## Monica Alexander ##############
#########  0. Set-up ###################

# The purpose of this script is to make sure you have all the required packages installed and make sure everything is working
# We will extract some tweets, geocode a location and map it, and do some sentiment analysis
# Below is a list of packages you will need to have installed. 
# If you don't have them installed, you can install them using "install.packages()"
# For example to install tidyverse, run install.packages("tidyverse")

# Load packages -----------------------------------------------------------

library(tidyverse)
library(here)
library(rtweet)
library(tidygeocoder)
library(leaflet)
library(tidytext)
library(lubridate)
library(scales)
library(sf)
library(ggmap)


# Twitter test ------------------------------------------------------------

### Below are a few lines of code to test that you have rtweet working. 
### NOTE: You must have a Twitter account!
### All users must be authenticated to interact with Twitter’s APIs. 
### The easiest way to authenticate is to use your personal twitter account 
### This will happen automatically (via a browser popup) the first time you use an rtweet function.
### Once you authenticate, you shouldn't have to do it again

# get Twitter info for monica's account.
# The monica_info object should be a tibble with dimensions 1 x 90
monica_info <- lookup_users("monjalexander") 

# extract location info
monica_info$location # should return "Toronto, Ontario"

# get most recent 1200 tweets
# The monica_timeline object should be a tibble of dimensions 1200 x 90
monica_timeline <- get_timeline("monjalexander", n = 1200)


# Geocode test ------------------------------------------------------------

monica_location <- tibble(location = monica_info$location)

monica_location <- monica_location %>% 
  tidygeocoder::geocode(address = location, 
          method = "osm")

# monica_location should be a tibble of dimensions 1 x 3

## check that we can correctly assign returned coordinates to the right province
## to do this we need the converter function and also the Canada map object
source("code/f_lonlat_to_state.R")
canada_cd <- st_read("data/canada_cd_sim.geojson", quiet = TRUE)

# this should return "Ontario"
lonlat_to_state(tibble(x = monica_location$long, y = monica_location$lat))


# Mapping test ------------------------------------------------------------

# should return an interactive map in the Viewer window with a pin that has a label "Toronto, Ontario"

leaflet() %>% 
  addTiles() %>% 
  addMarkers(lat = monica_location$lat,
             lng = monica_location$long,
             popup = monica_location$location)



# Tidytext test -----------------------------------------------------------

tidy_tweets <- monica_timeline %>% 
  mutate(tweet = row_number()) %>% 
  filter(is_retweet==FALSE) %>% 
  mutate(text = str_trim(str_replace_all(text, "@[A-Za-z0-9]+\\w+", ""))) %>% # remove twitter handles
  select(created_at, tweet, text) %>% 
  unnest_tokens(word, text)

tidy_tweets %>% 
  count(word, sort = TRUE) 

bing <- get_sentiments("bing")

# calculate the proportion of positive words in tweets by month
prop_positive <- tidy_tweets %>% 
  # the next three lines convert created_at just to month_year
  separate(created_at, into = c("date", "time"), sep = " ") %>% 
  separate(date, into = c("year", "month", "day"), sep = "-") %>% 
  mutate(month_year = my(paste(month, year))) %>% 
  select(month_year, tweet, word) %>% 
  inner_join(bing) %>% 
  group_by(month_year, sentiment) %>% 
  tally() %>% 
  group_by(month_year) %>% 
  summarise(prop_positive = n[sentiment == "positive"]/sum(n))

# plot! this should be a plot over time starting in about February 2020
ggplot(prop_positive, aes(month_year, prop_positive)) +
  geom_point(color = "darkblue", size = 3) + geom_line(color = "darkblue", lwd = 1.2)  +
  labs(title = "Positive words used in Monica's tweets", 
       subtitle = "Proportion of total words",
       x = "", y = "proportion") + 
  scale_x_date(labels = date_format("%m-%Y"))+ 
  theme_bw(base_size = 14)
