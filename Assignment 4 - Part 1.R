##Assigment 4
setwd("C:/Users/ajohns34/Box/Data Science Specialization")
outcome = read.csv("outcome-of-care-measures.csv", na.strings="Not Available",
                   stringsAsFactors = FALSE)


#2. Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
# outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
# with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
# in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
# be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not have data on a particular
# outcome should be excluded from the set of hospitals when deciding the rankings.

# Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
# be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals "b", "c",
# and "f" are tied for best, then hospital "b" should be returned).

# The function should check the validity of its arguments. If an invalid state value is passed to best, the
# function should throw an error via the stop function with the exact message "invalid state". If an invalid
# outcome value is passed to best, the function should throw an error via the stop function with the exact
# message "invalid outcome".

        best <- function(abbrev, outcome) {
                
                #Read in the data:
                caremeasures = read.csv("outcome-of-care-measures.csv", na.strings="Not Available",
                                        stringsAsFactors = FALSE)
                
                
                #For ease of use, rename the columns
                names(caremeasures)[names(caremeasures) == "State"] <- "state"
                names(caremeasures)[names(caremeasures) == "Hospital.Name"] <- "hospital"
                names(caremeasures)[names(caremeasures) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"] <- "heartattack"
                names(caremeasures)[names(caremeasures) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"] <- "heartfailure"
                names(caremeasures)[names(caremeasures) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"] <- "monia"
                
                
                
                #Create a subset of the data.frame restricting to a specific state:
                subset_vars=c("state", "hospital", "heartattack", "heartfailure", "monia")
                newdata=caremeasures[subset_vars]
                
                
                #Make sure the classes are appropriate:
                newdata$heartattack = as.numeric(newdata$heartattack)
                newdata$heartfailure = as.numeric(newdata$heartfailure)
                newdata$monia = as.numeric(newdata$monia)
                
                
                #Make a list of all unique states in dataset:
                states=unique(newdata$state)
                
                
                #Validity Check 1: Is the outcome specified in the function within your outcomes list?
                #e.g., outcome %in% names(outcomes)
                #If not, return stop function
                outcomes = c("heartattack", "heartfailure", "monia")
                
                #Validity Check 2: Is the state a real state?
                #If not, return stop function
                states=unique(newdata$state)
                
                #Make a function that is the opposite of %in%:
                "%notin%" = function(x,y)!("%in%"(x,y))
                
                #If everything is good to go, run the function:
                if (outcome %in% outcomes & abbrev %in% states){
                        #Need to include "parse(text=))" so that R evaluates outcome as a var, not text
                        sorted = arrange(newdata, state, eval(parse(text=outcome)), hospital)   
                        
                        #Given a specific state and outcome, what is the first row (aka the lowest mortality) of the outcome?
                        #worsthospital=head(state_subset, 1)
                        state_subset=subset(sorted, state==abbrev)
                        
                        worsthospital=head(state_subset, 1)
                        return(worsthospital)
                } else if (outcome %notin% outcomes & abbrev %in% states) {
                        stop("invalid outcome")
                        
                } else if (outcome %in% outcomes & abbrev %notin% states) {
                        stop("invalid state")
                } else if (outcome %notin% outcomes & abbrev %notin% states) {
                        stop("invalid outcome and state")
                }
                
                
        }                
        
        best(abbrev="MN", outcome="monia")
        best(abbrev="XX", outcome="monia")
        best(abbrev="MN", outcome="poop")
        best(abbrev="XX", outcome="poop")        

