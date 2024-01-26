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



## Completed Tasks

- [x] Presented an application capable of searching for species by their vernacular name and scientific name.
- [x] Presented the count of species that were observed
- [x] Included a visualization of a timeline when selected species were observed
- [x] Implemented the App using shinyModules
- [x] Unit tests have been added for the most important functions and cover edge cases
- [x] Beautiful UI Skill was made available using the help of the Fresh library, available on CRAN
- [x] Infrastructure skill was developed, considering that the application was deployed on my personal machine on AWS (see, http://3.144.225.25:3838/Appsilon_test/)
      

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

The `app.R` file is the main script that contains all the necessary libraries and code for the Biodiversity Analysis Shiny App.

## Main Functions

The core functionality of the app is driven by two main functions defined in the `example.R` script:

#### `mapa_function`

The `mapa_function` is responsible for constructing a map of species based on latitude and longitude information. It utilizes the `leaflet` library to create interactive and visually appealing maps.

#### `time_series_function`

The `time_series_function` is used to generate time series plots of species observation events over time. It relies on the plotly library to create dynamic and interactive time series graphs.

## shiny Modules

To facilitate the creation of the application, modularization of the application was considered, with the aim of fixing future bugs more quickly

#### `filterModuleUI` and `filterModule`

The `filterModuleUI` and 'filterModule' are responsible for creating buttons and interacting data with the application, generating eventReactive and action buttons to make viewing more pleasant with just a few clicks on the screen.

#### `mapModuleUI`, `mapModule`, `timeSeriesModuleUI` and `timeSeriesModule`

The `mapModuleUI`, `mapModule`, `timeSeriesModuleUI` and `timeSeriesModule` are responsible for making the app's buttons come to life, making the user consider viewing the species' location map and the time series of events presented for those species

#### `speciesCountModuleUI` and`speciesCountModule`

The `speciesCountModuleUI`, `speciesCountModule` are responsible for calculating the number of observations that a given species was presented in the dataset

# Comments about `app.R`

- It presents a structure considering the Shinydashboard, however, with the help of the fresh package, the entire Beautiful UI was modified to an interface different from the standard presented by Shinydashboard.

- The main page does not remain blank for users, it was considered including a description together with an instruction on how the application should be used, and the explanation will be maintained during the use of the app to facilitate learning.

- Remember the application is deployed in the AWS cloud, that is, it is in production, any change in the `app.R` and `examples.R` and `example-Module.R` codes directly affects the deployment of the Model



