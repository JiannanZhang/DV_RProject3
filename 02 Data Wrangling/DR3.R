df_06_city_total_fund <- df_06_city_spending %>% select(RECIPIENT_CITY_NAME, FED_FUNDING_AMOUNT_06) %>% group_by(RECIPIENT_CITY_NAME) %>% summarise(total_spending = sum(FED_FUNDING_AMOUNT_06))
