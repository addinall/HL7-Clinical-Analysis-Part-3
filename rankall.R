## CAPTAIN SLOG
## vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
## File         : rankall.R
## System       : Assignment 3 (Autograded)
## Date         : 18/08/2014
## Author       : Mark Addinall
## Synopsis     : This file is part of the course work
##                assignments for the Johns Hopkins
##                series of Data Science units.
##                This unit is R Programming
##
##
## Write a function called rankall that takes two arguments: 
## an outcome name (outcome) and a hospital rank- ing (num). 
## The function reads the outcome-of-care-measures.csv file 
## and returns a 2-column data frame containing the hospital 
## in each state that has the ranking specified in num. 
##
## For example the function call
## rankall("heart attack", "best") 
## would return a data frame containing the names of the hospitals that
## are the best in their respective states for 30-day heart attack 
## death rates. The function should return a value
## for every state (some may be NA). 
##    
## The first column in the data 
## frame is named hospital, which contains the hospital name, 
## and the second column is named state, which contains the 
## 2-character abbreviation for the state name. Hospitals that 
## do not have data on a particular outcome should be excluded 
## from the set of hospitals when deciding the rankings.


## -----------------------------------------
rankall <- function(outcome, num = "best") {

## Read outcome data
## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name


if (num == "best") {            ## mixing argument types, tsk!
    num <- "1"                  ## who writes these specs?
} else if (num == "worst") {    ## at the end of the program
        num <- "-1"             ## if we find that the rank
}                               ## requested is LESS than 0,
                                ## then we want the LAST record
                                ## in the set to be returned

suppressWarnings(num <- as.numeric(num))

if (is.na(num)) {               ## this shouldn't happen,
    return(num)                 ## BUT, with a very loosely
}                               ## type language, num COULD be "BUM"


outcomes <- c("heart attack", "heart failure", "pneumonia")

if (! outcome %in% outcomes) {
    stop("invalid outcome")
}

outcome_data <- read.csv('data/outcome-of-care-measures.csv', 
                                stringsAsFactors = FALSE)

states <- unique(outcome_data[, "State"])

if (! state %in% states) {
    stop("invalid state")
}

## I am just getting rid of a big ugly column name here.
## way too much typing and prone to error

if (outcome == "heart attack") {
    deaths <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" 
} else if (outcome == "heart_failure") {
    deaths <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
} else {
    deaths <-"Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"}

## sort on two column to resolve ties in scores for first place

sortnames       <- c(deaths, "Hospital.Name")

## trim the dataset down from 46 column to 4 that we need

outcome_data    <- outcome_data[, c("Provider.Number", "Hospital.Name", "State", deaths)]

## and dump all but the state we are interested in

outcome_data    <- subset(outcome_data, outcome_data[, 3] == state)

number_hospitals <- nrow(outcome_data)

## go awy if a silly ROOLY big number record
## is requested

if (number_hospitals < num) {
    return(NA)
}


## we know, we WANT to force the NA converstions

suppressWarnings(outcome_data[,4] <- as.numeric(outcome_data[, 4]))

## dump the NAs
## this came about because the people that put the database
## together mixed numbers with "Too tichy" so R turns the
## whole database into characters.  We need to turn some
## of them back into numbers for the sort.

outcome_data    <- na.omit(outcome_data)

## sort by rank then name

outcome_data <- outcome_data[do.call("order", outcome_data[sortnames]),]

if (num == -1) {                ## worst rank
    num <- nrow(outcome_data)
}

print(outcome_data[num, 2])

}


