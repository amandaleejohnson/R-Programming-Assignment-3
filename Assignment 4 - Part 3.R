##Assigment 4
setwd("C:/Users/ajohns34/Box/Data Science Specialization")
outcome = read.csv("outcome-of-care-measures.csv", na.strings="Not Available",
                   stringsAsFactors = FALSE)
head(outcome)


# Ranking hospitals in all states
# Write a function called rankall that takes two arguments: an outcome name (outcome) and a hospital rank-
# ing (num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
# containing the hospital in each state that has the ranking specified in num. For example the function call
# rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
# are the best in their respective states for 30-day heart attack death rates. The function should return a value
# for every state (some may be NA). The first column in the data frame is named hospital, which contains
# the hospital name, and the second column is named state, which contains the 2-character abbreviation for
# the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
# hospitals when deciding the rankings.


rankall <- function(outcome, rank = "best") {
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
        
        #Validity Check 1: Is the outcome specified in the function within your outcomes list?
        #e.g., outcome %in% names(outcomes)
        #If not, return stop function
        outcomes = c("heartattack", "heartfailure", "monia")

        
        #Make a function that is the opposite of %in%:
        "%notin%" = function(x,y)!("%in%"(x,y))
        
        #Make a list of all unique states in dataset:
        states=unique(newdata$state)
        
        #If everything is good to go, run the function:
        if (outcome %in% outcomes){
                new_data=data.frame(matrix(ncol=5, nrow=0)) #Start out with an empty data frame
                cols=c("state", "hospital", "heartattack", "heartfailure", "monia")
                colnames(new_data) = cols
                
                
                #Need to include "parse(text=))" so that R evaluates outcome as a var, not text
                sorted = arrange(newdata, state, eval(parse(text=outcome)), hospital)        
                
                #If rank = "best", we need the first row
                if (rank=="best") {
                        for (i in states) {
                                #Given a specific state and outcome, what is the X row (aka the lowest mortality) of the outcome?
                                state_subset=subset(sorted, state==i & !is.na(eval(parse(text=outcome))))
                                rank=1
                                to_insert=head(state_subset, 1)
                                new_data=rbind(new_data, to_insert)
                        }
                } else if (rank=="worst") {
                        for (i in states) {        
                                #Given a specific state and outcome, what is the X row (aka the lowest mortality) of the outcome?
                                state_subset=subset(sorted, state==i & !is.na(eval(parse(text=outcome))))
                                rank=nrow(state_subset)
                                to_insert=state_subset[rank,]
                                new_data=rbind(new_data, to_insert)
                        }        
                } else {
                        for (i in states) {        
                                #Given a specific state and outcome, what is the X row (aka the lowest mortality) of the outcome?
                                state_subset=subset(sorted, state==i & !is.na(eval(parse(text=outcome))))
                                #rank=as.numeric(rank)
                                to_insert=state_subset[rank,]
                                new_data=rbind(new_data, to_insert)
                        }        
                }
                
        } else if (outcome %notin% outcomes) {
                stop("invalid outcome")
                
        }       
        return(new_data)

}

head(rankall(outcome="heartattack", rank=20), 10)
tail(rankall("monia", rank="worst"), 5)
tail(rankall("heartfailure"), 10)
