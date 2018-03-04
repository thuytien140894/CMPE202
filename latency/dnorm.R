data <- read.table("record.txt")
png(file = "dnorm-latency.png")
x <- data$V1
y <- dnorm(x, mean = mean(data$V1), sd = sd(data$V1))
plot(x,y,main="Latency Normal Distribution",xlab="Response time (microsecond)",ylab="Probability")
dev.off()
