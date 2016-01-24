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
    textInput("text", label = h3("Please write some text"), value = "")
    ),
    
    mainPanel(
    tableOutput('predictedWords')
    )
))