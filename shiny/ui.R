# ui.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny UI script
# 2016-01-23

# Libraries and options ####
library(shiny)
library(shinythemes)

# Define the Application ####

shinyUI(fluidPage(
    
    # Theme
    theme = shinytheme("flatly"),
    
    # Application title
    titlePanel("Word Predictor"),
    
    
    sidebarPanel(
        fluidRow(
            column(10,
        
        # Text input
        textInput("text", label = h5('Please insert some text'), value = ''),
    
        # Number of suggested words dropdown
        selectInput('suggestions', label = h5('Number of Suggestions'), 
                choices = list('1' = 1, '3' = 3, '5' = 5, '10' =100), 
                selected = 10)
            )
        )
    ),

    # Output predicted words
    mainPanel(
        fluidRow(
            column(6,
                
        dataTableOutput('predictionTable')
            )
        )
    )
))
