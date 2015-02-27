 df_06 %>% select(recipient_city_name,fed_funding_amount_06) %>% ggplot(aes(x=recipient_city_name, y=fed_funding_amount_06,color=recipient_city_name))  + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1))


df_06 %>% select(recipient_city_name,fed_funding_amount_06) %>% filter(recipient_city_name != "") %>% ggplot(aes(x=recipient_city_name, y=fed_funding_amount_06,color=recipient_city_name))  + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
df_07 %>% select(recipient_city_name,fed_funding_amount_07) %>% filter(recipient_city_name != "") %>% ggplot(aes(x=recipient_city_name, y=fed_funding_amount_07,color=recipient_city_name))  + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1))

US_gov_spending_07 <- read.csv("~/Desktop/US_gov_spending_07.csv")
df_07 <- US_gov_spending_07


df_06_city_spending <- df_06 %>% select(recipient_city_name,fed_funding_amount_06) %>% filter(recipient_city_name != "")
df_07_city_spending <- df_07 %>% select(recipient_city_name,fed_funding_amount_07) %>% filter(recipient_city_name != "")

df_06_city_total_fund <- df_06_city_spending %>% select(recipient_city_name) %>% group_by(recipient_city_name) %>% summarize(total_spending = sum(df_06$fed_funding_amount_06)) 

df_07_city_total_fund <- df_07_city_spending %>% select(recipient_city_name) %>% group_by(recipient_city_name) %>% summarize(total_spending = sum(df_07$fed_funding_amount_07)) 

join_by_city <- inner_join(df_06_city_total_fund,df_07_city_total_fund,by = "recipient_city_name")



