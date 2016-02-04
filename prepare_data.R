# prepare_data.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Prepare data for downstream analysis and models
# 2015-12-20

# Libraries and options ####
library(readr)
library(tidyr)
library(dplyr)
library(caTools)
library(quanteda)

# Read and prepare data ####

# Read in data
blogsRaw = read_lines('./data/en_US/en_US.blogs.txt')
newsRaw = read_lines('./data/en_US/en_US.news.txt')
twitterRaw = readLines('./data/en_US/en_US.twitter.txt') # Not working with readr because of an "embedded null"
combinedRaw = c(blogsRaw, newsRaw, twitterRaw)

# Sample and combine data  
set.seed(1220)
n = 1/1000
combined = sample(combinedRaw, length(combinedRaw) * n)

# Split into train and validation sets
split = sample.split(combined, 0.8)
train = subset(combined, split == T)
valid = subset(combined, split == F)
    
# Transfer to quanteda corpus format and segment into sentences
fun.corpus = function(x) {
    corpus(unlist(segment(x, 'sentences')))
}

train = fun.corpus(train)

# Tokenize ####
fun.tokenize = function(x, ngramSize = 1, simplify = T) {
    
    # Do some regex magic with qunteda
    toLower(quanteda::tokenize(x,
        removeNumbers = T,
        removePunct = T,
        removeSeparators = T,
        removeTwitter = T,
        ngrams = ngramSize,
        concatenator = " ",
        simplify = simplify
    ) )
}

train1 = fun.tokenize(train)
train2 = fun.tokenize(train, 2)
train3 = fun.tokenize(train, 3)

# Frequency tables ####
fun.frequency = function(x, minCount = 1) {
    x = x %>%
    group_by(NextWord) %>%
    summarize(count = n()) %>%
    filter(count >= minCount)
    x = x %>% 
    mutate(freq = count / sum(x$count)) %>% 
    select(-count) %>%
    arrange(desc(freq))
}

dfTrain1 = data_frame(NextWord = train1)
dfTrain1 = fun.frequency(dfTrain1)

dfTrain2 = data_frame(NextWord = train2)
dfTrain2 = fun.frequency(dfTrain2) %>%
    separate(NextWord, c('word1', 'NextWord'), " ")

dfTrain3 = data_frame(NextWord = train3)
dfTrain3 = fun.frequency(dfTrain3) %>%
    separate(NextWord, c('word1', 'word2', 'NextWord'), " ")

# Save Data ####
#saveRDS(dfTrain1, file = './shiny/data/dfTrain1.rds')
#saveRDS(dfTrain2, file = './shiny/data/dfTrain2.rds')
#saveRDS(dfTrain3, file = './shiny/data/dfTrain3.rds')

