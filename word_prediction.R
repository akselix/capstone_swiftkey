# word_prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Model for predicting a next word from input text
# 2015-12-20

# Libraries and options ####

library(dplyr)
library(ggplot2)
library(quanteda)

options(scipen = 999)

# Prepare data ####

# Read in data
blogsRaw = readLines('./data/en_US/en_US.blogs.txt')
newsRaw = readLines('./data/en_US/en_US.news.txt')
twitterRaw = readLines('./data/en_US/en_US.twitter.txt')

# Sample the data for preliminary analysis, split into sentences and transfer into quanteda corpus format 
set.seed(1220)
n = 1000

fun.corpus = function(x) {
    corpus(unlist(segment(sample(x, length(x) / n), 'sentence')))
}

blogs = fun.corpus(blogsRaw)
news = fun.corpus(newsRaw)
twitter = fun.corpus(twitterRaw)
combined = blogs + news + twitter

# Exploratory analysis ####

# Length of vectors
length(blogsRaw) + length(newsRaw) + length(twitterRaw)

# Character counts per line
fun.summary = function(x) {
    minChar = min(nchar(x))
    meanChar = mean(nchar(x))
    maxChar = max(nchar(x))
    return(list(minChar, meanChar, maxChar))
}

# Text analysis ####

# Tokenize
fun.tokenize = function(x, ngrams = 1) {
    x = toLower(tokenize(x,   
                removeNumbers = T,
                removePunct = T,
                removeSeparators = T,
                removeTwitter = T,
                ngrams = ngrams,
                simplify = T
    ) )
}

combined1 = fun.tokenize(combined)
combined2 = fun.tokenize(combined, 2)
combined3 = fun.tokenize(combined, 3)

