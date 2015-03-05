df_06_total_fund <- df_06_city_spending %>% select(FED_FUNDING_AMOUNT_06) %>% summarise(avg06 = mean(FED_FUNDING_AMOUNT_06))
df_07_total_fund <- df_07_city_spending %>% select(FED_FUNDING_AMOUNT_07) %>% summarise(avg07 = mean(FED_FUNDING_AMOUNT_07))
df_08_total_fund <- df_08 %>% select(FED_FUNDING_AMOUNT_08) %>% summarise(avg08 = mean(FED_FUNDING_AMOUNT_08))
df_09_total_fund <- df_09 %>% select(FED_FUNDING_AMOUNT_09) %>% summarise(avg09 = mean(FED_FUNDING_AMOUNT_09))

bind_cols(df_06_total_fund, df_07_total_fund) %>%bind_cols(df_08_total_fund, df_09_total_fund) %>% gather(,"Average") %>% ggplot(aes(x = key, y = Average, group = 1)) + geom_point() + geom_line() + labs(title="Average Federal Funding\n Over Four Years", y="Average Funding(Dollars)",x="Year") + theme(panel.background=element_rect(fill='white'));