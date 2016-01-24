# prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a NextWord given a input of multiple words
# 2016-01-23

# Libraries and options ####

# Parameters ####

# How many words to suggest
numberOfSuggestions = 5

# Input text ####
inputText = 'how are you'

# Transfer to quanteda corpus format and split into sentences
fun.corpus = function(x) {
    corpus(unlist(segment(x, 'sentence')))
}

# Tokenize
fun.tokenize = function(x, ngramSize = 1, simplify = T) {
    toLower(tokenize(x,
                     removeNumbers = T,
                     removePunct = T,
                     removeSeparators = T,
                     removeTwitter = T,
                     ngrams = ngramSize,
                     concatenator = ' ',
                     simplify = simplify
    ) )
}

# Parse individual tokens from input text
fun.input = function(x) {
    data_frame(word = fun.tokenize(corpus(x)))
}

fun.inputWords = function(x) {
    if(nrow(x) == 0) {
    input1 = NULL
    input2 = NULL
    }
        if(nrow(x) < 2) {
            input1 = NULL
            input2 = tail(x, 1)
        
        }   else{
                input1 = tail(x, 2)[1, ]
                input2 = tail(x, 1)
        }
    return(list(input1, input2))
}

inputs = fun.inputWords(fun.input(inputText))
input1 = unlist(inputs[1]) 
input2 = unlist(inputs[2])

# Prediction algorithm using stupid back off model ####
fun.predict = function(x = NULL, y = NULL) {

# Predict giving just the top 1-gram words if no input given
    if(is.null(x) == T | is.null(y) == T) {
        prediction = dfTrain1 %>%
            select(NextWord)
    
        # Predict using 3-gram model
        }else if(is.null(x) == F & is.null(y) == F & x %in% dfTrain3$word1 & y %in% dfTrain3$word2) {
        prediction = dfTrain3 %>%
            filter(word1 %in% x & word2 %in%y) %>%
            select(NextWord)
        
            # Predict using 2-gram model
            }else if(is.null(x) == T & y %in% dfTrain2$word1) {
                prediction = dfTrain2 %>%
                filter(word1 %in% y) %>%
                select(NextWord) 
    
                # If no prediction found, Predict giving just the top 1-gram words
                }else{
                    prediction = dfTrain1 %>%
                    select(NextWord)
                }
return(head(prediction, numberOfSuggestions))
}

fun.predict(input1, input2)