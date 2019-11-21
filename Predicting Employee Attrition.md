# Introduction
Employee attrition is basically a employee turnover rate of an organization. Attrition can be caused by both voluntary(for e.g. retirement, self-quit) or involuntary (for e.g. layoff) reason. Nonethless, identifying factors that leads to attrition can help an organization to take preventive measures. For example, a company would rather keep its high performance employees than to train and hire new ones.

Age seems like a reasonable factor for the retirement related attrition. Other variables such as income, commute and job satisfaction could play a significant role for employees when deciding to saty with the organization.

# Objective
1. Explore data to see what variables could be significant in predicting attrition.
2. Implement statistical models to accurately predict the attrition.

# Statistical tools
R with required libraries
```r
library(ggplot2)
```

# Data
```r
# Read data
HR_data = read.csv("WA_Fn-UseC_-HR-Employee-Attrition.csv")
```
*__Reference__* : client's data

```r
# structure of data
str(HR_data)
```
![attrition str](https://user-images.githubusercontent.com/46609482/68713139-09514680-0552-11ea-8e6d-f1535c00eee9.PNG)

*__Explanation of some variables__*:

__Attrition__(label/the variable to predict) : "yes" if an employee has left the organization otherwise "no"
               
__Education__: 1 'Below College' 2 'College' 3 'Bachelor' 4 'Master' 5 'Doctor'

__EnvironmentSatisfaction__: 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

__JobInvolvement__: 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

__JobSatisfaction__: 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

__PerformanceRating__: 1 'Low' 2 'Good' 3 'Excellent' 4 'Outstanding'

__RelationshipSatisfaction__: 1 'Low' 2 'Medium' 3 'High' 4 'Very High'

__WorkLifeBalance__: 1 'Bad' 2 'Good' 3 'Better' 4 'Best'

```r
# Summary of data
summary(HR_data)
```
![atrrition summary](https://user-images.githubusercontent.com/46609482/68715070-05bfbe80-0556-11ea-91ca-7a0ee1668071.PNG)
![attrition summary2](https://user-images.githubusercontent.com/46609482/68715093-0f492680-0556-11ea-8717-ccdd0ea4c52c.PNG)

# Distribution of Attrition among variables

__By Age__
```r
# visualization
ggplot(HR_data, aes(x=Age, fill = Attrition, color = Attrition)) + geom_histogram(binwidth=10, alpha=0.5)
```
![attrition by age](https://user-images.githubusercontent.com/46609482/68807690-1f780900-061d-11ea-8486-2c62e08826f4.PNG)

Distribution of employess with attrition across age seems proportional to the distribution of employees without attrition. Also, most of the data is consist of employees that ages between 20 to 50 years old which means most of the attrition is not caused by retirement.


__By distance from home__
```r
# visualization
ggplot(HR_data, aes(x=Attrition, y=DistanceFromHome, fill=Attrition)) + 
  geom_boxplot()+ stat_summary(fun.y=mean, geom="point", shape=23, size=4) +
    stat_summary(fun.y=mean, colour="darkred", geom="text", vjust=-0.9, aes( label=round(..y.., digits=1))) +
      stat_summary(fun.y=median, colour="darkred", geom="text", vjust=1.2, aes( label=round(..y.., digits=1))) +
        ggtitle("   Boxplot of 'Distance From Home' by Attrition")
```
![attrition distance boxplot](https://user-images.githubusercontent.com/46609482/68715329-9a2a2100-0556-11ea-92de-3b4544a7eec7.PNG)Diamond = *Mean*; Line = *Median*

Average distance from home for employees with attrition is slightly higher. This could be a factor for employess when deciding to stay with organization.

__By income__

```r
# visualization by daily rate
ggplot(HR_data, aes(x=DailyRate, fill = Attrition, color = Attrition)) + geom_histogram(binwidth=100,alpha=0.5)

ggplot(HR_data, aes(x=Attrition, y=DailyRate, fill=Attrition)) + 
  geom_boxplot()+ stat_summary(fun.y=mean, geom="point", shape=23, size=4) +
  stat_summary(fun.y=mean, colour="darkred", geom="text", vjust=-0.9, aes( label=round(..y.., digits=1))) +
  stat_summary(fun.y=median, colour="darkred", geom="text", vjust=1.2, aes( label=round(..y.., digits=1)))
```
![attrition by dailyrate](https://user-images.githubusercontent.com/46609482/68811423-77b30900-0625-11ea-8fc1-dca9078bd18b.PNG)      ![attrition by dailyrate boxplot](https://user-images.githubusercontent.com/46609482/68811618-ee500680-0625-11ea-8004-f73e331cc4fa.PNG)

1. The left chart shows the distribution of employees with attrition among daily rate is slightly skewed to the left meaning the count of employees with attrition is higher towards lower daily rate. 
2. The right chart confirms the average daily rate of employees with attrition is indeed slightly lower than employees without attrition.

```r
# visualization by hourly rate
ggplot(HR_data, aes(x=HourlyRate, fill = Attrition, color = Attrition)) + geom_histogram(binwidth=10,alpha=0.5)

ggplot(HR_data, aes(x=Attrition, y=HourlyRate, fill=Attrition)) + 
  geom_boxplot()+ stat_summary(fun.y=mean, geom="point", shape=23, size=4) +
  stat_summary(fun.y=mean, colour="darkred", geom="text", vjust=-0.9, aes( label=round(..y.., digits=1))) +
  stat_summary(fun.y=median, colour="darkred", geom="text", vjust=1.2, aes( label=round(..y.., digits=1)))
```
![attrition hourly rate](https://user-images.githubusercontent.com/46609482/69196151-82b4e000-0ae2-11ea-8ce9-53c71494f284.PNG)![attrition hourly rate boxplot](https://user-images.githubusercontent.com/46609482/69196228-b42dab80-0ae2-11ea-8e38-9e77afb96bd0.PNG)

1. The left charts shows the distribution of employees with attrition among hourly rate is proportional to the distribution of employee without attrition.
2. The right chart confirms the average hourly rate of employees with attrition is indeed approximately same as the employees without attrition.

```r
# visualization by Monthly Income
ggplot(HR_data, aes(x=MonthlyIncome, fill = Attrition, color = Attrition)) + geom_histogram(binwidth=1000,alpha=0.5)

ggplot(HR_data, aes(x=Attrition, y=MonthlyIncome, fill=Attrition)) + 
  geom_boxplot()+ stat_summary(fun.y=mean, geom="point", shape=23, size=4) +
  stat_summary(fun.y=mean, colour="darkred", geom="text", vjust=-0.9, aes( label=round(..y.., digits=1))) +
  stat_summary(fun.y=median, colour="darkred", geom="text", vjust=1.2, aes( label=round(..y.., digits=1)))
```
![attrition by monthlyIncome](https://user-images.githubusercontent.com/46609482/69382523-1cf45f80-0c6c-11ea-9d8e-276fb79d2a5b.PNG)

1. The left chart shows the distribution of employees with attrition is skewed to right more than the distribution of employees without attrition. Meaning higher the income less the attrition occurs.
2. The right chart confirms the average monthly income of employees with attrition is indeed lower than the employees without attrition.
