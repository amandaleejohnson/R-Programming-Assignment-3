##Assigment 4
setwd("C:/Users/ajohns34/Box/Data Science Specialization")
outcome = read.csv("outcome-of-care-measures.csv", na.strings="Not Available",
                   stringsAsFactors = FALSE)



# Ranking hospitals by outcome in a state
# Write a function called rankhospital that takes three arguments: the 2-character abbreviated name of a
# state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
# The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
# of the hospital that has the ranking specified by the num argument. For example, the call
# rankhospital("MD", "heart failure", 5)
# would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate
# for heart failure. The num argument can take values "best", "worst", or an integer indicating the ranking
# (smaller numbers are better). If the number given by num is larger than the number of hospitals in that
# state, then the function should return NA. Hospitals that do not have data on a particular outcome should
# be excluded from the set of hospitals when deciding the rankings.
# Handling ties. It may occur that multiple hospitals have the same 30-day mortality rate for a given cause
# of death. In those cases ties should be broken by using the hospital name. 

rankhospital <- function(abbrev, outcome, rank) {
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
        
        
        #If rank = "best", we need the first row
        if (rank=="best") {
                rank=1
        } else if (rank=="worst") {
                good=complete.cases(subset(newdata, state==abbrev & !is.na(outcome)))
                #Since TRUE=1 and FALSE=0, we can get a count of the number of trues:
                rank=sum(good)
        } else {
                rank=as.numeric(rank)
        }
        
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
                        
                        #Given a specific state and outcome, what is the X row (aka the lowest mortality) of the outcome?
                        state_subset=subset(sorted, state==abbrev)
                        
                        hospital=state_subset$hospital[as.numeric(rank)]
                        return(hospital)
                        
                } else if (outcome %notin% outcomes & abbrev %in% states) {
                        stop("invalid outcome")
                        
                } else if (outcome %in% outcomes & abbrev %notin% states) {
                        stop("invalid state")
                } else if (outcome %notin% outcomes & abbrev %notin% states) {
                        stop("invalid outcome and state")
                }
                
        
}                

rankhospital("TX", "heartfailure", 4)
rankhospital("MD", "heartattack", "worst")
rankhospital("MN", "heartattack", 5000)

       