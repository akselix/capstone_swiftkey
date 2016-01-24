# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2016-01-23

# Libraries and options ####
library(shiny)
library(dplyr)
library(quanteda)

# Load data and source files ####

dfTrain1 = readRDS('data/dfTrain1.rds')
dfTrain2 = readRDS('data/dfTrain2.rds')
dfTrain3 = readRDS('data/dfTrain3.rds')

source('prediction.R')

# Define application ####

shinyServer(function(input, output) {
    
    wordPrediction = reactive( {
        inputText = input$text
        inputWords = data_frame(word = fun.tokenize(corpus(inputText)))
        input1 = tail(inputWords, 2)[1, ]
        input2 = tail(inputWords, 1)
    wordPrediction = fun.predict(input1, input2)
    })
        output$predictedWords = renderTable(wordPrediction())
})