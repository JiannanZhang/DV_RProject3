


myplot <- function(df, x) {
  names(df) <- c("x", "n")
  ggplot(df, aes(x=x, y=n)) + geom_point()
}

categoricals <- eval(parse(text=substring(getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from GOVSPENDING2006"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_jcn565', PASS='orcl_jcn565', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE), 1, 2^31-1)))

df_06 <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GOVSPENDING2006"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_jcn565',PASS='orcl_jcn565',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

l <- list()
for (i in names(df_06)) { 
  if (i %in% categoricals[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select "i", count(*) n from GOVSPENDING2006 group by "i" "'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_jcn565',PASS='orcl_jcn565',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- myplot(r,i)
    print(p) 
    l[[i]] <- p
  }
}

png("/Users/Jaclyn Nguyen/Documents/DataVisualization/DV_RProject3/00 Doc/categoricals.png", width = 25, height = 60, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(6, 12)))   

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

myplot1 <- function(df, x) {
  names(df) <- c("x")
  ggplot(df, aes(x=x)) + geom_histogram() +  theme(axis.text.x=element_text(angle=90, size=5, vjust=0.5))
}
t <- list()
for (i in names(df_06)) {   
  if (i %in% categoricals[[2]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select "i" from GOVSPENDING2006 where "i" is not null "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_jcn565',PASS='orcl_jcn565',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    j <- myplot1(r,i)
    print(j) 
    t[[i]] <- j
  }
}

png("/Users/Jaclyn Nguyen/Documents/DataVisualization/DV_RProject3/00 Doc/categoricals2.png", width = 25, height = 20, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 12)))   

print(t[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:3))
print(t[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 4:6))
print(t[[3]], vp = viewport(layout.pos.row = 1, layout.pos.col = 7:9))
print(t[[4]], vp = viewport(layout.pos.row = 1, layout.pos.col = 10:12))
print(t[[5]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:3))
print(t[[6]], vp = viewport(layout.pos.row = 2, layout.pos.col = 4:6))
print(t[[7]], vp = viewport(layout.pos.row = 2, layout.pos.col = 7:9))
print(t[[8]], vp = viewport(layout.pos.row = 2, layout.pos.col = 10:12))

dev.off()
