# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2016-01-23

# Libraries and options ####
library(shiny)
library(dplyr)
library(quanteda)

# Load data and source files ####

#dfTrain1 = readRDS(file = 'shiny/data/dfTrain1.rds')
#dfTrain2 = readRDS(file = 'shiny/data/dfTrain2.rds')
#dfTrain3 = readRDS(file = 'shiny/data/dfTrain3.rds')

#source('prediction.R')


shinyServer(function(input, output) {
    
    output$value = renderPrint({ input$text })
})