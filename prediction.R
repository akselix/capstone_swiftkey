# prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a next word given a input of multiple words
# 2016-01-23

# Parameters

# How many words to suggest
number_of_suggestions = 3

# Parse individual tokens from input text
inputText = 'I love Twitter very much'
inputWords = head(data_frame(input1 = fun.tokenize(corpus(inputText))), 3)
input1 = inputWords[1, ]
input2 = inputWords[2, ]
input3 = inputWords[3, ]


# Prediction with lazy backoff algorithm

fun.predict2 = function(input) {
    if(input %in% dfTrain2$word1) {
        prediction = dfTrain2 %>%
        filter(word1 %in% input1) %>%
        select(nextWord) %>%
        top_n(number_of_suggestions, wt = nextWord)
        }
}

fun.predict3 = function(input) {
    if(input %in% dfTrain2$word1) {
        prediction = dfTrain2 %>%
            filter(word1 %in% input1) %>%
            select(nextWord) %>%
            top_n(number_of_suggestions, wt = nextWord)
    }
}
