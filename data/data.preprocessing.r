library(readr)
library(tm)
library(stringr)
library(scales)
library(data.table)
library(readtext)
library(taRifx)

## [1] - Importing Data...

#dataset 1
data <- data.frame(read.csv("data/training_test_data.csv", stringsAsFactors = F))
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

write.csv(data, "data/training_test_data_cleaned.csv")

#dataset 2
data2 <- data2.frame(read.csv("data/new_data.csv"))
str(data2)

title1 = c(lapply(data2[,23], toString))
str(title1)
abstract1 = c(lapply(data2[,27], toString))
str(abstract1)
keywords1 = c(lapply(data2[,29], toString))
str(keywords1)

for(i in seq_along(length(data2))) {
  text1 = c(mapply(paste, sep="", title1, abstract1))
  text1 = c(mapply(paste, sep="", text1, keywords1))
}

str(text1)
head(text1)

str(data2$code)
class1 = as.numeric(data2$code)
class1 = ifelse(class1 == 1, 0, 1)
str(class1)
unique(class1)
table(class1)


## [2] - Data Pre-processing...
text1 = tolower(text1)
text1 = str_replace_all(string = text1, pattern = "[;#??????..?a?.?.zTY??㱢???????~???'????^.?.?????????-????T??????z?..?.?.z?.?.z?...?..?..?.?.?..?.?.z?..?.o?..?.?.z?..?.?.z?..?.?.z]", replacement = "")
text1 = tm::removeWords(text1, stopwords(kind = "SMART"))
text1 = tm::removePunctuation(text1)
text1 = tm::removeNumbers(text1)
text1 = tm::stripWhitespace(text1)
text1 = tm::stemDocument(text1)
str(text1)
head(text1)

data = data.frame(cbind(text, class))
colnames(data) = c("text", "class")
str(data)

data2 = data.frame(cbind(text1, class1))
colnames(data2) = c("text", "class")
str(data2)

data.combo = rbind(data, data2)
str(data.combo)

write.csv(data, "data.csv")
write.csv(data.combo, "data.combo.csv")

