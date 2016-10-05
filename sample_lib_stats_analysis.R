library(psych)
library(ggplot2)
library(tidyr)
library(reshape)


##read in data
stats <- read.csv(file = "library_stats_fixed.csv", header = TRUE)

##let's explore the data by looking at the first few rows
head(stats)

##we need to split apart our month and year so we can do our analysis. this will look in the date column and wherever it sees a period, it will split up our column into separate rows called month and year
stats <- separate(data = stats, col = date, into = c("month", "year"), sep = "\\.")
head(stats)

##so we have the full year, let's add 2000 to everything in our year column
stats$year <- as.factor(as.numeric(stats$year) + 2000)
head(stats)

##we need to do one quick fix on our data - R is currently treating our month variable as a character, but it is actually a categorical (ie factor) variable
str(stats)

##we'll just tell it to treat that as a factor variable, and since we want our months to go in order, we'll tell it to treat it as an ordered factor
months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec") #give it the order of months
stats$month <- as.factor(stats$month) #tell it to treat month as a factor
stats$month <- factor(stats$month, levels = months) #further specify it should treat month as an ordered factors using the months list we just gave it

##let's make a visualization - how about gate count by month, with a different bar for each of our years
ggplot(stats, aes(x = month, y = gate_count, fill = year)) + geom_bar(stat = "identity", position = "dodge")

##once we write that code, we can easily adapt to see other variables
ggplot(stats, aes(x = month, y = items_circulated, fill = year)) + geom_bar(stat = "identity", position = "dodge")

##what it we want to see it just by year?
ggplot(stats, aes(x = year, y = items_circulated)) + stat_summary(fun.y = sum, geom = "bar")

##how about looking at average gate count by month, to see when we're busiest?
ggplot(stats, aes(x = month, y = gate_count)) + stat_summary(fun.y = mean, geom = "bar")

##how about doing some basic descriptive stats? we can get a really basic overview
summary(stats)

##it might be more interesting to see this by month, or by year.  We can do that!
describeBy(stats, group = stats$month) #by month
describeBy(stats, group = stats$year) #by year
