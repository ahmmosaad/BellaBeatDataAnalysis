<p align="center">
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdw-ISja4k09NZu5Mn19WPYIis_oMk0G2suQ&s">
</p>

# BellaBeat
Bellabeat, a high-tech manufacturer of health-focused products for women. Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market.

## Case
Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smartdevice fitness data could help unlock new growth opportunities for the company.

## Data Source
Public Dataset stored in Kaggle [FitBit fitness tracker data](https://www.kaggle.com/datasets/arashnic/fitbit)

## Data Exploration
The Data contains 18 files and after exploration, I found that:

1. Data about the daily activity (total steps, calories burned, heart rate, activity type) and sleep data.
2. The file called __DailyActivity__ contains the data of __DailyIntensities__, __DailyCalories__, and __DailySteps__.
3. A file called __HourlySteps__.
4. 12 files about minute tracking of __DailyActivity__ file data.
5. A file called __WeightLogFile__ will be excluded because of the small number of samples [just 8 persons!].
6. The last file __SleepDay__ contains all sleep data.


I used __SQL__ to do queries on data to get the following insights:
1. How many users are in the sample and the period?
2. Classification of the user upon daily steps to: Light Active, Moderately Active, Sedentary, and Very Active.
3. What is the most active day of the week?
4. what is the most active hour of the day?
5. what is the longest day users sleep?
6. How many days do users wear smart devices during sleep?
7. classification of users based on smart device usage to low, medium, and high.
8. Percentage of daytime users wear smart devices.

All SQL Queries collected and well documented in this file: [SQL Queries](https://github.com/ahmmosaad/BellaBeatDataAnalysis/blob/main/BellaBeat%20SQL.sql)










