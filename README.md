# R Programming Assignment 3

## Introduction
The data for this assignment come from the Hospital Compare web site (http://hospitalcompare.hhs.gov)
run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and
information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset es-
sentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining
whether hospitals should be fined for not providing high quality care to patients (see http://goo.gl/jAXFX
for some background on this particular topic).

The Hospital Compare web site contains a lot of data but I limited the data to a small subset for this assignment. 
The zip file for this assignment contains three files:
 - outcome-of-care-measures.csv: Contains information about 30-day mortality and readmission rates
for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.
 - hospital-data.csv: Contains information about each hospital.
 - Hospital_Revised_Flatfiles.pdf: Descriptions of the variables in each file (i.e the code book).
 
A description of the variables in each of the files is in the included PDF file named Hospital_Revised_Flatfiles.pdf.
This document contains information about many other files that are not included with this programming
assignment. 

## Task 1 - Plot the 30-day mortality rates for heart attack
For this task, I created a histogram of the 30-day death rates from having a heart attack to provide a visual of the range of death rates. 

## Task 2 - Find the best hospital in a state
For this task, I wrote a function called "best" that took two arguments: 
  1. The 2-character abbreviated name of a state
  2. An outcome name 

The function reads the outcome-of-care-measures.csv file and returns a character vector
with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
be one of \heart attack", \heart failure", or \pneumonia". **Note:** Hospitals that do not have data on a particular
outcome were excluded from the set of hospitals when deciding the rankings.

### Handling Ties
If there is a tie for the best hospital for a given outcome, then the hospital names were sorted in alphabetical order and the first hospital in that set was returned.

### Validity of arguments
If an invalid **state** value was passed to the "best" function, the function returned an error via the stop function with the exact message "invalid state". If an invalid **outcome** value was passed to "best", the function returned am error via the stop function with the exact message "invalid outcome".

## Task 3 - Ranking hospitals by outcome in a state
For this task, I wrote a function called "rankhospital" that took three arguments: 
1. The 2-character abbreviated name of a state (state)
2. An outcome (outcome) 
3. The ranking of a hospital in that state for that outcome (num) - taking the values "best", "worst", or an integer indicating the ranking (smaller numbers are better)

The function reads the outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that has the ranking specified by the num argument. For example, the call rankhospital("MD", "heart failure", 5)
returns a character vector containing the name of the hospital with the 5th lowest 30-day death rate
for heart failure. **Note:** If the number given by num is larger than the number of hospitals in that
state, then the function returns "NA". Hospitals that do not have data on a particular outcome were excluded from the set of hospitals when deciding the rankings. 

### Handling Ties
Multiple hospitals may have the same 30-day mortality rate for a given cause of death. In those cases, the hospital names were sorted in alphabetical order and the first hospital in that set was returned.

### Validity of arguments
If an invalid **state** value was passed to the "rankhospital" function, the function returned an error via the stop function with the exact message "invalid state". If an invalid **outcome** value was passed to "rankhospital", the function returned am error via the stop function with the exact message "invalid outcome".

## Task 4 - Ranking hospitals in all states
For this task, I wrote a function called "rankall" that takes two arguments:
1. An outcome name (outcome)
2. The ranking of a hospital in that state for that outcome (num) - taking the values "best", "worst", or an integer indicating the ranking (smaller numbers are better)

The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame containing the hospital in each state that has the ranking specified in num. For example the function call rankall("heart attack", "best") returns a data frame containing the names of the hospitals that are the best in their respective states for 30-day heart attack death rates. The function returns a value for every state (some may be NA). The first column in the data frame is named hospital, which contains
the hospital name, and the second column is named state, which contains the 2-character abbreviation for the state name. Hospitals that do not have data on a particular outcome were excluded from the set of hospitals when deciding the rankings. 

### Handling Ties
Multiple hospitals may have the same 30-day mortality rate for a given cause of death. In those cases, the hospital names were sorted in alphabetical order and the first hospital in that set was returned.

### Validity of arguments
If an invalid **outcome** value was passed to the "rankall" function, the function returned an error via the stop function with the exact message "invalid outcome". If the number given by **num** is larger than the number of hospitals in that state, the function returned "NA". 
