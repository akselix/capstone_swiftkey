# word_prediction_exploratory.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Exploratory scripts to accompany word_prediction.R
# 2015-12-22

# Read in data
blogsRaw = read_lines('./data/en_US/en_US.blogs.txt')
newsRaw = read_lines('./data/en_US/en_US.news.txt')
twitterRaw = readLines('./data/en_US/en_US.twitter.txt') # Not working with readr because of an "embedded null"
combinedRaw = c(blogsRaw, newsRaw, twitterRaw)

# Line counts
length(blogsRaw)
length(newsRaw)
length(twitterRaw)
length(combinedRaw)

# Character counts
min(nchar(combinedRaw))
median(nchar(combinedRaw))
max(nchar(combinedRaw))

# Top 10 words from sample
library(wordcloud)
library(RColorBrewer)

wordcloud(dfTrain1$sequence[1:100], dfTrain1$freq[1:100], colors = brewer.pal(6, "Dark2"))
