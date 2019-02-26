#Quiz 
library(jsonlite)
#install.packages("httpuv")
library(httpuv)
library(httr)

# define endpoint
oauth_endpoints("github")

# Change based on what you 
myapp <- oauth_app(appname = "DataCleaning",
                   key = "396f7f0885ecac794b01",
                   secret = "d661d0a0fd2e5402a713c664bcc4aa346651c82e")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

#Take action on http error
stop_for_status(req)

#Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

#Question 2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = "acs.csv")

acs <- read.csv("acs.csv")

sqldf("select pwgtp1 from acs where AGEP < 50")

sqldf("select distinct AGEP from acs")

#How many characters are in the 10th, 20th, 30th and 100th lines 
#of HTML from this page: http://biostat.jhsph.edu/~jleek/contact.html

url <- url("http://biostat.jhsph.edu/~jleek/contact.html")
lines<- readLines(url)
close(url)
c(nchar(lines[10]),
  nchar(lines[20]), 
  nchar(lines[30]), 
  nchar(lines[100]))

        
        















