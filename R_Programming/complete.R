library(data.table)

complete <- function(directory, id=1:332){
        
        # the directory has multiple files so first get the desired files from dir
        files <- paste0(directory, "/", formatC(id, width=3, flag="0"), ".csv" )
        
        # create one large table
        df <-rbindlist(lapply(files, read.csv))
        
        #only keep the complete cases
        df<- df[complete.cases(df),]
        
        # aggregate it by ID
        df<- data.frame(table(df$ID))
        
        #rename columns
        colnames(df)[colnames(df)=="Var1"] <- "id"
        colnames(df)[colnames(df)=="Freq"] <- "nobs"
        
        #return df
        return(df)
        
}

files <- paste0("specdata", "/", formatC(c(2, 4, 8, 10, 12), width=3, flag="0"), ".csv" )

#df <- read.csv(files)
df <-rbindlist(lapply(files, read.csv))
df<- df[complete.cases(df),]
df<- data.frame(table(df$ID))
colnames(df)[colnames(df)=="Var1"] <- "id"
colnames(df)[colnames(df)=="Freq"] <- "nobs"

complete("specdata", c(3))