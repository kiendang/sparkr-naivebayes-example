This is an example of using Spark MLlib's Naive Bayes model in R which I used as a demo at Singapore's Spark user group's first meetup http://www.meetup.com/Spark-Singapore/events/218794905/

Slides: https://www.slideshare.net/secret/m5cB2jsLGOpeRa

Data source: https://archive.ics.uci.edu/ml/datasets/Spambase

# Notes
	
Currently access to MLlib in SparkR is still in development. Thus use this method to run MLlib in R until MLlib is officially integrated into SparkR.

# Setup

1. Download SparkR:

		$ git clone https://github.com/amplab-extras/SparkR-pkg.git

2. Add "org.apache.spark" % "spark-mllib_2.10" % "1.1.0", "org.scalanlp" % "breeze_2.10" % "0.10", "net.rforge" % "Rserve" % "0.6-8.1" to libraryDependencies in SparkR-pkg/pkg/src/build.sbt

3. Copy src/RToScalaRDD.scala in this repo to SparkR-pkg/pkg/src/src

4. Install SparkR:

		R
		devtools::install_local("path/to/SparkR-pkg/pkg")

# Run example:

	$ path/to/SparkR/sparkR
	$ source("./R/1_naivebayes.R")
	$ source("./R/2_spam_naivebayes.R")