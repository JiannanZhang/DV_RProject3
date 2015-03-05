dffull <- full_join(df_state06,df_state07, by = 'PRINCIPAL_PLACE_STATE')
names(dffull) <- c('PRINCIPAL_PLACE_STATE','FED_FUNDING_AMOUNT_06','FED_FUNDING_AMOUNT_07')

dffull2 <- inner_join(dffull, df_state, by = 'PRINCIPAL_PLACE_STATE')
names(dffull2) <- c('PRINCIPAL_PLACE_STATE','FED_FUNDING_AMOUNT_06','FED_FUNDING_AMOUNT_07', 'POPULATION')
dffull3 <- dffull2 %>% mutate(perperson06 = FED_FUNDING_AMOUNT_06/POPULATION, perperson07 = FED_FUNDING_AMOUNT_07/POPULATION)