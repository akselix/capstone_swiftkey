# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2016-01-23

# Libraries and options ####
library(shiny)

shinyServer(function(input, output) {
    output$value = renderPrint({ input$text })
})