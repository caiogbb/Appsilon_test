# Load the libraries for Shiny App

library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(plotly)
library(shinyjs)
library(fresh)

# Build UI/Ux designer of the App

mytheme <- create_theme(
  adminlte_color(
    teal = "#008080",  
    green = "#6FA761", 
    light_blue = "#77B5FE",  
    navy = "#002244",  
    blue = "#2F4F4F" 
  ),
  adminlte_sidebar(
    width = "400px",
    dark_bg = "#004080",  
    dark_hover_bg = "#002244",  
    dark_color = "#FFFFFF"  
  ),
  adminlte_global(
    content_bg = "#FFFFFF", 
    box_bg = "#D3E4F9", 
    info_box_bg = "#F0F8FF"  
  )
)


# Load dataset for Shiny App
data <- read.csv('arquivo.csv', h = TRUE) %>% 
  select(latitudeDecimal, longitudeDecimal, vernacularName, scientificName, locality, eventDate)


# Create the Bio App using the modules and Shinydashboard
ui <- dashboardPage(
  dashboardHeader(title = "Appsilon - Biodiversity"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    
    use_theme(mytheme),
    
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
                     h4("In the top right corner there is a field called 'Choose name type'. In this case, you can choose whether you want to search the map for the ScientificName or vernacularName you want to investigate. Then, choose which species name in 'choose the name' you want to search for and when choosing, click on the button called 'Search by species' and the points on the map where the species was found will be shown and just below the button a timeline will be shown (time series) of the number of species that have been found in Poland."),
                     "",
                     h4("2 - Note that the map and time series will only appear or update when you choose the vernacularName or scientificname option and the specific name and click the button! Only when you click the button will the results be shown!"),
                     "",
                     h4("3 - Use without moderation! Enjoy exploring the species and send us your feedback about the app! Thank you")
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
