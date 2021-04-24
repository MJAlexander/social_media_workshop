# Welcome!

This website contains links to materials for a 2-hour 'Social Media Workshop for Population Research' workshop for [CAnD3 Fellows](https://www.mcgill.ca/cand3/) run in April 2021. The workshop provides R code examples of extracting, manipulating and analyzing Twitter data. You can also find all the code and related materials in the [GitHub repo](https://github.com/MJAlexander/social_media_workshop). 

# Set-up and preliminaries

This section covers what you will need to do before the workshop. Please make sure you have read through these instructions and materials before the workshop. 

## Twitter account

You need a Twitter account! This is required to authenticate your requests for Twitter data. If you don't already have an account, you can sign up here: https://twitter.com/.

## Required packages and test code

We will be using a lot of different packages, so before the workshop begins it would be great if you can make sure everything is installed and working. Briefly, the packages you will need installed are: 

- `tidyverse`
- `rtweet`
- `tidygeocoder`
- `sf`
- `leaflet`
- `tidytext`
- `lubridate`
- `scales`
- `here` (optional; makes it easier to deal with file paths if you are using RStudio Projects).

This R script covers the main things you need: [0_setup.R](https://github.com/MJAlexander/social_media_workshop/blob/main/code/0_setup.R).

Please try and run this before the workshop to make sure everything is working. 

## Revision of the tidyverse and ggplot

It is assumed you've seen R, the tidyverse and ggplot before. The following two R Markdown files give an overview of some key functions and plots that may be useful to revisit:

- [0a_intro_tidyverse](https://github.com/MJAlexander/social_media_workshop/blob/main/rmd/0a_intro_tidyverse.Rmd)
- [0b_ggplot_overview](https://github.com/MJAlexander/social_media_workshop/blob/main/rmd/0b_ggplot_overview.Rmd)

# Introduction

Slides coming soon. 

# Module 1: Extracting Twitter data

This module gives a brief overview of extracting information on users, topics and locations using the `rtweet` package. 

R Markdown file: [1_extract_tweets.Rmd](https://github.com/MJAlexander/social_media_workshop/blob/main/rmd/1_extract_tweets.Rmd).



