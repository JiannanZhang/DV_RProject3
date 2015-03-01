---
title: "Project 3"
author: "Jeffrey Zhang and Jaclyn Nguyen"
date: "Monday, February 16, 2015"
output: html_document
---

Project 3 required Jeffrey and I to import a large dataset into Oracle Server and call the data into RStudio for analysis. Below will describe the dataset and the following analysis. 

Dataset: 

Oracle SQL Developer: C##CS329E_JCN565

__1. Loading of R packages: RCurl, ggplot2, dplyr, tidyr (R code not shown)__



__2. Import dataset from Oracle server__

```r
source("../01 data/df_06.R",echo = T)
```

```
## 
## > df_06 <- data.frame(fromJSON(getURL(URLencode("129.152.144.84:5001/rest/native/?query=\"select * from GOVSPENDING2006\""), 
## +     httpheader = c(DB  .... [TRUNCATED]
```

```r
tbl_df(df_06)
```

```
## Source: local data frame [161 x 26]
## 
##               UNIQUE_TRANSACTION_ID ACCOUNT_TITLE
## 1  e3de047550aec610222209d0a898fa48          null
## 2  78c176a32903954b17e3f493f0c628f0          null
## 3  b180b4bcbc24a427a21fb28c396024c9          null
## 4  cc3eca56946bb44ec487bbce36b3aab6          null
## 5  b72f3b6c16ff40e006ffa3db0d1f41ea          null
## 6  07f21250f6eca0a9de40b67d63c7280d          null
## 7  3fe0c277a4c6bcb5515589f43d0ea134          null
## 8  4b3c3f74d3e8f58ef775dcc9b4cc24f6          null
## 9  8741b74e9b6851920410b6d60beb262e          null
## 10 67ca0c352a2fed3d95d8247539e60979          null
## ..                              ...           ...
## Variables not shown: RECIPIENT_NAME (fctr), RECIPIENT_CITY_NAME (fctr),
##   RECIPIENT_COUNTY_NAME (fctr), RECIPIENT_ZIP (fctr), RECIPIENT_TYPE
##   (fctr), AGENCY_CODE (fctr), FED_FUNDING_AMOUNT (int),
##   NON_FED_FUNDING_AMOUNT (int), TOTAL_FUNDING_AMOUNT (int),
##   OBLIGATION_ACTION_DATE (fctr), STARTING_DATE (fctr), ENDING_DATE (fctr),
##   PRINCIPAL_PLACE_STATE (fctr), PRINCIPAL_PLACE_CC (fctr),
##   PRINCIPAL_PLACE_ZIP (fctr), AGENCY_NAME (fctr), RECEIP_ADDR1 (fctr),
##   RECEIP_ADDR2 (fctr), FACE_LOAN_GURAN (int), ORIG_SUB_GURAN (int),
##   RECIP_CAT_TYPE (fctr), MAJ_AGENCY_CAT (fctr), RECIPIENT_COUNTRY_CODE
##   (fctr), SERIALID (int)
```

```r
source("../01 data/df_07.R",echo = T)
```

```
## 
## > df_07 <- data.frame(fromJSON(getURL(URLencode("129.152.144.84:5001/rest/native/?query=\"select * from GOVSPENDING2007\""), 
## +     httpheader = c(DB  .... [TRUNCATED]
```
__3. begin analysis__
First we want to know how many federal funds that each city has. A city could receive the federal funds many times a year and there are also some blank entries (no city names). I did these data wrangling in the following: 

First I plotted the original dataset

```r
df_06 %>% select(RECIPIENT_CITY_NAME,FED_FUNDING_AMOUNT_06) %>% ggplot(aes(x=RECIPIENT_CITY_NAME, y=FED_FUNDING_AMOUNT_06,color=RECIPIENT_CITY_NAME))  + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

```
## Error in eval(expr, envir, enclos): object 'FED_FUNDING_AMOUNT_06' not found
```

I filtered the blank entries and plotted the graph


```r
df_06 %>% select(RECIPIENT_CITY_NAME,FED_FUNDING_AMOUNT_06) %>% filter(RECIPIENT_CITY_NAME != "") %>% ggplot(aes(x=RECIPIENT_CITY_NAME, y=FED_FUNDING_AMOUNT_06,color=RECIPIENT_CITY_NAME))  + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
```

```
## Error in eval(expr, envir, enclos): object 'FED_FUNDING_AMOUNT_06' not found
```

I sum the totol funds for each city for both df_06 and df_07

```r
df_06_city_total_fund <- df_06_city_spending %>% select(RECIPIENT_CITY_NAME) %>% group_by(RECIPIENT_CITY_NAME) %>% summarize(total_spending = sum(df_06$FED_FUNDING_AMOUNT_06)) 
```

```
## Error in eval(expr, envir, enclos): object 'df_06_city_spending' not found
```

```r
df_07_city_total_fund <- df_07_city_spending %>% select(RECIPIENT_CITY_NAME) %>% group_by(RECIPIENT_CITY_NAME) %>% summarize(total_spending = sum(df_07$fed_funding_amount_07)) 
```

```
## Error in eval(expr, envir, enclos): object 'df_07_city_spending' not found
```

Then I inner join two dataset above by city

```r
join_by_city <- inner_join(df_06_city_total_fund,df_07_city_total_fund,by = "RECIPIENT_CITY_NAME")
```

```
## Error in inner_join(df_06_city_total_fund, df_07_city_total_fund, by = "RECIPIENT_CITY_NAME"): object 'df_06_city_total_fund' not found
```

```r
names(join_by_city) <- c("City","Total_fed_fund_06","Total_fed_fund_07")
```

```
## Error in names(join_by_city) <- c("City", "Total_fed_fund_06", "Total_fed_fund_07"): object 'join_by_city' not found
```

Use bubble plot to visualize the gragh. First plot bubble plot: fed_fund_06 VS Cities
From the bubble graph, we can easily to see the difference of federal fund amount between these cities by the bubble size

```r
join_by_city %>% ggplot(aes(x=RECIPIENT_CITY_NAME, y=total_fed_fund_06, size = total_fed_fund_06,color=total_fed_fund_06)) + geom_point() + theme(axis.text.x=element_text(angle=80, size=20, vjust=0.5)) + theme(axis.text.x=element_text(size=10, face="bold", vjust=1)) + theme(axis.title.x=element_text(color="forestgreen", vjust=0.35),axis.title.y=element_text(color="cadetblue", vjust=0.35)) + labs(title="Fed_fund_06 VS Cities",y="Total_fund",x="City")
```

```
## Error in eval(expr, envir, enclos): object 'join_by_city' not found
```

Same for 2007

```r
join_by_city %>% ggplot(aes(x=RECIPIENT_CITY_NAME, y=Total_fed_fund_07, size = Total_fed_fund_07,color=Total_fed_fund_07)) + geom_point() + theme(axis.text.x=element_text(angle=80, size=20, vjust=0.5)) + theme(axis.text.x=element_text(size=10, face="bold", vjust=1)) + theme(axis.title.x=element_text(color="forestgreen", vjust=0.35),axis.title.y=element_text(color="cadetblue", vjust=0.35)) + labs(title="Fed_fund_07 VS Cities",y="Total_fund",x="City")
```

```
## Error in eval(expr, envir, enclos): object 'join_by_city' not found
```

continue this part...
