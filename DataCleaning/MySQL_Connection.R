#VERY Important to close connection once you're done using it

#connect database:
ucscDb<-dbConnect(MySQL(), 
                  user = "genome",
                  host = "genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(ucscDb, "show databases;");

dbDisconnect(ucscDb);

# connecting to hg10 and listing tables
hg19<-dbConnect(MySQL(), 
                  user = "genome",
                  db="hg19",
                  host = "genome-mysql.cse.ucsc.edu")

#over 10K tables in the database
allTables<- dbListTables(hg19)
length(allTables)

allTables[1:15]

# get dimensions of a specific table
dbListFields(hg19, "affyU133Plus2") ## returns all the fields in that table 

dbGetQuery(hg19, "select count(*) from affyU133Plus2") ## returns the total number of rows


# read table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

#select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affMis <- fetch(query);
dim(affMis)

dbDisconnect(hg19)







