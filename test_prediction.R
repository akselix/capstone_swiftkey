# test_prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a NextWord given an input of any length using stupid backoff algorithm
# 2016-01-23

# Load libraries ####
source('shiny/prediction.R')
source('prepare_data.R')

# Input text sample 
inputText = 'to'

# Get inputs as separate strings
input1 = fun.input(inputText)[1, ]
input2 = fun.input(inputText)[2, ]
input1
input2

# Predict
nSuggestions = 5
fun.predict(input1, input2)