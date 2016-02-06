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
        
        inputText =  input$text
        n = input$suggestions
        
        # Predict
        input1 =  fun.input(inputText)[1, ]
        input2 =  fun.input(inputText)[2, ]
        prediction = fun.predict(input1, input2, 100)
    })
        
# Output prediction
output$predictionTable = renderDataTable(prediction(), option = list(pageLength = 5,
                                                                     lengthMenu = list(c(5, 15, 100, -1), c('5', '15', '100', 'All'))
                                                                     )
                                         )
})
