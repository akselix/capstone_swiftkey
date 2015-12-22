# word_prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Model for predicting a next word from input text
# 2015-12-20

# Libraries and options ####
library(readr)
library(dplyr)
library(ggplot2)
library(caTools)
library(quanteda)

options(scipen = 999)

# Prepare data ####

# Read in data
blogsRaw = read_lines('./data/en_US/en_US.blogs.txt')
newsRaw = read_lines('./data/en_US/en_US.news.txt')
twitterRaw = readLines('./data/en_US/en_US.twitter.txt') # Not working with readr because of an "embedded null"

# Sample and combine data for preliminary analysis  
set.seed(1220)
n = 1000

fun.sample = function(x) {
    sample(x, length(x) / n)
}

blogs = fun.sample(blogsRaw)
news = fun.sample(newsRaw)
twitter = fun.sample(twitterRaw)
combined = c(blogs, news, twitter)

split = sample.split(combined, 0.8)
train = subset(combined, split == T)
test = subset(combined, split == F)
    
# Transfer to quanteda corpus format and split into sentences
fun.corpus = function(x) {
    corpus(unlist(segment(x, 'sentence')))
}

train = fun.corpus(train)
test = fun.corpus(test)

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

