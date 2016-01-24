# prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a next word given a input of multiple words
# 2016-01-23

# Parameters ####

# How many words to suggest
numberOfSuggestions = 3

# Input text ####

inputText = 'wha the fudge'

# Functions from prepare_data.R for tokenazing the input exactly as the training data
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
inputWords = data_frame(word = fun.tokenize(corpus(inputText)))
input1 = tail(inputWords, 2)[1, ]
input2 = tail(inputWords, 1)


# Prediction algorithm using stupid back off model ####

fun.predict = function(x = NULL, y = NULL) {

# Predict giving just the top 1-gram words if no input given
    if(is.null(x) == T & is.null(y) == T) {
        prediction = dfTrain1 %>%
            top_n(numberOfSuggestions, wt = freq) %>%
            select(sequence)
    
        # Predict using 3-gram model
        }else if(is.null(x) == F & is.null(y) == F & x %in% dfTrain3$word1 & y %in% dfTrain3$word2) {
        prediction = dfTrain3 %>%
            filter(word1 %in% x & word2 %in%y) %>%
            top_n(numberOfSuggestions, wt = freq) %>%
            select(nextWord)
        
            # Predict using 2-gram model
            }else if(is.null(x) == T & y %in% dfTrain2$word1) {
                prediction = dfTrain2 %>%
                filter(word1 %in% y) %>%
                top_n(numberOfSuggestions, wt = freq) %>%
                select(nextWord) 
    
                # If no prediction found, Predict giving just the top 1-gram words
                }else{
                    prediction = dfTrain1 %>%
                    top_n(numberOfSuggestions, wt = freq) %>%
                    select(sequence)
                }
return(prediction)
}
