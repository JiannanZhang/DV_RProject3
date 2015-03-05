names(dfpop) <- c('PRINCIPAL_PLACE_STATE','RECIPIENT_COUNTY_NAME','POPULATION')
df_state <- dfpop %>% select (PRINCIPAL_PLACE_STATE, POPULATION) %>% group_by(PRINCIPAL_PLACE_STATE) %>% summarise(sum(POPULATION))
df_state06 <- df_06 %>% select (PRINCIPAL_PLACE_STATE, FED_FUNDING_AMOUNT_06) %>% group_by(PRINCIPAL_PLACE_STATE) %>% summarise(sum(FED_FUNDING_AMOUNT_06))
df_state07 <- df_07 %>% select (PRINCIPAL_PLACE_STATE, FED_FUNDING_AMOUNT_07) %>% group_by(PRINCIPAL_PLACE_STATE) %>% summarise(sum(FED_FUNDING_AMOUNT_07))

dfsamestate <- inner_join(df_state06,df_state07,by = 'PRINCIPAL_PLACE_STATE')