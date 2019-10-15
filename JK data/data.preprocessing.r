library(readr)
library(tm)
library(stringr)
library(scales)
library(data.table)
library(readtext)
library(taRifx)

## [1] - Importing Data...

#dataset 1
data <- data.frame(read.csv("data/training_test_data.csv"))
str(data)

title = c(lapply(data[,23], toString))
str(title)
abstract = c(lapply(data[,27], toString))
str(abstract)
keywords = c(lapply(data[,29], toString))
str(keywords)

for(i in seq_along(length(data))) {
  text = c(mapply(paste, sep="", title, abstract))
  text = c(mapply(paste, sep="", text, keywords))
}

str(text)
head(text)

str(data$code)
class = as.numeric(data$code)
class = ifelse(class == 1, 0, 1)
str(class)
unique(class)
table(class)


## [2] - Data Pre-processing...
text = tolower(text)
text = str_replace_all(string = text, pattern = "[;#âº?¹®â..ðaÅ.â.zTY£Âã±¢§¬¶¯³²²~°¯´'¸ïªî©¥¤^.µ.«¨¦î©¦ª¦¥¦î¤î©µ-îª¥¨???T??????zâ..Å.â.zÅ.â.zâ...â..â..Ë.Å.â..Å.â.zâ..â.oâ..Å.â.zâ..Å.â.zâ..Å.â.z]", replacement = "")
text = tm::removeWords(text, stopwords(kind = "SMART"))
text = tm::removePunctuation(text)
text = tm::removeNumbers(text)
text = tm::stripWhitespace(text)
text = tm::stemDocument(text)
str(text)
head(text)


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
text1 = str_replace_all(string = text1, pattern = "[;#âº?¹®â..ðaÅ.â.zTY£Âã±¢§¬¶¯³²²~°¯´'¸ïªî©¥¤^.µ.«¨¦î©¦ª¦¥¦î¤î©µ-îª¥¨???T??????zâ..Å.â.zÅ.â.zâ...â..â..Ë.Å.â..Å.â.zâ..â.oâ..Å.â.zâ..Å.â.zâ..Å.â.z]", replacement = "")
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

