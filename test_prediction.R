# test_prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a NextWord given an input of any length using stupid backoff algorithm
# 2016-01-23

# Load libraries ####
source('shiny/prediction.R')
source('prepare_data.R')

# Input text sample 
inputText = 'according to'

# Get inputs as separate strings
input1 = fun.input(inputText)[1, ]
input2 = fun.input(inputText)[2, ]
input1
input2

# Predict
nSuggestions = 5
fun.predict(input1, input2)

fun.predictCloud = function(x, y, z = nSuggestions) {
    
    # Predict giving just the top 1-gram words, if no input given
    if(x == "" & y == "") {
        prediction = dfTrain1 %>%
            select(NextWord, freq)
        
        # Predict using 3-gram model
    }   else if(x %in% dfTrain3$word1 & y %in% dfTrain3$word2) {
        prediction = dfTrain3 %>%
            filter(word1 %in% x & word2 %in% y) %>%
            select(NextWord, freq)
        
        # Predict using 2-gram model
    }   else if(y %in% dfTrain2$word1) {
        prediction = dfTrain2 %>%
            filter(word1 %in% y) %>%
            select(NextWord, freq)
        
        # If no prediction found before, predict giving just the top 1-gram words
    }   else{
        prediction = dfTrain1 %>%
            select(NextWord, freq)
    }
    
    # Return predicted word in a data frame
    return(prediction[1:z, ])
}


fun.wordcloud = function(x) {
    wordcloud(x$NextWord, x$freq, colors = brewer.pal(8, 'Dark2'))
}

# Prediction without dplyr ####
fun.predict2 <- function(x, y, z = nSuggestions) {
    
    # Predict giving just the top 1-gram words, if no input given
    if(x == "" & y == "") {
        prediction = dfTrain1$NextWord
        
        # Predict using 3-gram model
    }   else if(x %in% dfTrain3$word1 & y %in% dfTrain3$word2) {
        prediction = subset(dfTrain3, dfTrain3$word1 %in% x & dfTrain3$ word2 %in% y, NextWord)
        
        # Predict using 2-gram model
    }   else if(y %in% dfTrain2$word1) {
        prediction = subset(dfTrain2, dfTrain2$word1 %in% y, NextWord)
        
        # If no prediction found before, predict giving just the top 1-gram words
    }   else{
        prediction <- dfTrain1$NextWord
    }
    
    # Return predicted word in a data frame
    return(prediction[1:z])
}