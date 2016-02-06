# ui.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny UI script
# 2016-01-23

# Libraries and options ####
library(shiny)

# Define the Application ####

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Word Predictor"),
    
    
    sidebarPanel(
        
        # Text input
        textInput("text", label = h3('Please insert some text'), value = ''),
    
        # Number of suggested words dropdown
        selectInput('suggestions', label = h5('Number of Suggestions'), 
                choices = list('1' = 1, '3' = 3, '5' = 5, '10' =10), 
                selected = 5)
    ),


    # Output predicted words
    mainPanel(
      fluidRow(
          column(12,
                 tableOutput('predictionTable')
        )
      )
    )
))
