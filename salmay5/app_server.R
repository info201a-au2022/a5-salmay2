#Server

# Which country had the lowest gas co2 usage?
'server' <- function(input, output, session) {
  
  lowest_gas_co2 <- climate_change %>%
    filter(gas_co2 == min(gas_co2, na.rm = TRUE)) %>%
    filter(country == min(country)) %>%
    pull(country)
  output$lowest_gas_co2 <- renderText({paste("The country with
the lowest gas co2 usage is" ,lowest_gas_co2, "from our

dataset." )})
}
# which year had the highest gas co2 usage?
highest_gas_co2 <- climate_change %>%
  filter(gas_co2 == max(gas_co2, na.rm = TRUE)) %>%
  pull(year)
highest_gas_co2 <- renderText({paste("The year with the
highest gas co2 usage is" ,highest_gas_co2, "from our
dataset." )})
# Which year had the highest oil co2 usage?
highest_oil_co2 <- climate_change %>%
  filter(oil_co2 == max(oil_co2, na.rm = TRUE)) %>%
  filter(year == max(year)) %>%
  pull(year)
highest_oil_co2 <- renderText({paste("The year with the
highest oil co2 usage is" ,highest_oil_co2, "from our
dataset." )})
#which country had the highest gas co2 usage?
highest_country_gas_co2 <- climate_change %>%
  filter(gas_co2 == max(gas_co2, na.rm = TRUE)) %>%
  filter(year == max(year)) %>%
  pull(country)
highest_country_gas_co2 <- renderText({paste("The
country with the highest gas co2 usage
is" ,highest_country_gas_co2, "from our dataset." )})
filter_country <- function(selectedcountry, selectedyear){
  filtered <- select(climate_change, country, year, gas_co2) %>%
    group_by(country) %>%
    filter(country %in% selectedcountry) %>%
    filter(year >= selectedyear)
  return(filtered)
}
server <- function(input, output, session) {
  
  output$gas_co2 <- renderPlotly({
    
    plot_ly(filter_country(input$Graph_select,
                           input$Graph_slider), x= ~year, y = ~gas_co2,
            type = "scatter", made = "markers", text =
              ~paste("Year:", year, "Gas CO2:", gas_co2)) %>%
      layout(title = "Gas CO2 through out the years" , xaxis =
               list(title = 'Years'),
             yaxis = list(title = 'Gas Growth'))
  })
}
