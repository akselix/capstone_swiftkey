# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2016-01-23

# Libraries and options ####
library(shiny)
library(dplyr)
library(quanteda)

# Load data and source files ####
dfTrain1 = readRDS(file = 'data/dfTrain1.rds')
dfTrain2 = readRDS(file = 'data/dfTrain2.rds')
dfTrain3 = readRDS(file = 'data/dfTrain3.rds')

source('prepare_data.R')
source('prediction.R')

# Define application ####

shinyServer(function(input, output) {
    
    # Update input and feed it to prediction function when user input changes 
    prediction = reactive( {
        inputText = input$text
        input1 = fun.input(inputText)[1, ]
        input2 = fun.input(inputText)[2, ]
        prediction = fun.predict(input1, input2)
    } ) 

    # Output prediction table
    output$table <- renderTable(prediction())

} )