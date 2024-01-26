# Biodiversity Analysis Shiny App

<div align="right">
  <img src="/img/logo.png" alt="Your Logo" width="100">
</div>

Welcome to the Biodiversity Analysis Shiny App developed by Appsilon.

## Overview

This Shiny app is designed to analyze the biodiversity of species in Poland. It provides a map showing all possible points where animal species have been found, along with a time series showing when each species was documented by researchers.

## Instructions

1. **Choose the Scientific Name:**
   - In the top right corner, there is a field called 'Choose the Scientific Name'.
   - Click on the button called 'Search for the Scientific Name'.
   - The points on the map where the species was found will be shown, along with the number of species found in Poland.

2. **Choose the Vernacular Name:**
   - Use the option 'Choose the vernacular name' in the upper right corner.
   - After choosing, click on 'Search for the vernacular name'.
   - The map and time series will be generated.

3. **Explore and Enjoy:**
   - Use the app to explore different species and locations.
   - Send us your feedback about the app. Thank you!

## Installation and Run

1. Install required R packages:

   ```R
   install.packages(c("shiny", "shinydashboard", "leaflet", "dplyr", "plotly", "shinyjs", "fresh"))
