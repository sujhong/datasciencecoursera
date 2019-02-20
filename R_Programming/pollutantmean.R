library(data.table)

pollutantmean <- function(directory, pollutant, id=1:332){
        
        # the directory has multiple files so first get the desired files from dir
        files <- paste0(directory, "/", formatC(id, width=3, flag="0"), ".csv" )
        
        # create one large table
        df <-rbindlist(lapply(files, read.csv))
        df <- lapply(df, as.numeric)
        
        # create a list with all the averages
        average= lapply(df, mean, na.rm= TRUE)
        
        # only return the pollutants
        return(average[pollutant])
        
}

