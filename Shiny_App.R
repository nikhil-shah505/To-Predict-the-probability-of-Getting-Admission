setwd("C:/Users/Souvik/Downloads/PPA FINAL PROJECT")
# Import libraries
library(car)
library(corrplot)
library(caret)
library(caTools)
library(psych)
library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)
# Read in the RF model
model <- readRDS("model.rds")

#Making an shiny app 
####################################
# User interface                   #
####################################
ui <- fluidPage(theme = shinytheme("sandstone"),
                navbarPage("Admission Predictor:",
                           
                           tabPanel("Home",
                                    
                                    # Page header
                                    headerPanel('Check Your Chance of Getting Selected at The University'),
                                    
                                    # Input values
                                    sidebarPanel(
                                      HTML("<h3>Input parameters</h3>"),
                                      
                                      selectInput("University.Rating", label = "Rating Of The University", 
                                                 choices = list("5" = 1, "4" = 2, "3" = 3, "2" = 4, "1" = 5), 
                                                 selected = "3"),
                                      sliderInput("GRE.Score", "GRE Score:",
                                                  min = 100, max = 340,
                                                  value = 300),
                                      sliderInput("TOEFL.Score", "TOEFL Score:",
                                                  min = 50, max = 120,
                                                  value = 100),
                                      sliderInput("LOR", "Letter of Recommendation Strength:",
                                                  min = 1, max = 5,
                                                  value = 3,step = 0.5),
                                      sliderInput("CGPA", "Undergraduate CGPA Score:",
                                                  min = 0, max = 10,
                                                  value = 5,step = 0.25),
                                      selectInput("Research", label = "Research Experience:", 
                                                  choices = list("Yes" = 1, "No" = 0), 
                                                  selected = 1),
                                      
                                      actionButton("submitbutton", "Submit", class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Chances of getting selected')), # Status/Output Text Box
                                      verbatimTextOutput('contents'),
                                      tableOutput('tabledata') # Prediction results table
                                      
                                    )
                           )#tabPanel(),
                ) # navbarPage()
) # fluidPage()

server<- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    df <- data.frame(
      Name = c("University.Rating",
               "GRE.Score",
               "TOEFL.Score",
               "LOR",
               "CGPA",
               "Research"),
      Value = c(input$University.Rating,
                input$GRE.Score,
                input$TOEFL.Score,
                input$LOR,
                input$CGPA,
                input$Research),
      stringsAsFactors = FALSE)
    
    Chance.of.Admit <- 0
    df <- rbind(df, Chance.of.Admit)
    input <- transpose(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    Output <- data.frame(Prediction=predict(model,test,type="response"))
    print(Output)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Your Probability of Getting Selected is") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)
