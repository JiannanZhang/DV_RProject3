require("jsonlite")
require(dplyr)


q = 'Good'
r <- getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from diamonds where \\\"cut\\\" = \\\'"q"\\\'"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',USER='DV_Diamonds',PASS='orcl',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q),verbose = TRUE)
df_06 <- getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GOVSPENDING2006"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_jcn565',PASS='orcl_jcn565',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)