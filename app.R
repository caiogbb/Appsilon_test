# Load the libraries for Shiny App

library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(plotly)
library(shinyjs)


# Load dataset for Shiny App
data <- read.csv('arquivo.csv', h = TRUE) %>% 
  select(latitudeDecimal, longitudeDecimal, vernacularName, scientificName, locality, eventDate)


# Create the Bio App using the modules and Shinydashboard
ui <- dashboardPage(
  dashboardHeader(title = "Appsilon - Biodiversity"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
      column(width = 9,
             box(width = NULL, solidHeader = TRUE,
                 
                 useShinyjs(),  # Inicializa o shinyjs
                 
                 # Elemento para mostrar antes de pressionar o botão
                 div(id = "introscreen",
                     
                     h2("Welcome to the application developed to analyze the Biodiversity of species in Poland"),
                     "",
                     h4("This app aims to present a map showing all possible points where animal species have been found in Poland."),
                     "",
                     h4("Additionally, this application presents a time series showing which month and year this specifically was documented by researchers. This way, it is possible to identify at what time each species could possibly appear in each location on the map."),
                     "",
                     h2("Instructions:"),
                     "",
                     h4(" 1 - In the top right corner there is a field called 'Choose the Scientific Name'. In this case, you can choose which Scientific Name you want to investigate on the map. To view, click on the button called 'Search for the Scientific Name' and then the points on the map where the species was found will be shown and just below the button the number of species that were found in Poland will be shown."),
                     "",
                     h4(" 2 - The same is true for searching for a vernacular name, in this case you can change it by considering the option 'Choose the vernacular name' in the upper right corner and after choosing, click on 'Search for the vernacular name' and the map and time series will be generated."),
                     "",
                     h4(" 3 - Use without moderation! Enjoy exploring the species and send us your feedback about the app! Thank you")
                 ),
                 
                 br(),br(),
                 
                 div(id = "mapscreen",
                     mapModuleUI('mapModule')),
                 
                 br(),br(),
                 
                 div(id = "timemap",
                     timeSeriesModuleUI('timeSeriesModule')))),
      column(width = 3,
             
             box(width = NULL, status = "warning",
                 filterModuleUI('filterModule')),
             
             box(width = NULL, status = "info", 
                 speciesCountModuleUI('speciesCountModule')
        )
      )
    )
  )
)

# Shiny modules for building Bio App

server <- function(input, output, session) {
  
  filtered_data <- callModule(filterModule, "filterModule", data = data)
  
  callModule(mapModule, "mapModule", filtered_data = filtered_data)
  
  callModule(timeSeriesModule, "timeSeriesModule", filtered_data = filtered_data)
  
  callModule(speciesCountModule, "speciesCountModule", filtered_data = filtered_data)
  
}
# Run the Shiny Bio App
shinyApp(ui, server)
