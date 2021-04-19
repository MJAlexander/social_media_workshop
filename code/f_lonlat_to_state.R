## Converts latitutde and longitude to provinces
## Source: https://stackoverflow.com/questions/8751497/latitude-longitude-coordinates-to-state-code-in-r

lonlat_to_state <- function(pointsDF,
                            states = canada_cd,
                            name_col = "PRNAME") {
  ## Convert points data.frame to an sf POINTS object
  pts <- st_as_sf(pointsDF, coords = 1:2, crs = 4326)
  
  ## Transform spatial data to some planar coordinate system
  ## (e.g. Web Mercator) as required for geometric operations
  states <- st_transform(states, crs = 3857)
  pts <- st_transform(pts, crs = 3857)
  
  ## Find names of state (if any) intersected by each point
  state_names <- states[[name_col]]
  ii <- as.integer(st_intersects(pts, states))
  state_names[ii]
}