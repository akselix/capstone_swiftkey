# word_prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Model for predicting a next word from input text
# 2015-12-20

# Libraries and options ####

library(dplyr)
library(ggplot2)
library(quanteda)
library(tm)
library(RWeka)

options(scipen = 999)

# Prepare data ####

# Read in data

blogsRaw = readLines('./data/en_US/en_US.blogs.txt')
newsRaw = readLines('./data/en_US/en_US.news.txt')
twitterRaw = readLines('./data/en_US/en_US.twitter.txt')

# Sample the data for preliminary analysis

set.seed(1219)
n = 1000

blogs = sample(blogsRaw, length(blogsRaw) / n)
news = sample(newsRaw, length(newsRaw) / n)
twitter = sample(twitterRaw, length(twitterRaw) / n)