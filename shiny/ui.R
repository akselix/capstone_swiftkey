# ui.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny UI script
# 2016-01-23

# Libraries and options ####
library(shiny)
library(shinythemes)

# Define the app ####

shinyUI(fluidPage(

    # Theme
    theme = shinytheme("flatly"),
    
    # Application title
    titlePanel("Word Predictor"),

# Sidebar ####    
    sidebarLayout(
        
        sidebarPanel(
        
        # Text input
        textInput("text", label = ('Please enter some text'), value = ''),
        
        # Number of words slider input
        sliderInput('slider',
                    'Maximum number of words',
                    min = 0,  max = 1000,  value = 10),

        # Table output
        dataTableOutput('table')),

# Mainpanel ####

        mainPanel(
        
        # Wordcloud output
        plotOutput('wordcloud')
        )
    ) 
)
)
