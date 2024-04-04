# Load required libraries
library(shiny)
library(ggplot2)
library(cluster)

# Define UI for application
ui <- fluidPage(
  titlePanel("Customer Segmentation with K-means Clustering"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("clusters", "Number of Clusters:", 
                  min = 2, max = 10, value = 3)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Sample customer data
  set.seed(123)
  customer_data <- data.frame(
    Age = sample(18:70, 100, replace = TRUE),
    Income = sample(20000:100000, 100, replace = TRUE)
  )
  
  # Perform K-means clustering
  output$plot <- renderPlot({
    kmeans_result <- kmeans(customer_data, input$clusters)
    customer_data$cluster <- as.factor(kmeans_result$cluster)
    
    ggplot(customer_data, aes(x = Age, y = Income, color = cluster)) +
      geom_point() +
      labs(title = "Customer Segmentation",
           x = "Age",
           y = "Income",
           color = "Cluster") +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)