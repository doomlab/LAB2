library(readr)
library(tm)
library(stringr)
library(scales)
library(data.table)
library(readtext)
library(taRifx)

## [1] - Importing Data...

#dataset 1
data <- data.frame(read.csv("data/input_data/training_test_data.csv", stringsAsFactors = F))
str(data)

small_data <- data[ , c("KEYWORDS", "TITLE", "ABSTRACT", "code")]
small_data$text <- paste(small_data$KEYWORDS, small_data$TITLE, small_data$ABSTRACT, sep = " ")
small_data$class <- as.numeric(as.factor(small_data$code))
small_data$class <- ifelse(class == 1, 0, 1)
table(small_data$class)

## [2] - Data Pre-processing...
small_data$text <- iconv(small_data$text, "latin1", "ASCII", sub = " ")
small_data$text <- gsub("^Keywords", " ", small_data$text)
small_data$text <- gsub("^NA| NA ", " ", small_data$text)
small_data$text <- tolower(small_data$text)
small_data$text <- removeWords(small_data$text, stopwords(kind = "SMART"))
small_data$text <- removePunctuation(small_data$text)
small_data$text <- removeNumbers(small_data$text)
small_data$text <- stripWhitespace(small_data$text)
small_data$text <- stemDocument(small_data$text)

write.csv(small_data, "data/output_data/training_test_data_cleaned.csv")

#dataset 2
data2 <- data.frame(read.csv("data/input_data/new_data.csv", stringsAsFactors = F))
str(data2)

small_data2 <- data2[ , c("KEYWORDS", "TITLE", "ABSTRACT", "code")]
small_data2$text <- paste(small_data2$KEYWORDS, small_data2$TITLE, small_data2$ABSTRACT, sep = " ")
small_data2$class <- as.numeric(as.factor(small_data2$code))
small_data2$class <- ifelse(class == 1, 0, 1)
table(small_data2$class)

## [2] - Data Pre-processing...
small_data2$text <- iconv(small_data2$text, "latin1", "ASCII", sub = " ")
small_data2$text <- gsub("^Keywords", " ", small_data2$text)
small_data2$text <- gsub("^NA| NA ", " ", small_data2$text)
small_data2$text <- tolower(small_data2$text)
small_data2$text <- removeWords(small_data2$text, stopwords(kind = "SMART"))
small_data2$text <- removePunctuation(small_data2$text)
small_data2$text <- removeNumbers(small_data2$text)
small_data2$text <- stripWhitespace(small_data2$text)
small_data2$text <- stemDocument(small_data2$text)

write.csv(small_data2, "data/output_data/new_data_cleaned.csv")

write.csv(rbind(small_data, small_data2), "data/output_data/data.combo.csv")
