# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2016-01-23

# Libraries and options ####
library(shiny)
library(dplyr)
library(quanteda)


# Load data and source files ####
dfTrain1 <- load(file = 'data/dfTrain1.RData')
dfTrain2 <- load(file = 'data/dfTrain2.RData')
dfTrain3 <- load(file = 'data/dfTrain3.RData')

source('prediction.R')

# Define application ####

shinyServer(function(input, output) {

    wordPrediction = reactive( {
        
        inputText = input$text
        inputWords = fun.input(inputText)
        inputs = fun.inputWords(inputWords)
        input1 = unlist(inputs[1]) 
        input2 = unlist(inputs[2])
        
        wordPrediction = fun.predict(input1, input2)
    
    })
    output$predictedWords = renderTable(wordPrediction())
    

} )