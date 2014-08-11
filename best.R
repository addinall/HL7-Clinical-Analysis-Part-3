## CAPTAIN SLOG
## vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
## File         : best.R
## System       : Assignment 3 (Autograded)
## Date         : 12/08/2014
## Author       : Mark Addinall
## Synopsis     : This file is part of the course work
##                assignments for the Johns Hopkins
##                series of Data Science units.
##                This unit is R Programming
##

## -------------------------------
best <- function(state, outcome) {
## Read outcome data
## Check that state and outcome are valid
## Return hospital name in that state with lowest 30-day death
## rate


# actually, as usual, that prototype provided is incorrect
# what is the point of loading an entire dataset into memory
# if the arguments are invalid?
#
# it SHOULD be:
#
# check the state and outcome are valid else STOP
# read outcome data
# calculate
# return


outcomes <- c("heart attack", "heart failure", "pneumonia")

if (! outcome %in% outcomes) {
    stop("invalid outcome")
}

hospitals <- read.csv("data/hospital-data.csv")

states <- unique(hospitals[, "State"])

if (! state %in% states) {
    stop("invalid state")
}




}
