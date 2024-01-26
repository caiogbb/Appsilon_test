# Shiny Module setup

# Shiny Module related the inputs and action button
filterModuleUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("name_type"), "Choose the name type:", choices = c("Vernacular" = "vernacularName", "Scientific" = "scientificName")),
    selectInput(ns("name_filter"), "Choose the name:", choices = NULL),
    actionButton(ns("render_button"), "Search by species")
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

# Shiny module for Maps
mapModuleUI <- function(id) {
  ns <- NS(id)
  leafletOutput(ns("mapa"), height = 500)
}

mapModule <- function(input, output, session, filtered_data) {
  ns <- session$ns
  
  output$mapa <- renderLeaflet({
    
    mapa_function(filtered_data())
    
  })
}

# Shiny Module for time series 
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
    
    time_series_function(time)
  })
}

# Shiny Module of count of species
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
