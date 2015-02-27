---
title: "Project 3"
author: "Jeffrey Zhang and Jaclyn Nguyen"
date: "Monday, February 16, 2015"
output: html_document
---

Project 2 required Jeffrey and I to import a large dataset into Oracle Server and call the data into RStudio for analysis. Below will describe the dataset and the following analysis. 

Dataset: 

Oracle SQL Developer: C##CS329E_JCN565

__1. Loading of R packages: RCurl, ggplot2, dplyr, tidyr (R code not shown)__



__2. Import dataset from Oracle server__

```r
source("../01 data/df_06.R",echo = T)
```

```
## 
## > require("jsonlite")
```

```
## Loading required package: jsonlite
## 
## Attaching package: 'jsonlite'
## 
## The following object is masked from 'package:utils':
## 
##     View
```

```
## 
## > require(dplyr)
## 
## > df_06 <- data.frame(fromJSON(getURL(URLencode("129.152.144.84:5001/rest/native/?query=\"select * from GOVSPENDING2006\""), 
## +     httpheader = c(DB  .... [TRUNCATED]
```

```
## Error in parseJSON(txt): lexical error: invalid char in json text.
##           BANY COUNTY", "PRINCE GEORGE"S", "THURSTON COUNTY", "LUBBOCK
##                      (right here) ------^
```

```r
source("../01 data/df_07.R",echo = T)
```

```
## 
## > require("jsonlite")
## 
## > require(dplyr)
## 
## > df_07 <- data.frame(fromJSON(getURL(URLencode("129.152.144.84:5001/rest/native/?query=\"select * from GOVSPENDING2007\""), 
## +     httpheader = c(DB  .... [TRUNCATED]
```

```
## Error in parseJSON(txt): lexical error: invalid char in json text.
##           TMENT OF FINANCE", "CHILDREN"S HOSPITAL OF PENNSLYVANIA", "N
##                      (right here) ------^
```
__3. begin analysis__
First we want to know how many federal funds each city has. A city could receive the federal funds many times a year and there are also some blank entries (no city names). I did these data wrangling in the following 


```r
df_06 %>% select(recipient_city_name,fed_funding_amount_06) %>% ggplot(aes(x=recipient_city_name, y=fed_funding_amount_06,color=recipient_city_name))  + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

```
## Error in eval(expr, envir, enclos): object 'df_06' not found
```





