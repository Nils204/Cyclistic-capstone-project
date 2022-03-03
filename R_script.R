
##preparing stage of the analysis process (Setting up my workenvironment on R and uploading the dataset)  ##

## remove this: setwd("C:/Users/nils_/OneDrive/Bureaublad/Bike share case study/Processing_data/Version_1_ride_length&week_day")

#Step 1 setting up my environment:

setwd("C:/Users/nils_/Documents/Bike share case study/Processing_data/Version_1_ride_length&week_day")


##packages##
library(tidyverse)
library(readxl)
library(here)
library(janitor)
library(dplyr)
library(lubridate)

#Step 2 preparing the files

##importing the datasets##
y2020_04 <- read_excel("2020-04-divvy-tripdata.xlsx")
y2020_05 <- read_excel("2020-05-divvy-tripdata.xlsx")
y2020_06 <- read_excel("2020-06-divvy-tripdata.xlsx")
y2020_07 <- read_excel("2020-07-divvy-tripdata.xlsx")
y2020_08 <- read_excel("2020-08-divvy-tripdata.xlsx")
y2020_09 <- read_excel("2020-09-divvy-tripdata.xlsx")
y2020_10 <- read_excel("2020-10-divvy-tripdata.xlsx")
y2020_11 <- read_excel("2020-11-divvy-tripdata.xlsx")
y2020_12 <- read_excel("2020-12-divvy-tripdata.xlsx")
y2021_01 <- read_excel("2021-01-divvy-tripdata.xlsx")
y2021_02 <- read_excel("2021-02-divvy-tripdata.xlsx")
y2021_03 <- read_excel("2021-03-divvy-tripdata.xlsx")

##combining all datasets into 1##
full_year <- rbind(y2020_04, y2020_05, y2020_06, y2020_07, y2020_08, y2020_09, y2020_10, y2020_11, y2020_12, y2021_01, y2021_02, y2021_03)


#Step 3 Processing stage of the analysis process (data cleaning process)

##getting a summary overview of the combined dataset##
colnames(full_year)
skimr::skim_without_charts(full_year)
glimpse(full_year)
head(full_year)

##Looking up how many missing values there are in this dataset (full_year)##
sum(is.na(full_year))
## 541,776 missing values out of a total of 3,489,748 this amounts to 15.5% of the total dataset##
## to further specify in which columns the missing values are concentrated:##
colSums(is.na(full_year))
##All missing values reside in the ride_length, station names/id and end_lat/lng columns.
##This means that if I want to use these columns for further analysis I have to address these missing values

##Dropping the missing values from the dataset##
full_year_cleaned <- na.omit(full_year)
##after dropping the missing values 3294375 out of 3489748 remain. meaning that 195373 missing values are removed (5.6%)

##New summaries##
sum(is.na(full_year_cleaned))
skimr::skim_without_charts(full_year_cleaned)
glimpse(full_year_cleaned)
head(full_year_cleaned)

##next steps: finding other irregularities within the dataset##

#PROBLEM: the station_id columns (start and end both) are in the wrong data type (chr) needs to be converted to numeric to perform analysis##
class(full_year_cleaned$start_station_id) 
class(full_year_cleaned$end_station_id)
##Further steps:
##Looking up the unique values of these 2 columns there are many entries that include Letters, this is probably why R converted the column into a Character string.##
##These values are useless because there is no way for me to interpret them. These values need to be omitted from the df

##Step 1 converting these columns into numeric METHOD: "mutate as.numeric function"
full_year_cleaned_V01 <- mutate(full_year_cleaned, start_station_id = as.numeric(start_station_id),
                   end_station_id = as.numeric(end_station_id))

##Step 2 checking if this has worked because there was a warning sign:
class(full_year_cleaned_V01$start_station_id)
class(full_year_cleaned_V01$end_station_id)
##Step 3 Checking for added n.a values (there should be some now because of the conversion)
sum(is.na(full_year_cleaned_V01))
##Step 4 Removing the  n.a values from the dataset and assigning a new df to keep track of the changes
full_year_cleaned_V02 <- na.omit(full_year_cleaned_V01)
##Step 5 Checking if this has worked 
sum(is.na(full_year_cleaned_V02))
colSums(is.na(full_year_cleaned_V02))

##this problem is solved! :) 

# Other problems that need to be addressed:
## (1) The data can only be aggregated at the ride-level, which is too granular. 
## adding some additional columns of data such as day, month, year improves the analysis, 
## it provides additional opportunities to aggregate the data.
## Because of the settings of my laptop R automatically formats the days of the weeks in Dutch. Have not found a workaround to change this!

full_year_cleaned_V02$date <- as.Date(full_year_cleaned_V02$started_at)
full_year_cleaned_V02$month <- format(as.Date(full_year_cleaned_V02$date), "%m")
full_year_cleaned_V02$month_day <- format(as.Date(full_year_cleaned_V02$date), "%d")
full_year_cleaned_V02$year <- format(as.Date(full_year_cleaned_V02$date), "%Y")
full_year_cleaned_V02$day_of_week <- format(as.Date(full_year_cleaned_V02$date), "%A")

