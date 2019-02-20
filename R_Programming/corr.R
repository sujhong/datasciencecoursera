source("complete.R")

corr<- function(directory, threshold =0){
        
        # read in all the files in the dir
        files <- list.files(directory, full.names = TRUE)

        
        correlation <- c() 
        
        for(i in 1:length(files)){
                data <- read.csv(files[i])
                # remove NA, the complete cases does this
                data <-data[complete.cases(data),]
                
                #the temp file can also be used to check for nobs
                temp <- complete(directory, i)
                num_ob <- temp$nobs
                
                #for now use the num of rows in data to apply threshold
                if (nrow(data) > threshold ) {
                        correlation <- c(correlation, cor(data$sulfate, data$nitrate) ) 
                }
        }
        return(correlation)
        
}
        
