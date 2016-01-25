# prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a NextWord given a input of multiple words
# 2016-01-23

# Libraries and options ####

# source('prepare_data.R')

options(scipen=999)

# Parameters ####

# How many words to suggest
numberOfSuggestions = 5
# Input text sample 
inputText = 'Significant things!?!'

# Parse last two tokens from input text ####

fun.input = function(x) {
    
    # Tokenize with same function as training data
    y = data_frame(word = fun.tokenize(corpus(x)))
    
    # Handle empty input
    if(nrow(y) == 0) {
        input1 = ""
        input2 = ""
    }
        if(nrow(y) < 2) {
            input1 = ""
            input2 = tail(y, 1)
        
            # Get last 2 values    
        }   else{
                input1 = tail(y, 2)[1, ]
                input2 = tail(y, 1)
            }
    
    # Return data frame of inputs 
    inputs = data_frame(words = unlist(rbind(input1, input2)))
return(inputs)
}

# Get inputs as separate strings
input1 = fun.input()[1, ]
input2 = fun.input()[2, ]

# Predict using stupid back off model ####

fun.predict = function(x, y) {
    
    # Predict giving just the top 1-gram words, if no input given
    if(x == "" & y == "") {
        prediction = dfTrain1 %>%
            select(NextWord) %>%
            filter(row_number() <= numberOfSuggestions)
            
        # Predict using 3-gram model
    }   else if(x %in% dfTrain3$word1 & y %in% dfTrain3$word2) {
            prediction = dfTrain3 %>%
                filter(word1 %in% x & word2 %in% y) %>%
                select(NextWord) %>%
                filter(row_number() <= numberOfSuggestions)
        
            # Predict using 2-gram model
        }   else if(y %in% dfTrain2$word1) {
                prediction = dfTrain2 %>%
                    filter(word1 %in% y) %>%
                    select(NextWord) %>%
                    filter(row_number() <= numberOfSuggestions)
                
                # If no prediction found, Predict giving just the top 1-gram words
            }   else{
                    prediction = dfTrain1 %>%
                        select(NextWord) %>%
                        filter(row_number() <= numberOfSuggestions)
                }
    
# Return predicted word in a data frame
return(prediction)
}

# Predictions ####
input1 = fun.input(inputText)[1, ]
input2 = fun.input(inputText)[2, ]
fun.predict(input1, input2)









