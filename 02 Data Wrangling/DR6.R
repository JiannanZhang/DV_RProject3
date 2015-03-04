join_by_city <- inner_join(df_06_city_total_fund,df_07_city_total_fund,by = "RECIPIENT_CITY_NAME")
names(join_by_city) <- c("City","Total_fed_fund_06","Total_fed_fund_07")