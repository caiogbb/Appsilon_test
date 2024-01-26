# Biodiversity Shiny App

<div align="right">
  <img src="/logo.jpg" alt="Your Logo" width="200">
</div>

Welcome to the Biodiversity Analysis Shiny App developed by Appsilon.

<div align="center">
  <img src="app.png" alt="Biodiversity App Screenshot" width="800">
</div>




# Overview

**The App was deployed on AWS, to access the deployment see:**: http://3.144.225.25:3838/Appsilon_test/

# Completed Tasks

- [x] Presented an application capable of searching for species by their vernacular name and scientific name
- [x] Included a visualization of a timeline when selected species were observed
- [x] Implemented the App using shinyModules
- [x] Unit tests have been added for the most important functions and cover edge cases
- [X] Beautiful UI Skill was made available using the help of the Fresh library, available on CRAN
- [X] Infrastructure skill was developed, considering that the application was deployed on my personal machine on AWS
      

## Instructions for New Developers

If you are a new developer contributing to this project, follow these steps to set up your development environment:

### Prerequisites

- R installed on your machine. You can download it from [CRAN](https://cran.r-project.org/).

-  Download RStudio: Visit the [RStudio download page](https://www.rstudio.com/products/rstudio/download/).
   - Choose the appropriate version for your operating system (Windows, macOS, or Linux).
   - Download and run the installer.

### Clone the Repository

```bash
git clone https://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@github.com/caiogbb/Appsilon_test.git
```

# Application infrastructure

2. Open the `app.R` file in the RStudio editor. This is the main script that contains all the necessary libraries and code for the Biodiversity Analysis Shiny App.

3. Look for the library installations at the top of the script. They may look like this:

   ```R
   # Install required packages if not already installed
   required_packages <- c("shiny", "shinydashboard", "leaflet", "dplyr", "plotly", "shinyjs", "fresh", "sparklyr")

   installed_packages <- installed.packages()
   missing_packages <- required_packages[!(required_packages %in% installed_packages[, "Package"])]

   if (length(missing_packages) > 0) {
     install.packages(missing_packages, dependencies = TRUE)
   }

   # Load libraries
   library(shiny)
   library(shinydashboard)
   library(leaflet)
   library(dplyr)
   library(plotly)
   library(shinyjs)
   library(fresh)
   library(sparklyr)
    ```
# Main Functions

The core functionality of the app is driven by two main functions defined in the `example.R` script:

### `mapa_function`

The `mapa_function` is responsible for constructing a map of species based on latitude and longitude information. It utilizes the `leaflet` library to create interactive and visually appealing maps.

### `time_series_function`

The `time_series_function` is used to generate time series plots of species observation events over time. It relies on the plotly library to create dynamic and interactive time series graphs.


