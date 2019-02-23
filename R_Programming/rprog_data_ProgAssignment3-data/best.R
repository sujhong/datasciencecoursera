# this function takes in two arguments and returns the hospital with the lowest 30 day mortality for the specified outcome

best <- function(state, outcome){
        # read outcome data
        df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        # rename columns for easier use/read
        colnames(df)[11] <- "heartAttack_mortalityRate"
        colnames(df)[17] <- "heartFailure_mortalityRate"
        colnames(df)[23] <- "pneumonia_mortalityRate"
        colnames(df)[2] <- "name"
        
        # change case to lower
        state <- toupper(state)
        outcome <- tolower(outcome)
        
        # get q list of unique states
        unique_state <- unique(df$State)
        conditions <- c('heart attack', 'heart failure', 'pneumonia')
        
        
        # check that state and outcome are valid
        ## if an invalid state is passed to best, then function should throw an error via stop function
        ## with the exact message "invalid state"
        ## if an invalid outcome is passed, then throw an error with the message "invalid outcome"
        if (!(state %in% unique_state)){
                stop("invalid state")
        } 
        if (!(outcome %in% conditions)){
                stop ("invalid outcome")
        } 
                
        
        # remove uncessary columns
        temp<- df[,c("name","State","heartAttack_mortalityRate","heartFailure_mortalityRate","pneumonia_mortalityRate")]
        
        # create a temp table that data for state 
        temp <- df[df$State == state,]

        
        # subset data more to just desired columns
        ##return hospital name in that state with lowest 30 day death rate
        if (outcome == "heart attack"){
                #remove uncessary columns
                temp <- temp[,c("name","heartAttack_mortalityRate")]
           
                #change the data type to numeric
                temp$heartAttack_mortalityRate <- as.numeric(temp$heartAttack_mortalityRate)
                
                # remove NA
                temp <- temp[complete.cases(temp),]
                
                #order by rate then hosptial name
                temp <- temp[order(temp$heartAttack_mortalityRate,temp$name),]
                
                #return hospital name
                return(temp$name[1])
        } else if (outcome == "heart failure"){
                temp <- temp[,c("name","heartFailure_mortalityRate")]
                temp$heartFailure_mortalityRate <- as.numeric(temp$heartFailure_mortalityRate)
                temp <- temp[complete.cases(temp),]
                temp <- temp[order(temp$heartFailure_mortalityRate,temp$name),]
                return(temp$name[1])
        } else if(outcome == "pneumonia"){
                temp <- temp[,c("name","pneumonia_mortalityRate")]
                temp$pneumonia_mortalityRate <- as.numeric(temp$pneumonia_mortalityRate)
                temp <- temp[complete.cases(temp),]
                temp <- temp[order(temp$pneumonia_mortalityRate,temp$name),]
                return(temp$name[1])
        }
}       
        

