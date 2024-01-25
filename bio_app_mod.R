# Load the libraries
library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(plotly)
library(shinyjs)
library(sass)


# Load dataset
data <- read.csv('arquivo.csv', h = TRUE) %>% 
  select(latitudeDecimal, longitudeDecimal, vernacularName, scientificName, locality, eventDate)

# Módulo de Filtro
filterModuleUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("name_type"), "Choose the name type:", choices = c("Vernacular" = "vernacularName", "Scientific" = "scientificName")),
    selectInput(ns("name_filter"), "Choose the name:", choices = NULL),
    actionButton(ns("render_button"), "Renderizar")
  )
}

filterModule <- function(input, output, session, data) {
  ns <- session$ns
  
  # Crie vetores contendo scientificName e vernacularName
  namesscientific <- sort(unique(data$scientificName))
  namesvernacular<- sort(unique(data$vernacularName))
  namesvernacular <- namesvernacular[-1]
  
  observeEvent(input$name_type, {
    if (input$name_type == "vernacularName") {
      updateSelectInput(session, "name_filter", choices = namesvernacular)
    } else if (input$name_type == "scientificName") {
      updateSelectInput(session, "name_filter", choices = namesscientific)
    }
  })
  
  filtered_data <- eventReactive(input$render_button, {
    req(input$name_filter)
    data[data[[input$name_type]] == input$name_filter, ]
  })
  
  return(filtered_data)
}

# Módulo do Mapa
mapModuleUI <- function(id) {
  ns <- NS(id)
  leafletOutput(ns("mapa"), height = 500)
}

mapModule <- function(input, output, session, filtered_data) {
  ns <- session$ns
  
  output$mapa <- renderLeaflet({
    leaflet(filtered_data()) %>%
      addTiles() %>%
      addMarkers(~longitudeDecimal, 
                 ~latitudeDecimal, 
                 label = ~locality)
  })
}

# Módulo de Série Temporal
timeSeriesModuleUI <- function(id) {
  ns <- NS(id)
  plotly::plotlyOutput(ns("time"))
}

timeSeriesModule <- function(input, output, session, filtered_data) {
  ns <- session$ns
  
  time_series <- reactive({
    grouped_data <- filtered_data() %>% 
      group_by(eventDate) %>% 
      count()
  })
  
  output$time <- plotly::renderPlotly({
    
    time <- time_series()
    
    time$eventDate <- as.Date(as.character(time$eventDate), format = "%Y-%m-%d")
    
    time <- as.data.frame(time)
    
    fig <- plot_ly(time, type = 'scatter', mode = 'lines+markers')%>%
      
      add_trace(x = ~eventDate, y = ~n)%>%
      
      layout(showlegend = F, 
             title = paste0('Time series of observed species'),
             xaxis = list(title = 'Data of observed event'),
             yaxis = list(title = 'Count'))
  })
}

# Módulo de Contagem de Espécies
speciesCountModuleUI <- function(id) {
  ns <- NS(id)
  textOutput(ns("num_linhas"))
}

speciesCountModule <- function(input, output, session, filtered_data) {
  ns <- session$ns
  
  species_count <- reactive({
    nrow(filtered_data())
  })
  
  output$num_linhas <- renderText({
    paste0("NUMBER OF OBSERVED SPECIES", ": ", species_count())
  })
}

# Create the Bio App using the modules
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
                     timeSeriesModuleUI('timeSeriesModule'))
             )),
             column(width = 3,
                    box(width = NULL, status = "warning",
                        filterModuleUI('filterModule')
                    ),
                    box(width = NULL, status = "info", 
                        speciesCountModuleUI('speciesCountModule')
                    )
                    
             )
      
    )
  ))
  
  server <- function(input, output, session) {
    
    filtered_data <- callModule(filterModule, "filterModule", data = data)
    
    callModule(mapModule, "mapModule", filtered_data = filtered_data)
    
    callModule(timeSeriesModule, "timeSeriesModule", filtered_data = filtered_data)
    
    callModule(speciesCountModule, "speciesCountModule", filtered_data = filtered_data)
    
  }
  # Run the Shiny App
  shinyApp(ui, server)
  