train.ratio = 0.9

spam <- read.csv("./data/spambase.data", header=FALSE)
data <- spam[, -c(55, 56, 57)]

set.seed(1)
train.index <- sample(1:dim(data)[1], as.integer(train.ratio * dim(data)[1]))

training <- data[train.index, ]
testing <- data[-train.index, ]

write.table(training, "./data/training", quote=FALSE, row.names=FALSE, col.names=FALSE)
write.table(testing, "./data/testing", quote=FALSE, row.names=FALSE, col.names=FALSE)
