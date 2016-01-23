# prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a next word given a input of multiple words
# 2016-01-23

# Parameters ####

# How many words to suggest
numberOfSuggestions = 3

# Input text
inputText = 'What is this?'
# Parse individual tokens from input text ####
inputWords = data_frame(word = fun.tokenize(corpus(inputText)))
input1 = tail(inputWords, 2)[1, ]
input2 = tail(inputWords, 1)

# Prediction with lazy backoff algorithm ####

# Predict using 3-gram model
fun.predict3 = function(input1 = input1, input2 = input2) {
    if(input1 %in% dfTrain3$word1 & input2 %in% dfTrain3$word2) {
        prediction = dfTrain3 %>%
            filter(word1 %in% input1 & word2 %in%input2) %>%
            select(nextWord, freq) %>%
            top_n(numberOfSuggestions, wt = freq)
    }
}

# Predict using 2-gram model
fun.predict2 = function(input2 = input2) {
    if(input2 %in% dfTrain2$word1) {
        prediction = dfTrain2 %>%
            filter(word1 %in% input2) %>%
            select(nextWord, freq) %>%
            top_n(numberOfSuggestions, wt = freq)
        }
}

