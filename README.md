# LAB2

Update to the Linguistic Annotated Bibliography

- Last work through of sources was November 4th, 2019.

# Workflow

## The `Sources` Folder

First, update all relevant search files, which are stored in the `input_data` folder:

- `lab_table.csv`: The current version of the LAB table, which is also stored in our shiny app folder.
- `mendeley.bib`: A bibtex file that includes all the LAB citations, which is also stored in our shiny app folder. 

Searches: 

To do these searches, we used "" to keep like terms together to avoid articles that only used `norms` or `lexical` when appropriate. 

- `lexical_DB_*.csv/bib`: The search term "lexical database" on source websites.
- `linguistic_DB_*.csv/bib`: The search term "linguistic database" on source websites. 
- `lexical_norms_*.csv/bib`: The search term "lexical norms" on source websites.
- `linguistic_norms_*.csv/bib`: The search term "linguistic norms" on source websites. 
- `corpus_*.csv/bib`: The search term "corpus" only on journal websites.
- `norms_*.csv/bib`: The search term "norms" only on journal websites.

Websites and journals currently used:

- EBSCO host for PSYCInfo
- PLoS One
- Behavior Research Methods
- Language Resources and Evaluation (Computers and the Humanities)

Second, run the data creation script:

- `data_creation.Rmd`: This file creates the data for examination in the project. Run this file to update to the newest datasets. Please note, you do have to manually update the list of duplicate titles, but the script provides a note on the possible options to examine. 

The `output_data` folder will contain:

- `flagged_titles.csv`: A file created by the script for you to check to help determine duplicate titles not caught by the data cleaning
- `exclude_titles.csv`: A file you update to exclude those titles that are truly duplicates
- `completed_clean_data.csv`: The finalized data from this dataset with new abstracts. 

## `Data` folder

The data folder contains a pre-processing script that cleans the text of punctuation, stop words, symbols, and stems. For the purposes of publication and testing/validating the algorithm, we split the data into three subsets:

- Training data: all data from from the LAB including ones we would have found and excluded in our search.
- Testing data - new publications: all data from 2019 and later that would have been searched for new articles (aka information published after the LAB was completed).
- Testing data - LRE: all data from LRE pre-2019 that would be included in new versions of the LAB. This journal was found after the publication of the LAB and was used to validate the algorithm.

In the `input_data` folder: 

- `completed_clean_data.csv`: The data as processed from the sources folder. Note that the classification was arbitrary for all old data. 
- `completed_clean_data_EMB_code.csv`: The data including the proper classification for each article in the `code` column. 

In the `output_data` folder, there are `stem` and `no_stem` versions of each file indicating if they have been stemmed. The test and training data distinctions are described above. Additionally, the `complete` data is all articles included together. 

## The `Classification` folder 

In this folder, you can view the types of classification that we examined for this project. Each author tested their own model. The original plan was to examine the LAB data as a training dataset with testing on the new LRE data and the new 2019 data. However, it was clear from initial testing that the LRE data needed to be part of training to capture the different style of abstracts and stylistics to accurately predict new data. Therefore, training occurred with the LAB data + LRE data, dev-testing with a small subset of that data, and extension testing to the new 2019 data. 

- `spacy_classification.Rmd` includes a spacy pipeline for classifying our documents, and the resulting probabilities and prediction values for the testing datasets using logistic regression.
- `spacy_svc_classification.Rmd` is a similar approach using linear SVC with simple text tokenization. 
- `naivebayes_classification.Rmd` is a Naive Bayes classifier algorithm on the top 500 most common words from the abstracts.
- `keras_cnn.Rmd` - a convolutional neural network model using keras and tensorflow to model the abstracts on a more complex level.

## Shiny App Folder 

We have previously developed a shiny app avaliable at http://wordnorms.com/lab_table.html for the original LAB database. This folder links to the DOOM lab's shiny app folder, which has the new shiny app for the LAB2.0: https://github.com/doomlab/shiny-server --> `wn_lab2` folder. 

## Manuscript

This folder will contain the static manuscript as part of this project presented at the Society for Computers in Psychology. We expect to submit to Behavior Research Methods by the end of December 2019. 

## Presentations

This folder contains the presentations for the LAB2.0.