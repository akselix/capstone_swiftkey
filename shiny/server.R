# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2016-01-23

# Libraries and options ####
source('prediction.R')

library(shiny)

# Define application ####

shinyServer(function(input, output) {

    # Reactive statement for prediction function when user input changes 
    prediction =  reactive( {
        
        # Get input
        inputText = input$text
        input1 =  fun.input(inputText)[1, ]
        input2 =  fun.input(inputText)[2, ]
        
        # Predict
        prediction = fun.predict(input1, input2, 100)
    })

# Output prediction
output$predictionTable = renderDataTable(prediction(),
                            option = list(pageLength = 5,
                                        lengthMenu = list(c(5, 15, 100), c('5', '15', '100')),
                                        columnDefs = list(list(visible = F, targets = 1))
                                        )
                                    )
# Output wordcloud
#output$cloud = repeatable(
output$cloud = renderPlot(wordcloud(
                prediction()$NextWord,
                prediction()$freq,
                colors = brewer.pal(8, 'Dark2')
                )
            )
})
