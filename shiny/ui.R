# ui.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny UI script
# 2016-01-23

# Libraries and options ####
library(shiny)
library(dplyr)
library(quanteda)

# Define the Application ####

shinyUI(fluidPage(
    # Application title
    titlePanel("Word Prediction"),
    
    sidebarPanel(
    # Text input
    textInput("text", label = h3("Text input"), value = "What the fuck")
    ),
    
    mainPanel(
    tableOutput('predictedWords')
    #hr(),
    #fluidRow(column(3, verbatimTextOutput("value")))
    )
))