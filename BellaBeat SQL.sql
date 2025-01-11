
-- Explore Data

select * 
from Bellabeat.DailyActivity

select * 
from Bellabeat.HourlySteps

select * 
from Bellabeat.SleepDay



-- get some information about sample

select count(distinct id) as TotalUsers, count(distinct ActivityDate) as TimePeriod
from Bellabeat.DailyActivity
-- 33 user for 31 days

select count(distinct id), count(distinct ActivityHour)
from Bellabeat.HourlySteps
-- 33 User for 736 hours

select count(distinct id) as SleepTotalUsers, count(distinct SleepDay)  as SleepTimePeriod
from Bellabeat.SleepDay
-- 24 user for 31 Days


-- generate weekday for daily activity and sleep day
-- generate dayhour for hourly steps 
select * , DATENAME(WEEKDAY, ActivityDate) as WeekDay
from Bellabeat.DailyActivity

select * , DATENAME(WEEKDAY, SleepDay) as WeekDay
from Bellabeat.SleepDay

select * ,  Format(activityhour, 'hh:mm:ss') as DayHour
from Bellabeat.hourlySteps



-- categories People upon activity level for 
-- Sedentary, Low active, Active, Highly active  
-- source: (https://www.10000steps.org.au/learn-and-discover/counting-steps/)

select * , 
-- DATENAME(WEEKDAY, ActivityDate) as WeekDay, 
CASE
    WHEN TotalSteps < 5000 THEN 'Sedentary'
    WHEN TotalSteps > 5000 and TotalSteps< 7500 THEN 'Light Active'
	WHEN TotalSteps > 7500 and TotalSteps < 10000 THEN 'Moderatly Active'
	WHEN TotalSteps > 10000 THEN 'Very Active'
END AS UserActivityClass
from (
select 
id,
avg(TotalSteps) as TotalSteps,
avg(TotalDistance) as TotalDistance,
avg(TrackerDistance) as TrackerDistance,
avg(LoggedActivitiesDistance) as LoggedActivitiesDistance,
avg(VeryActiveDistance) as VeryActiveDistance,
avg(ModeratelyActiveDistance) as ModeratelyActiveDistance,
avg(LightActiveDistance) as LightActiveDistance,
avg(SedentaryActiveDistance) as SedentaryActiveDistance,
avg(VeryActiveMinutes) as VeryActiveMinutes,
avg(FairlyActiveMinutes) as FairlyActiveMinutes,
avg(LightlyActiveMinutes) as LightlyActiveMinutes,
avg(SedentaryMinutes) as SedentaryMinutes,
avg(Calories) as Calories
from Bellabeat.DailyActivity
group by id 
) as  Average

-- Calculate numer of user / activity class

select UserActivityClass, count(id) as ClassUserCount
from(
select * , 
-- DATENAME(WEEKDAY, ActivityDate) as WeekDay, 
CASE
    WHEN TotalSteps < 5000 THEN 'Sedentary'
    WHEN TotalSteps > 5000 and TotalSteps< 7500 THEN 'Light Active'
	WHEN TotalSteps > 7500 and TotalSteps < 10000 THEN 'Moderatly Active'
	WHEN TotalSteps > 10000 THEN 'Very Active'
END AS UserActivityClass
from (
select 
id,
avg(TotalSteps) as TotalSteps,
avg(TotalDistance) as TotalDistance,
avg(TrackerDistance) as TrackerDistance,
avg(LoggedActivitiesDistance) as LoggedActivitiesDistance,
avg(VeryActiveDistance) as VeryActiveDistance,
avg(ModeratelyActiveDistance) as ModeratelyActiveDistance,
avg(LightActiveDistance) as LightActiveDistance,
avg(SedentaryActiveDistance) as SedentaryActiveDistance,
avg(VeryActiveMinutes) as VeryActiveMinutes,
avg(FairlyActiveMinutes) as FairlyActiveMinutes,
avg(LightlyActiveMinutes) as LightlyActiveMinutes,
avg(SedentaryMinutes) as SedentaryMinutes,
avg(Calories) as Calories
from Bellabeat.DailyActivity
group by id 
) as  Average

) as t2

group by UserActivityClass


-- The Most Active Weekday 
select WeekDay, avg(TotalSteps) as AvgSteps
from (
select * , DATENAME(WEEKDAY, ActivityDate) as WeekDay
from Bellabeat.DailyActivity) as t1
group by WeekDay
-- The Most Active Day our
select weekDay, avg(TotalMinutesAsleep) as AvgSleepMinute
from(
select * , DATENAME(WEEKDAY, SleepDay) as WeekDay
from Bellabeat.SleepDay
) as t2
group by WeekDay

-- The Most Day user sleep
select DayHour, avg(StepTotal) as AvgHourSteps
from(
select * ,  Format(activityhour, 'HH:mm:ss') as DayHour
from Bellabeat.hourlySteps) as t3
group by DayHour
order by AvgHourSteps desc


-- Calculate Daily Usage of smart devices
select id, count(distinct SleepDay)
from Bellabeat.SleepDay
group by id


-- Classify Users upon smart device usage from sleep data

select id, DeviceUsageTimes,

Case
when DeviceUsageTimes >0 and DeviceUsageTimes <11 then 'Low Use'
when DeviceUsageTimes >10 and DeviceUsageTimes <21 then 'Moderate Use'
when DeviceUsageTimes >21  then 'Hight Use'
END as Ctgs
from(select id, count(distinct SleepDay) as DeviceUsageTimes
from Bellabeat.SleepDay
group by id) as tt


-- total time user wear smart device during the day
select * , DATENAME(WEEKDAY, ActivityDate) as WeekDay,
(
VeryActiveMinutes+
FairlyActiveMinutes+
LightlyActiveMinutes+
SedentaryMinutes
) as TotalDeviceWeardTime
from Bellabeat.DailyActivity


-- avg user daily wear

select id, avg(TotalDeviceWeardTime) as AvgUserWaerSD
from(
select * , DATENAME(WEEKDAY, ActivityDate) as WeekDay,
(
VeryActiveMinutes+
FairlyActiveMinutes+
LightlyActiveMinutes+
SedentaryMinutes
) as TotalDeviceWeardTime
from Bellabeat.DailyActivity) as tt

group by id