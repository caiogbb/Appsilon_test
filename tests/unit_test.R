# Load required libraries
library(testthat)
library(plotly)
library(leaflet)

# The importante Functions using inside in this app

mapa_function <- function(x){
  
  'mapa_function: It is a function that builds graphs using the latitude and longitude of where the species were observed.'
  'x: The dataframe contain latitude and longitude and names of species'
  
  fig <- leaflet(x) %>%
    addTiles() %>%
    addMarkers(~longitudeDecimal, 
               ~latitudeDecimal, 
               label = ~locality)
}

time_series_function <- function(time){
  
  'time_series_function: It is a function that builds time series graphs of species observation events over time'
  'time: The dataframe that contains the count of observed species and the date'
  
  time$eventDate <- as.Date(as.character(time$eventDate), format = "%Y-%m-%d")
  
  time <- as.data.frame(time)
  
  fig <- plot_ly(time, type = 'scatter', mode = 'lines+markers')%>%
    
    add_trace(x = ~eventDate, y = ~n)%>%
    
    layout(showlegend = F, 
           title = paste0('Time series of observed species'),
           xaxis = list(title = 'Data of observed event'),
           yaxis = list(title = 'Count'))
  
}

test_that("mapa_function produces expected output", {
  # Create a sample dataframe
  sample_data <- data.frame(
    latitudeDecimal = c(40.7128, 34.0522, 41.8781),
    longitudeDecimal = c(-74.0060, -118.2437, -87.6298),
    locality = c("New York", "Los Angeles", "Chicago")
  )
  
  map_figure <- mapa_function(sample_data)

  expect_true(inherits(map_figure, "leaflet"))
  

})

test_that("time_series_function produces expected output", {
  sample_data <- data.frame(
    eventDate = as.Date(c("2022-01-01", "2022-01-02", "2022-01-03")),
    n = c(10, 15, 8)
  )
  
  plot_figure <- time_series_function(sample_data)

  expect_true(inherits(plot_figure, "plotly"))
  
})

