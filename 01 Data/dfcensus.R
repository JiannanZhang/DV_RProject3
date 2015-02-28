require("jsonlite")
require(dplyr)

q = 'CENSUS2010POP'
i = 'STNAME'
k = 'CTYNAME'
dfpop <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\' "i" \\\', \\\' "k" \\\', \\\' "q" \\\' from CENSUSCOUNTY"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_JCN565', PASS='orcl_jcn565', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', q=q, i=i, k=k), verbose = TRUE)))
