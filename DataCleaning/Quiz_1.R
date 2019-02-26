df <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "2006Idaho_housing.csv")

df <- read.csv("2006Idaho_housing.csv", header = TRUE)

head(df)
# how many properies are worth $1,000,000 or more
## property value is in column VAL
## looking for properties where VAL >= 1000000

property <- df %>% select(VAL) %>% na.omit
head(property,5)
property <- property %>% filter(VAL >=24)

dim(property)

# Question 3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", 
              destfile = "NaturalGasAquisition.xlsx")

df <- read.xlsx

#Question 4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", 
              destfile = "baltimoreRestaurants.xml")
df <- xmlParse("baltimoreRestaurants.xml")

rootNode <-xmlRoot(df)

## how many rest. have zipcode 21231
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")


#Question 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = "20016Housing.csv")
dt <- fread("20016Housing.csv",sep =",")

#microbenchmark library can run multiple version of the query with recorded time
mbm = microbenchmark(
        v3 = sapply(split(dt$pwgtp15,dt$SEX),mean),
        v6 = dt[,mean(pwgtp15),by=SEX],
        v7 = tapply(dt$pwgtp15,dt$SEX,mean),
        v8 = mean(dt$pwgtp15,by=dt$SEX),
        times=100
)


system.time(DT[,mean(pwgtp15),by=SEX]) ## gives user system and elasped time stamps