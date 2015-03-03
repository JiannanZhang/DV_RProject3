categoricals <- eval(parse(text=substring(getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from GOVSPENDING2006"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_jcn565', PASS='orcl_jcn565', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE), 1, 2^31-1)))
df_06 <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GOVSPENDING2006"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##c329e_jcn565',PASS='orcl_jcn565',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)));

myplot <- function(df, x) {
  names(df) <- c("x", "n")
  ggplot(df, aes(x=x, y=n)) + geom_point()
}


l <- list()
for (i in names(df_06)) { 
  if (i %in% categoricals[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\", count(*) n from GOVSPENDING2006 group by \\\""i"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##c329e_jcn565',PASS='orcl_jcn565',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- myplot(r,i)
    print(p) 
    l[[i]] <- p
  }
}

png("/Users/Jaclyn Nguyen/Documents/DataVisualization/DV_RProject3/00 Doc/categoricals.png", width = 25, height = 10, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 12)))   

print(l[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:4))
print(l[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 5:8))
print(l[[3]], vp = viewport(layout.pos.row = 1, layout.pos.col = 9:12))
print(l[[4]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:4))
print(l[[5]], vp = viewport(layout.pos.row = 2, layout.pos.col = 5:8))
print(l[[6]], vp = viewport(layout.pos.row = 2, layout.pos.col = 9:12))
print(l[[7]], vp = viewport(layout.pos.row = 3, layout.pos.col = 1:4))
print(l[[8]], vp = viewport(layout.pos.row = 3, layout.pos.col = 5:8))
print(l[[9]], vp = viewport(layout.pos.row = 3, layout.pos.col = 9:12))
print(l[[10]], vp = viewport(layout.pos.row = 4, layout.pos.col = 1:4))
print(l[[11]], vp = viewport(layout.pos.row = 4, layout.pos.col = 5:8))
print(l[[12]], vp = viewport(layout.pos.row = 4, layout.pos.col = 9:12))
print(l[[13]], vp = viewport(layout.pos.row = 5, layout.pos.col = 1:4))
print(l[[14]], vp = viewport(layout.pos.row = 5, layout.pos.col = 5:8))
print(l[[15]], vp = viewport(layout.pos.row = 5, layout.pos.col = 9:12))
print(l[[16]], vp = viewport(layout.pos.row = 6, layout.pos.col = 1:4))
print(l[[17]], vp = viewport(layout.pos.row = 6, layout.pos.col = 5:8))
print(l[[18]], vp = viewport(layout.pos.row = 6, layout.pos.col = 9:12))

dev.off()


