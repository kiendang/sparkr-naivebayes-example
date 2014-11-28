NaiveBayes <- function(parsed.data, lambda=1) {
  jrdd <- SparkR:::getJRDD(parsed.data)
  byte.array.rdd <- jrdd$rdd()
  labeled.point.rdd <- J("RToScalaRDD", "labeledPoint", byte.array.rdd)
  model <- J("org.apache.spark.mllib.classification.NaiveBayes", "train", labeled.point.rdd, lambda)
  
  labels <- model$labels()
  pi <- model$pi()
  theta <- numeric()
  for(i in 1:length(model$theta())) {
    theta <- rbind(theta, .jevalArray(model$theta()[[i]]))
  }
  
  structure(list(labels=labels, pi=pi, theta=theta), class="naivebayes")
}

predict.naivebayes <- function(object, newdata) {
  if(is(newdata, "RDD")) {
    return(lapply(newdata, function(x){
      predict.naivebayes(object, x)
    }))
  }
  
  object$labels[which.max(object$pi + object$theta %*% newdata)]
}
