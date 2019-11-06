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
- Language Resources and Evaluation (Computers in the Humanities)

Second, run the data creation script:

- `data_creation.Rmd`: This file creates the data for examination in the project. Run this file to update to the newest datasets. Please note, you do have to manually update the list of duplicate titles, but the script provides a note on the possible options to examine. 

The `output_data` folder will contain:

- `flagged_titles.csv`: A file created by the script for you to check to help determine duplicate titles not caught by the data cleaning
- `exclude_titles.csv`: A file you update to exclude those titles that are truly duplicates
- `completed_clean_data.csv`: The finalized data from this dataset with new abstracts. 


## Data folder

- run preprocessing script 
- and then output (test and train) or new stuff for when the paper is written 

## Classification 

- here is where it would get classified
- all the rules we talked about last time 

## Shiny App Folder 

- updated files in the shiny app 

## Manuscript

- this folder has the static paper

## Presentation

here's the scip stuff 