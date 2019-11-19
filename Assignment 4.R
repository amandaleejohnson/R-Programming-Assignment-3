##Assigment 4
setwd("C:/Users/ajohns34/Box/Data Science Specialization")

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

#1. Make a simple histogram of the 30-day death rates 
#from heart attack (column 11 in the outcome dataset)
        outcome[, 11] <- as.numeric(outcome[, 11])
        ## You may get a warning about NAs being introduced; that is okay
        hist(outcome[, 11])

        
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
        
        
        #For ease of use, rename the columns
        #?rename
        colnames(outcome)
        names(outcome)[names(outcome) == "State"] <- "state"
        names(outcome)[names(outcome) == "Hospital.Name"] <- "hospital"
        names(outcome)[names(outcome) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"] <- "heartattack"
        names(outcome)[names(outcome) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"] <- "heartfailure"
        names(outcome)[names(outcome) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"] <- "monia"
        
        #Create a subset of the data.frame restricting to a specific state:
        subset_vars=c("state", "hospital", "heartattack", "heartfailure", "monia")
        newdata=outcome[subset_vars]
        
        #Make sure the classes are appropriate:
        lapply(newdata, class)
        newdata$heartattack = as.numeric(newdata$heartattack)
        newdata$heartfailure = as.numeric(newdata$heartfailure)
        newdata$monia = as.numeric(newdata$monia)
                #Check to see if this works:
                lapply(newdata, class)
                
        #Sort the entire data set by state and then within each state, by outcome
        sorted_heartattack = arrange(newdata, state, heartattack, hospital)   
        sorted_heartfailure = arrange(newdata, state, heartfailure, hospital)   
        sorted_monia = arrange(newdata, state, monia, hospital)   
        
        #Given a specific state and outcome, what is the first row (aka the lowest mortality) of the outcome?
        if(state="AK") {
                head(sorted_heartattack, 1)
        } else {
                #Do nothing
        }
        
        
        
        
        
        
        
        
        
best <- function(state, outcome) {
        ## Read outcome data without needing to convert any columns to numeric or character
        ##this will also help the sorts work as expected
                
        ##To make things easier, rename the three columns:
                #Since "state" and "outcome" are in quotes, they will not be populated with the arguments in the function
                names(my_data) = c("hospital", "state", "outcome")
                
        # When selecting an outcome column, think about how you might go about doing that. 
        # Everyone has their preferences but personally I like to do the column subsets 
        # with column indexes. One way might be to use a column index variable that's 
        # based on the outcome function argument. For this particular data set, heart 
        # attack is column 11, heart failure is column 17, and pneumonia is column 23. 
        # All you have to do to select columns is use brackets and pass a numeric vector 
        # to the right side of the comma. For example, if you named your outcome index 
        # column_index, you could select the columns with something like df[, c(2,7,column_index)].
                
                
        # Hint: if you setup a named vector with something like 
        # outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23) 
        # then you can use that to both test the function argument and select the column. 
        # Something like df[, c(2,7,outcomes[outcome])]. Also, when you validate the outcome argument 
        # instead of using %in% outcomes you'd use %in% names(outcomes).        
        
        
        #Mike's Pseudo-code
        
        #begin by reading in data as you have been
                my_data = read.csv("outcome-of-care-measures.csv", na.strings="Not Available",
                                   stringsAsFactors = FALSE)
        #specify a list of outcomes and their associated column numbers
                outcomes = c("heart attack"=11, "heart failure"=17, "pneumonia"=23)    
        
        #Validity Check 1: Is the outcome specified in the function within your outcomes list?
                #e.g., outcome %in% names(outcomes)
                #If not, return stop function
                
                
        #If good, subset data to state, hospital, and outcome columns
                #e.g., sub_data = df[, c(2,7,outcomes[outcome])]
                
        #Validity #2, is the state name specified in the found within your sub_data?
                #e.g., state %in% sub_data$state 
                
        #If state and outcome are both good, subset sub_data to just your state
                #Then, either arrange data or use min() / max() functions to find row with value of interest
                #Consider examples:
                #get a subset table
                #subset = data[data$col1 == "MS" & data$col2 < 10,]
                #get a subset column/value
                #subset_col = data$col3[data$col1 == "MS" & data$col2 < 10,]
                
                
        #Validity checks
        #write a few if statements to check if the "state" value is included in the 
                
                
                
                #What does this do? 
                
        ## Check that state and outcome are valid
                
        ##You can use na.omit or complete.cases to remove NA values but don't do that until you've 
        # reduced the data to only one output column plus name and state. If you remove NAs immediately
        # after reading the data you can lose data that you need.        
        
                
        ## Return hospital name in that state with lowest 30-day death
                return()
        ## rate
}                


        
#Try this outside of a function - example: \heart attack" in Minnesota
        #Use the subset function to limit the data to hospitals in MN:
                ny_subset_outcome=subset(newdata, state=="NY", c("hospital", "heartattack", "heartfailure", "monia"))

        #Use plyr::arrange() to sort the data frame by X
        library(plyr)
                arrangedoutcome_monia=arrange(ny_subset_outcome, monia)        
                arrangedoutcome_heartattack=arrange(ny_subset_outcome, heartattack)        
                arrangedoutcome_heartfailure=arrange(ny_subset_outcome, heartfailure)        
                top_monia = head(arrangedoutcome_monia, 10)
                top_attack = head(arrangedoutcome_heartattack, 10)
                top_failure = head(arrangedoutcome_heartfailure, 10)
        top_monia
        top_attack
        top_failure
        
# Ranking
# Think logically about the data and ranking. 
# For example, if you were to sort by state then outcome then hospital name then your data 
# will be in proper rank order including the tie breaker. At that point, all you have to do 
# is take a state subset and use an index to get best, worst, or a particular rank. 
# For best you'd use 1 for the index, for worst you'd use nrow(your_subset) and for just 
# num you'd use that num. Don't worry about testing for num greater than number of rows 
# because if you use an index larger then the number of rows you'll get NA which is what you want anyway.        
        ?arrange
        sorted_newdata=arrange(newdata, state, monia, hospital)   
        ak_subset_ha=subset(sorted_newdata, state=="AK")
        print(ak_subset_ha[1,])
        print(ak_subset_ha[nrow(ak_subset_ha),])
        print(mn_subset_ha[nrow(mn_subset_ha),])

        
# Processing the data
# Suppose you have data in three columns ordered by state then outcome then hospital. 
# Then suppose you split on state using something like split(your_data, your_data$state). 
# You get a list of data frames ordered by state. Because you already ordered the data everything 
# else is in rank order. Then suppose you only want a list of hospitals by rank. You run the list 
# of data frames through lapply and use a function to store the hospital names in a list.
        state_df = split(sorted_newdata, sorted_newdata$state)
# What happens is lapply runs each item in the list through the function. The data passed to the function 
# is one of the data frames from the list created by split(). The value returned by that function gets stored 
# in the results of lapply() which is a list.

# So, if you split the data frame on state then lapply(split.data, hospitalNameFunction) would return a list 
# where the name of each item is state and the value is the hospital name. You can get the values as a vector 
# using unlist(results_of_lapply). You can get the states using names(results_of_lapply). You could also use 
# sapply and then you wouldn't need to use unlist.
        lapply(state_df, hospital) 
# Then all you have to do is assemble the data frame using the unlisted values and list names using something 
# like this - data.frame(hospital=unlisted_values, state=list_names, row.names=list_names).        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        