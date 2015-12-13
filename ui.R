library(shiny)

xlims<-c(1920,2014)

shinyUI(fluidPage(
  
  titlePanel(" Global Historical Climatology Network (NOAA) Temperatures for spanish stations"),
  
  sidebarLayout(
        sidebarPanel(
              
              selectInput('station', 'Stations name', levels(TData$id), selected = levels(TData$id)[1]),
              
              sliderInput("year", "Year:", min = xlims[1], max = xlims[2], value = xlims[2]),
              
              br(),
              
              h3("Monthly Temperature averages and standard deviations", align = "center"),
              
              selectInput('element', '', c("TMAX", "TMIN"), selected = "TMAX"),
      
              #tabPanel('TTable',     dataTableOutput('ttable'))
              dataTableOutput('ttable')
        ),
  
  
        mainPanel(

              plotOutput("dayPlot"), 
              plotOutput("boxPlot")
              
        )
  )
  
))