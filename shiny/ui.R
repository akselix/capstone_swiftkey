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
        textInput("text", label = h4('Please insert some text'), value = ''),
        
        # Table output
        dataTableOutput('predictionTable')
            )
        )
    ),
    
    mainPanel(
        fluidRow(
            column(12,

        # Wordcloud output
        plotOutput('cloud')
            )
        )
    )
) )