glimpse(full_year_cleaned_V02)

## Fiddling around I created 2 extra variables (columns): weekdays and day, these can now be dropped from this dataframe
full_year_cleaned_V02$day = NULL
full_year_cleaned_V02$weekdays = NULL

#From the original data set I created an extra column in excel called week_day, this column can also be removed as it replaced by the data added in problem 1
full_year_cleaned_V02$week_day = NULL

## Checking the result
glimpse(full_year_cleaned_V02)
## saving these results into a new dataframe V03 before proceeding into the next step
full_year_cleaned_V03 <- full_year_cleaned_V02



## (2) The ride length_column holds a date PLUS the time, I only want to preserve the time part of the column 
## Alternative: used the timediff function to calculate the ridelength and dropping the existing ride_length column
#Step 1: delete the existing ride_length column
full_year_cleaned_V03$ride_length = NULL
#Step 2: adding the new ride_length column
full_year_cleaned_V03$ride_length <- difftime(full_year_cleaned_V03$ended_at,full_year_cleaned_V03$started_at)

## Inspect the structure of the columns
str(full_year_cleaned_V03)

## Convert "ride_length" from Factor to numeric so we can run calculations on the data
is.factor(full_year_cleaned_V03$ride_length)
full_year_cleaned_V03$ride_length <- as.numeric(as.character(full_year_cleaned_V03$ride_length))
is.numeric(full_year_cleaned_V03$ride_length)

##testing filter on start_station_name
full_year_cleaned_V03 %>% 
  filter(start_station_name=="HQ QR")
  

# Remove "bad" data
# The dataframe includes entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative
full_year_cleaned_V04 <- full_year_cleaned_V03[!(full_year_cleaned_V03$start_station_name == "HQ QR" | full_year_cleaned_V03$ride_length<1),]
# Remove "bad" data

?is.na
sum(is.na(full_year_cleaned_V04))
full_year_cleaned_V04
str(full_year_cleaned_V04)


# Step 4: Conducting descriptive analysis

# Descriptive analysis on ride_length (all figures in seconds then converted to minutes)
mean(full_year_cleaned_V04$ride_length/60) #straight average (total ride length / rides)
median(full_year_cleaned_V04$ride_length/60) #midpoint number in the ascending array of ride lengths
max(full_year_cleaned_V04$ride_length/60) #longest ride
min(full_year_cleaned_V04$ride_length/60) #shortest ride

## Discovered that the max ride_length is longer than 24 hours! (58720 minutes / >40 days!) This skews the results of the analysis.
## Set a limit to the max amount of time that a bike could be used to 24 hours (<86400 seconds)

full_year_cleaned_V04 <- full_year_cleaned_V04[!(full_year_cleaned_V04$ride_length>86400),]

##Performed the same descriptive analysis
summary(full_year_cleaned_V04$ride_length/60)
mean(full_year_cleaned_V04$ride_length/60) #straight average (total ride length / rides)
median(full_year_cleaned_V04$ride_length/60) #midpoint number in the ascending array of ride lengths
max(full_year_cleaned_V04$ride_length/60) #longest ride
min(full_year_cleaned_V04$ride_length/60) #shortest ride


# Compare members and casual users
aggregate(full_year_cleaned_V04$ride_length/60 ~ full_year_cleaned_V04$member_casual, FUN = mean)
aggregate(full_year_cleaned_V04$ride_length/60 ~ full_year_cleaned_V04$member_casual, FUN = median)
aggregate(full_year_cleaned_V04$ride_length/60 ~ full_year_cleaned_V04$member_casual, FUN = max)
aggregate(full_year_cleaned_V04$ride_length/60 ~ full_year_cleaned_V04$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
aggregate(full_year_cleaned_V04$ride_length/60 ~ full_year_cleaned_V04$member_casual + full_year_cleaned_V04$day_of_week, FUN = mean)

# Problem: The days of the week are out of order, 
full_year_cleaned_V04$day_of_week <- ordered(full_year_cleaned_V04$day_of_week, levels=c("maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag", "zondag"))

# Trying again to find the average ride time by each day for members vs casual users this time in the correct order
aggregate(full_year_cleaned_V04$ride_length/60 ~ full_year_cleaned_V04$member_casual + full_year_cleaned_V04$day_of_week, FUN = mean)
#Do not know how to fix the ordered function without loosing the woensdag. Have to leave this as it is without the days in the correct order. 

# analyze ridership data by type and weekday

full_year_cleaned_V04 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(ride_length/60)) %>% 		# calculates the average duration
  arrange(member_casual, weekday)								# sorts

# Visualizing the number of rides by rider type
full_year_cleaned_V04 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# Visualization of the average duration
full_year_cleaned_V04 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

##Exporting this dataframe to a CSV file:
write.csv(Your DataFrame,"Path to export the DataFrame\\File Name.csv", row.names = FALSE)
write.csv(full_year_cleaned_V04, file = "bike_share_completed.csv")
