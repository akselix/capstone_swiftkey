# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2016-01-23

# Libraries and options ####
source('prediction.R')

library(shiny)

# Define application ####

shinyServer(function(input, output) {

    # Update input and feed it to prediction function when user input changes 
    prediction =  reactive( {
        
        #validate(
         #   need(input$text != "", "No predictions, please write something.")
        #)
        
        inputText =  input$text
        n = input$suggestions
        
        # Predict
        input1 =  fun.input(inputText)[1, ]
        input2 =  fun.input(inputText)[2, ]
        prediction = fun.predict(input1, input2, n)
    })
        
    # Output prediction
output$predictionTable = renderTable(prediction()) 
})
