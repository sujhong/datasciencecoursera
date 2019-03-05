library("data.table")
library("dplyr")
library("ggplot2")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

activity <- fread("activity.csv")

# group steps by date
totStep <- aggregate(steps~date, activity, sum, na.action = NULL)

head(totStep, 10)

#histogram
ggplot(totStep, aes(x = steps)) +
        geom_histogram(fill = "green", binwidth = 1000) +
        labs(title = "Daily Steps", x = "Steps", y = "Frequency")

# median and mean per day 
meanSteps <- as.character(mean(totStep$steps, na.rm = TRUE))
medianSteps <- median(totStep$steps, na.rm = TRUE)

print(paste0("Mean: ", medianSteps) )
print("Median: "+medianSteps )

interval <- activity[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps"), by = .(interval)] 
ggplot(interval, 
       aes(x = interval , y = steps)) + 
        geom_line(color="green", size=1) + 
        labs(title = "Average Daily Steps", x = "Interval", y = "Average Steps per day")

interval[steps == max(steps), .(max_interval = interval)]

sum(is.na(activity))
activityDT[is.na(steps), "steps"] <- activityDT[, c(lapply(.SD, median, na.rm = TRUE)), .SDcols = c("steps")]


activity_noNA <- activity %>% mutate(steps= ifelse(is.na(steps),
                                                   activity[, c(lapply(.SD, median, na.rm = TRUE)), .SDcols = c("steps")], steps))

data.table::fwrite(x = activity_noNA, file = "tidyData.csv", quote = FALSE)


#histogram
# group steps by date
totStep <- aggregate(as.integer(steps)~date, activity_noNA, sum)
colnames(totStep) <- c("date","step")

ggplot(totStep, aes(x = step)) +
        geom_histogram(fill = "blue", binwidth = 1000) +
        labs(title = "Daily Steps", x = "Steps", y = "Frequency")

# median and mean per day 
meanStepsNoNA <- mean(totStep$step)
medianStepsNoNA <- median(totStep$step)

print(paste0("With NA Mean: ", medianSteps))
print(paste0("With NA Filled with Median Mean: ", meanStepsNoNA))

print(paste0("With NA Median: ",medianSteps))
print(paste0("With NA Filled with Median Median: ", medianStepsNoNA))


