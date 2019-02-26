download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "2006Microdata.csv")

df <- read.csv('2006Microdata.csv')
#household greater than 10 acres AND agr product > 10,000
#agricultureLogical<- df%>% filter(AGS ==6, ACR ==3 )
agricultureLogical <- which(df$AGS ==6 & df$ACR ==3)
head(agricultureLogical, 3)

#install.packages("jpeg")
library(jpeg)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              "jeff.jpg",
              mode ='wb')

image <- jpeg::readJPEG('jeff.jpg', native = TRUE)

quantile(image, probs= c(.3,.8))

#question 3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              "t1.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              't2.csv')

library(data.table)
library(dplyr)

t1 <- fread('t1.csv',
                 skip = 5,
                 nrows = 190,
                 select = c(1,2,4,5),
                 col.names = c("CountryCode", "Rank","CountryName","GDP_Total")
                 )


t2 <- fread('t2.csv')

mergedf<- inner_join(t1,t2, by = "CountryCode")
nrow(mergedf)


arranged_df <- mergedf %>% arrange(desc(Rank))

high_income <- arranged_df %>% filter (`Income Group`=='High income: OECD')
avg_rank_HI <- mean(high_income$Rank, na.rm = TRUE)

high_income_non <- arranged_df %>% filter (`Income Group`=='High income: nonOECD')
avg_rank_HI_non <- mean(high_income_non$Rank, na.rm = TRUE)







