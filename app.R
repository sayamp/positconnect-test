# Load libraries
library(shiny)

# Define UI
ui <- fluidPage(
  
  # App title
  titlePanel("Basic Shiny App Example"),
  
  # Sidebar layout with input and output
  sidebarLayout(
    
    # Sidebar with controls
    sidebarPanel(
      sliderInput("obs", 
                  "Number of observations:", 
                  min = 10, 
                  max = 500, 
                  value = 100),
      
      selectInput("dist", 
                  "Distribution type:", 
                  choices = c("Normal" = "norm",
                              "Uniform" = "unif",
                              "Exponential" = "exp"))
    ),
    
    # Main panel for displaying output
    mainPanel(
      plotOutput("distPlot"),
      tableOutput("summaryTable")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Reactive expression to generate data
  data <- reactive({
    switch(input$dist,
           "norm" = rnorm(input$obs),
           "unif" = runif(input$obs),
           "exp"  = rexp(input$obs))
  })
  
  # Render histogram
  output$distPlot <- renderPlot({
    hist(data(), main = paste("Histogram of", input$dist), col = "skyblue", border = "white")
  })
  
  # Render summary table
  output$summaryTable <- renderTable({
    summary(data())
  })
}

# Run the app
shinyApp(ui = ui, server = server)
