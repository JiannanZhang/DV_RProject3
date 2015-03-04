df_06_city_total_fund <- df_06_city_spending %>% select(RECIPIENT_CITY_NAME) %>% group_by(RECIPIENT_CITY_NAME) %>% summarize(total_spending = sum(df_06_city_spending$FED_FUNDING_AMOUNT_06))