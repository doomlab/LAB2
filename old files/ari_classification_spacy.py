# -*- coding: utf-8 -*-
"""
Created on Sat Oct 12 16:31:12 2019

@author: Ari
"""

#### LIBRARIES ####
 
import pandas as pd

# scikitlearn
from sklearn.feature_extraction.text import CountVectorizer,TfidfVectorizer
from sklearn.base import TransformerMixin
from sklearn.pipeline import Pipeline
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn import metrics

# NLP
import spacy
import string
from spacy.lang.en import English
from spacy.lang.en.stop_words import STOP_WORDS
nlp = spacy.load('en')


# Get pre-processed data
data = pd.read_csv('data.combo.csv')
data.head()


#### LOAD SPACY MODEL ####

# Create our list of punctuation marks
punctuations = string.punctuation

# Create our list of stopwords
stop_words = STOP_WORDS

# Load English tokenizer, tagger, parser, NER and word vectors
parser = English()

# Create our tokenizer function
def spacy_tokenizer(sentence):
    # Creating our token object, which is used to create documents with linguistic annotations.
    mytokens = parser(sentence)

    # Lemmatizing each token and converting each token into lowercase
    mytokens = [ word.lemma_.lower().strip() if word.lemma_ != "-PRON-" else word.lower_ for word in mytokens ]

    # Removing stop words
    mytokens = [ word for word in mytokens if word not in stop_words and word not in punctuations ]

    # return preprocessed list of tokens
    return mytokens


#### TRANSFORMER ####

# Custom transformer using spaCy
class predictors(TransformerMixin):
    def transform(self, X, **transform_params):
        # Cleaning Text
        return [clean_text(text) for text in X]

    def fit(self, X, y=None, **fit_params):
        return self

    def get_params(self, deep=True):
        return {}

# Basic function to clean the text
def clean_text(text):
    # Removing spaces and converting text into lowercase
    return str(text).strip().lower()

bow_vector = CountVectorizer(tokenizer = spacy_tokenizer, ngram_range=(1,1))
tfidf_vector = TfidfVectorizer(tokenizer = spacy_tokenizer)


#### SPLIT DATA ####

X = data['text'] # the features we want to analyze
ylabels = data['class'] # the labels, or answers, we want to test against

X_train, X_test, y_train, y_test = train_test_split(X, ylabels, test_size=0.3)


#### CREATE MODEL ####

# Logistic Regression Classifier
classifier = LogisticRegression()

# Create pipeline using Bag of Words
pipe = Pipeline([("cleaner", predictors()),
                 ('vectorizer', bow_vector),
                 ('classifier', classifier)])

# model generation
pipe.fit(X_train,y_train)


#### PREDICTING WITH TEST ####

# Predicting with a test dataset
predicted = pipe.predict(X_test)

# Model Accuracy
print("Logistic Regression Accuracy:",metrics.accuracy_score(y_test, predicted))
print("Logistic Regression Precision:",metrics.precision_score(y_test, predicted))
print("Logistic Regression Recall:",metrics.recall_score(y_test, predicted))
## Accuracy  .872
## Precision .916
## Recall    .885

#### PREDICT DATA ####

#take the data out of pandas to a list 
new_data = data['text'].tolist()
type(new_data)

#predict new data
predictions = pipe.predict(new_data)

#saves as an array
print(type(predictions))

#add it to the dataframe
data['prediction'] = predictions
data.head()

probabilities = pipe.predict_proba(new_data)

print(probabilities[:10])
#[[9.74457872e-01 2.55421282e-02]
 #[9.21846704e-01 7.81532955e-02]
 #[9.99168498e-01 8.31501836e-04]
 #[9.99999086e-01 9.13883116e-07]
 #[9.76496177e-01 2.35038225e-02]
 #[9.88453091e-01 1.15469091e-02]
 #[9.84397228e-01 1.56027720e-02]
 #[9.98578598e-01 1.42140171e-03]
 #[9.98511351e-01 1.48864853e-03]
 #[9.76128585e-01 2.38714153e-02]]
 
#want the probability of the 1, which is how the 0-1 gets scored
probabilities_list = [item[1] for item in probabilities] 

print(probabilities_list[:10])
#[0.02554212818983025, 0.07815329553574211, 0.0008315018364152335, 9.138831161591439e-07,
# 0.023503822515766746, 0.011546909072819246, 0.015602771986502187, 
# 0.001421401712487694, 0.0014886485308452828, 0.023871415309757872]

data['probability'] = probabilities_list
data.head()


##What is this? Do we need this?
#data['polarity'].corr(data['prediction'])
#data['polarity'].corr(data['probability'])


data.to_csv(r'ari_predicted_data.csv')



