# server
library(plotly)
library(tidyverse)
library(ggplot2)
library(shiny)
library(dplyr)

#data
climate_change <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
#Introduction Page
Introduction <- tabPanel(
  "Introduction" ,
  titlePanel("Climate Change"),
  p("No one can choose who the effects of climate change will be on. It has an impact on everyone in 
    the planet. Climate change has changed in numerous ways over the years. While it might not have an 
    impact on where you reside, it affects many other people. Climate change will eventually affect us
    more negatively. I concentrated on the use of oil and gas CO2 in this project. This will demonstrate 
    the effects of oil and gas as well as how climate change has changed through time."),
    textOutput("lowest_oil_co2"),
    textOutput("lowest_gas_co2"),
    textOutput("highest_gas_co2"),
    textOutput("highest_oil_co2"),
    textOutput("highest_country_gas_co2")
  )

# Interactive Visualization Page
visual_1 <- tabPanel(
  "Visual 1" ,
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "Graph_select",
        label = "Country:" ,
        choices = unique(climate_change$country),
        
        multiple = T
      ),
      sliderInput(
        inputId = "Graph_slider",
        label = "Year:",
        sep = "",
        min = 1949, value = 1985, max = 2020
      )
    ),
    mainPanel(
      plotlyOutput("gas_co2")
    )
  )
)
ui <- navbarPage(
  "Gas and Oil CO2",
  Introduction,
  visual_1
)