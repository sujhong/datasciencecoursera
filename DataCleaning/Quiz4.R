df1 <- read.table("2006Microdata.csv", sep = ",", header = TRUE)
q1
wgtp <- strsplit(names(df1), "wgtp")
wgtp[123]



#q2
library(data.table)
gdp <- fread('t1.csv',
                   skip = 5,
                   nrows = 190,
                   select = c(1,2,4,5),
                   col.names = c("CountryCode", "Rank","CountryName","GDP_Total")
)

gdp_clean <- gsub(pattern = ",", replacement = "", x = gdp$GDP_Total)
avg <- mean(as.integer(gdp_clean),na.rm= TRUE)

#q3
united <- grep("^United", gdp$CountryName)


t2 <- fread('t2.csv')
mergedf<- inner_join(gdp,t2, by = "CountryCode")

#q4
fiscal_year <- grepl(pattern= "Fiscal year end: June 30;", mergedf$`Special Notes`, .N)
sum(fiscal_year==TRUE)


#q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)

sample_year <- grep(pattern= "2012-", sampleTimes)
length(sample_year)




sample_year_day<-weekdays(ymd(as.Date(sample_year)))
mondays<- grep(pattern= "Monday", sample_year_day, .N)
length(mondays)


















