# library(SparkR)

# sc <- sparkR.init("local", "spamNB")

ParseLine <- function(line) {
  features.and.label <- as.numeric(strsplit(line, " ")[[1]])
  label <- tail(features.and.label, 1)
  features <- features.and.label[-length(features.and.label)]
  list(label=label, features=features)
}

training <- textFile(sc, "./data/training")
testing <- textFile(sc, "./data/testing")

train.data <- lapply(training, ParseLine)
test.data <- lapply(testing, ParseLine)

model <- NaiveBayes(train.data, lambda = 1)

prediction.and.label <- lapply(test.data, function(x) {
  c(predict(model, x$features), x$label)
})

accuracy <- count(filterRDD(prediction.and.label, function(x) {
  x[1] == x[2]
})) / count(test.data)

cat("accuracy:", accuracy)
cat("\n")