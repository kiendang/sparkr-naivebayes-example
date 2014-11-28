train.ratio = 0.9

spam <- read.csv("./data/spambase.data", header=F)
data <- spam[, -c(55, 56, 57)]

set.seed(1)
train.index <- sample(1:dim(data)[1], as.integer(train.ratio * dim(data)[1]))

training <- data[train.index, ]
testing <- data[-train.index, ]

write.table(training, "./data/training", quote=F, row.names=F, col.names=F)
write.table(testing, "./data/testing", quote=F, row.names=F, col.names=F)
