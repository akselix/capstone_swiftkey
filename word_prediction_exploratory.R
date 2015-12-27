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
data.frame(lineCount = c(length(blogsRaw), length(newsRaw), length(twitterRaw), length(combinedRaw)),
           medianNchar = c(median(nchar(blogsRaw)), median(nchar(newsRaw)), median(nchar(twitterRaw)), median(nchar(combinedRaw))),
           row.names = c('Blogs', 'News', 'Twitter', 'Combined'))

# Character counts
min(nchar(combinedRaw))
median(nchar(combinedRaw))
max(nchar(combinedRaw))

# Top 10 words from sample
library(wordcloud)
library(RColorBrewer)

wordcloud(dfTrain1$sequence[1:100], dfTrain1$freq[1:100], colors = brewer.pal(6, "Dark2"))

# Point plot of most common sequencies
library(ggplot2)

plotMax = 20
dfFreq = bind_rows(dfTrain1[1:plotMax, ], 
                    unite(dfTrain2[1:plotMax, ], 'sequence', word1, nextWord, sep = ' '),
                    unite(dfTrain3[1:plotMax, ], 'sequence', word1, word2, nextWord, sep = ' ')
                    ) %>%
                        mutate(ngram = rep(c('unigram', 'bigram', 'trigram'), each = plotMax)
        )

dfFreq$sequence = factor(dfFreq$sequence, levels = dfFreq$sequence[order(dfFreq$freq, decreasing = T)])

ggplot(dfFreq, aes(x = sequence, y = freq)) +
    geom_point(aes(color = ngram)) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    labs(title = 'Frequency of Top 20 Sequencies with Different Ngrams', x = 'Sequence', y = 'Frequency')
    
    
