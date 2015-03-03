---
title: "Project 3"
author: "Jeffrey Zhang and Jaclyn Nguyen"
date: "Monday, February 16, 2015"
output: html_document
---

Project 3 required Jeffrey and I to import a large dataset into Oracle Server and call the data into RStudio for analysis. Below will describe the dataset and the following analysis. 

Dataset: GOVSPENDING2007, GOVSPENDING2007, GOVSPENDING2008, GOVSPENDING2009

Oracle SQL Developer: C##CS329E_JCN565

__1. Loading of R packages: RCurl, ggplot2, extrafont, jsonlite, dplyr, tidyr (R code not shown)__



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
##   (fctr), AGENCY_CODE (fctr), FED_FUNDING_AMOUNT_06 (int),
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

```r
tbl_df(df_07)
```

```
## Source: local data frame [3,024 x 23]
## 
##               UNIQUE_TRANSACTION_ID
## 1  f8a9b16565c78476dcec26d6253be6ad
## 2  4e6e97e327b53d719f64e8344ebbf10f
## 3  59fa389ac740124226c3142208924356
## 4  5eabe25ed17d9d74dd043c8ad2d4296e
## 5  76d4281f8fa283b732b60e7e6762d772
## 6  76df696a9674d281df66654b1db9808c
## 7  63973b7e392bc2063cdbcee33aab37ab
## 8  ec1962fc4d197e67517dfa4cdd0dcb82
## 9  091cdbc45a46864f8d3c977f9b5207a3
## 10 d91c5f680011c7be0b107cfe74ba71ff
## ..                              ...
## Variables not shown: ACCOUNT_TITLE (fctr), RECIPIENT_CITY_NAME (fctr),
##   RECIPIENT_COUNTY_NAME (fctr), RECIPIENT_ZIP (fctr), RECIPIENT_TYPE
##   (fctr), AGENCY_CODE (fctr), FED_FUNDING_AMOUNT_07 (int),
##   NON_FED_FUNDING_AMOUNT (int), TOTAL_FUNDING_AMOUNT (int),
##   OBLIGATION_ACTION_DATE (fctr), STARTING_DATE (fctr), ENDING_DATE (fctr),
##   PRINCIPAL_PLACE_STATE (fctr), PRINCIPAL_PLACE_CC (fctr),
##   PRINCIPAL_PLACE_ZIP (fctr), AGENCY_NAME (fctr), FACE_LOAN_GURAN (int),
##   ORIG_SUB_GURAN (int), RECIP_CAT_TYPE (fctr), MAJ_AGENCY_CAT (fctr),
##   RECIPIENT_COUNTRY_CODE (fctr), SERIALID (int)
```

```r
source("../01 data/dfcensus.R",echo = T)
```

```
## 
## > require("jsonlite")
## 
## > require(dplyr)
## 
## > q = "CENSUS2010POP"
## 
## > i = "STNAME"
## 
## > k = "UPPER(RECIPIENT_COUNTY_NAME)"
## 
## > dfpop <- data.frame(fromJSON(getURL(URLencode("129.152.144.84:5001/rest/native/?query=\"select  \"i\" ,  \"k\" ,  \"q\"  from CENSUSCOUNTY\""), 
## +   .... [TRUNCATED]
```

```r
tbl_df(dfpop)
```

```
## Source: local data frame [3,194 x 3]
## 
##      STNAME UPPER.RECIPIENT_COUNTY_NAME. CENSUS2010POP
## 1  Arkansas               JOHNSON COUNTY         25540
## 2  Arkansas             LAFAYETTE COUNTY          7645
## 3  Arkansas              LAWRENCE COUNTY         17415
## 4  Arkansas                   LEE COUNTY         10424
## 5  Arkansas               LINCOLN COUNTY         14134
## 6  Arkansas          LITTLE RIVER COUNTY         13171
## 7  Arkansas                 LOGAN COUNTY         22353
## 8  Arkansas                LONOKE COUNTY         68356
## 9  Arkansas               MADISON COUNTY         15717
## 10 Arkansas                MARION COUNTY         16653
## ..      ...                          ...           ...
```
__3. begin analysis__
First we want to know how many federal funds that each city has. A city could receive the federal funds many times a year and there are also some blank entries (no city names). I did these data wrangling in the following: 

First I plotted the original dataset for df_06

```r
df_06 %>% select(RECIPIENT_CITY_NAME,FED_FUNDING_AMOUNT_06) %>% ggplot(aes(x=RECIPIENT_CITY_NAME, y=FED_FUNDING_AMOUNT_06,color=RECIPIENT_CITY_NAME))  + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

I filtered the blank entries for both df_06 and df_07


```r
df_06_city_spending <- df_06 %>% select(RECIPIENT_CITY_NAME,FED_FUNDING_AMOUNT_06) %>% filter(RECIPIENT_CITY_NAME != "")
df_07_city_spending <- df_07 %>% select(RECIPIENT_CITY_NAME,FED_FUNDING_AMOUNT_07) %>% filter(RECIPIENT_CITY_NAME != "")
```

I sum the totol funds for each city for both df_06 and df_07

```r
df_06_city_total_fund <- df_06_city_spending %>% select(RECIPIENT_CITY_NAME) %>% group_by(RECIPIENT_CITY_NAME) %>% summarize(total_spending = sum(df_06_city_spending$FED_FUNDING_AMOUNT_06)) 
df_07_city_total_fund <- df_07_city_spending %>% select(RECIPIENT_CITY_NAME) %>% group_by(RECIPIENT_CITY_NAME) %>% summarize(total_spending = sum(df_07_city_spending$FED_FUNDING_AMOUNT_07)) 
```

First I used left_join to join df_07_city_total_fund with df_06_city_total_fund. I found that there are many unmatched records in df_06_city_total_fund. So at this point, I am only intertested in the 
range and quatiles of 2007 city funding without comparing to 2006 city funding. Therefore I made an boxplot for that. From the graph, we can see that there are too many outliers in df_07_city_total_fund. The range is pretty big and the distribution is extremely skewed to the right












