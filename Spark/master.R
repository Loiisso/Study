# set env -----------------------------------------------------------------

Sys.setenv(SPARK_HOME = "/Users/Loiso/Documents/PersonalProjects/PersonalStudy/Spark//spark-1.6.1/")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))
# load library ------------------------------------------------------------
library(SparkR)

sc <- sparkR.init()
sqlContext <- sparkRSQL.init(sc)
df <- createDataFrame(sqlContext, iris)
