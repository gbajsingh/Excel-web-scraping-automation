# Introduction
Employee attrition is basically a employee turnover rate of an organization. Attrition can be caused by both voluntary(for e.g. retirement, self-quit) or involuntary (for e.g. layoff) reason. Nonethless, identifying factors that leads to attrition can help an organization to take prevention measures. For example, a company would rather keep its high performance employees than to train and hire new ones.

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

Count of employess with attrition is directly proportional to employees without attrition. Also, most of the data is consist of employees that ages between 20 to 50 years old which means most of the attrition is not caused by retirement.


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

Average distance from home for attrition is slightly higher.

__By income__

```r
# visualization by daily rate
ggplot(HR_data, aes(x=DailyRate, fill = Attrition, color = Attrition)) + geom_histogram(binwidth=100,alpha=0.5)

ggplot(HR_data, aes(x=Attrition, y=DailyRate, fill=Attrition)) + 
  geom_boxplot()+ stat_summary(fun.y=mean, geom="point", shape=23, size=4) +
  stat_summary(fun.y=mean, colour="darkred", geom="text", vjust=-0.9, aes( label=round(..y.., digits=1))) +
  stat_summary(fun.y=median, colour="darkred", geom="text", vjust=1.2, aes( label=round(..y.., digits=1)))
```
![attrition by dailyrate](https://user-images.githubusercontent.com/46609482/68811423-77b30900-0625-11ea-8fc1-dca9078bd18b.PNG)![Attrition by dailyrate boxplot](https://user-images.githubusercontent.com/46609482/68811233-04a99280-0625-11ea-9d59-a956099ef839.PNG)


