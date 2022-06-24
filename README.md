
# **Purpose of this document**
This Github repository contains my analysis of the Cyclistic capstone project from the [**Google Data Analytics Professional Course**](https://www.coursera.org/professional-certificates/google-data-analytics).

This capstone project is divided into 2 sections:  
1. The data preparation/processing/analysis phases are done via Rstudio (using Tivdyverse packages)   
2. The data visualization is done via [**Tableau**](https://public.tableau.com/app/profile/nils.nijman/viz/Cyclistic_completed/Tripstotal?publish=yes)  
The endresults can be found in the full_report pdf and as a slideshow presentation in the repository.  


Below you can find the structure and layout of my work with Rstudio.
# **Table of content**
* 1.The scenario 
* 2.Ask
* 3.Prepare
* 4.Process
* 5.Analyse
* 6.Share
* 7.Act


## **1.The Scenario:**
"I am working as a junior data analyst in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, the team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve my recommendations, so they must be backed up with compelling data insights and professional data visualizations."  

## **About the Company**  
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geo-tracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.  

## **Deliverables:**
* 1.A clear statement of the business task
* 2.A description of all data sources used
* 3.Documentation of any cleaning or manipulation of data
* 4.A summary of your analysis
* 5.Supporting visualizations and key findings
* 6.Top three recommendations  

# **2.Ask**  
**Identify the business task**  
The future success of the company depends on the conversion of casual riders to annual memberships. 
The purpose of this analysis is therefore to discover the key differences in the using of rental bikes by 2 different users of the bikes: annual members and casual riders.  

**Statement of the bussiness task:**  
How do annual members and casual riders use rental bikes differently?  

**Key stakeholders:**  
Cyclistic executive team, Director of Marketing (Lily Moreno), Marketing Analytics team.  

# **3.Prepare**  

**Gathering the datasets**  
**Decription of the datasets:**  
**Preparing the datasets**  
**Verifying the credibility of the data:**   

### **To proceed with the next steps of this analysis the excel files are uploaded to R:**
**setting up my environment**


# 4.Process
**Combining the uploaded csv files in to 1 dataframe using rbind:**  
**Summary overview of the full_year dataframe:**  
**Looking up n.a values**  
**Dropping the missing values from the dataset**  
**New summaries**  

## **next steps: finding other irregularities within the dataset**  

**the station_id columns (start and end both) are in the wrong data type (chr) and need to be converted to numeric to perform analysis**  
**Step 1 converting these columns into numeric:**  
**Step 2 checking the result:**  
**Step 3 Checking for added n.a values (there should be some now because of the conversion)**  
**Step 4 Removing the  n.a values from the dataset and assigning a new df to keep track of the changes**  
**Step 5 Checking the result:**   

## **Other problems that need to be addressed:**  

**The dataset can only be aggregated at the ride-level. This is too granular. Adding some additional columns of data such as day, month, year would improve the analysis and provide additional opportunities to aggregate the data**
**Fiddling around I created 2 extra variables (columns): weekdays and day, these can now be dropped**  
**Checking the result**  
**saving these results into a new dataframe V03 before proceeding into the next step**  
## **Problems continued:**  
**Step 1: dropping the existing ride_length column**  
**Step 2: adding the new ride_length column**  
**The new structure of the columns**  
**Step 3: converting "ride_length" from Factor to numeric in order to run calculations on the data**   

## **Last remaining problems:**  
**The dataframe includes entries when bikes were taken out of docks and checked for quality  or ride_length was negative**  
**Final steps**  

# **5.Analysis**    

## Conducting descriptive analysis   
**Descriptive analysis on ride_length (in minutes)**  
**Setting a limit to the max amount of time that a bike could be used to 24 hours (<86400 seconds)**  
**The adjusted descriptive analysis on ride_length (in minutes)**  
**Comparing members and casual users**  
**The average ride time per day for members vs casual users**  
**The correctly ordered day of the week average ride time per day for members vs casual users**  

**Analysis of the ridership data by type and weekday**  

# **6.Share**  
Note: Below follow a few diagrams to check if this cleaned dataset yields results that I can further explore in Tableau  

**Number of rides members and casuals**  
**Average duration of trips**  

**Exporting this dataframe to a CSV file:**  

## **Uploading the csv file to Tableau for further analysis:**  
[Link to the slide show on tableau](https://public.tableau.com/app/profile/nils.nijman/viz/Cyclistic_completed/Tripstotal?publish=yes)   

**Some images from Tableau**  

# Act  
 
## **Key findings**  

**Bike trips**   
* Casual riders make up 43% of the total amount of trips taken as opposed to 57% for members.  
* Both casual and members show the same trend of bike trips throughout the year. Peaking between June and October.  
* Member bike trips stay up a month longer to November before experiencing the same steep drop off.  
* Casual riders primarily take trips on the weekends. Members take trips more evenly spread out over the week.  
* Most bike trips for casual riders start between 12.00 and 18.00. The starting time for members shows a morning peak between 6.00 and 9.00.  

**Ride length**  
* Casual riders (37 minutes) use their bikes 2.4 times longer than members. (16 minutes)   
* Casual rider ride length peaks between june and october. Members maintain a more steady ride length throughout the year.   
* Ride length increases on Friday, Saturday and Sunday for casual riders. For members the average trip length does not vary much per week day.  

**Bike types**  
* Docked bikes are by far the most used bike type by both members and casual riders.  
* The classical bike is used significantly less by casual riders than members.  

### Bussiness statement: 
**How do annual members and casual riders use rental bikes differently?**  

The data shows that casual riders primarily take bike trips during the weekend as opposed to members who take bike trips more evenly spread throughout the week. Casual riders on average also take 2.4 times longer for a single trip, starting their trips later in the day. Both casuals and members take bike trips primarily during the warmer months with a steep decline during the colder months of the year. 

We can therefore conclude that casuals riders on average use the Cyclistic bike services primarily for leisure and not to commute from and to work. 
At the moment Cyclistic offers a single annual membership which does not benefit casual riders as they primarily take trips on the weekends and during the warmer months. My top 3 recommendations therefore are designed to better fit the needs of casual riders. 

# **Top 3 recommendations**  

* 1. Offer a __weekend-only membership__ at a different price point than the full annual membership to entice casual users towards a full annual membership that is valid from Fridays to Sundays. 

* 2. Offer a __half year only_membership__ from May to October instead of the full year annual membership. 

* 3. Combining the above described recommendations, a third option would be to create a half_year_only membership that is only valid on Friday to Sunday. 


 
__To the marketing department:__   
Below I've included a list of the top 20 most used start and end stations, as well as a list with the most popular routes with the average trip length for each station. You can also get full acces to the file here: [Link to the slide show on tableau](https://public.tableau.com/app/profile/nils.nijman/viz/Cyclistic_completed/Tripstotal?publish=yes)
