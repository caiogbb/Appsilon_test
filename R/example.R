# Function using inside in this app

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



