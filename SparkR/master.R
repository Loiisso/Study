# set env -----------------------------------------------------------------

Sys.setenv(
  SPARK_HOME = "/Users/Loiso/Documents/PersonalProjects/PersonalStudy/Spark//spark-1.6.1/"
  )
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))
# load library ------------------------------------------------------------
library(SparkR)
library(ggplot2)
# sc <- sparkR.init()
# sqlContext <- sparkRSQL.init(sc)
# df <- createDataFrame(sqlContext, iris)
# 

# initiate context --------------------------------------------------------

sc <- sparkR.init()
sqlContext <- sparkRSQL.init(sc)


# read data ---------------------------------------------------------------
hDt_1 <- read.csv("rawData/2013-american-community-survey/pums/ss13husa.csv", nrow = 1000)
hDt_2 <- read.csv("rawData/2013-american-community-survey/pums/ss13husb.csv", nrow = 1000)

hDt <- rbind(hDt_1, hDt_2)
sp_hDt <- createDataFrame(sqlContext = sqlContext, data = hDt)



# work on subsetting stuff -----------------------------------------------------


ggDt <- collect(
  sp_hDt[sp_hDt$PUMA > 1000, c("PUMA")]
      )

head(selectExpr(sp_hDt, "(VALP * 10) as VALP_by_10"))
head(filter(select(sp_hDt, "VALP", "REGION"), condition = "VALP > 18000"))

collect(
  subset(
    sp_hDt, 
    sp_hDt$VALP > median(collect(sp_hDt, "PUMA")$PUMA, na.rm = TRUE), 
    c("PUMA", "VALP")
  )
)

collect(
  sp_hDt[sp_hDt$VALP > 1000, c("VALP", "REGION")]
)


# try aggregation ---------------------------------------------------------



