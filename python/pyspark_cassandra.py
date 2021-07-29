spark = SparkSession.builder.appName("Cassandra Tag load").getOrCreate()
spark.sparkContext.setLogLevel('WARN')

sqlContext = SQLContext(spark)
sqlContext.setConf(
    "spark.cassandra.connection.host",
    "172.16.211.12,172.16.211.13,172.16.211.14,172.16.211.2,172.16.211.3,172.16.211.4",
)
sqlContext.setConf("spark.cassandra.auth.username", "cassandra")
sqlContext.setConf("spark.cassandra.auth.password", "cassandra")

# cassandra config to make partitions larger or smaller
sqlContext.setConf("spark.sql.broadcastTimeout", 36000)
sqlContext.setConf("spark.cassandra.input.split.size", 10000000)
sqlContext.setConf("spark.cassandra.input.page.row.size", 20000)
sqlContext.setConf("spark.cassandra.input.split.size_in_mb", 256)

# simple r/w
abnid = sqlContext.read.format("org.apache.spark.sql.cassandra").options(keyspace='graphy_production', table='abnid').load()
abnid.count()
abnid.write.parquet('/data/stage/abnormal_id_from_cassandra')

hymis_schema = StructType([
    StructField("id", StringType(), True),
    StructField("ip", StringType(), True),
    StructField("ua", StringType(), True)])


df = (
  sqlContext.read.format("org.apache.spark.sql.cassandra")
      .options(keyspace='graphy_production', table='relation')
      .load()
)

ipdf1 = ipdf1.withColumnRenamed('name', 'ip').withColumnRenamed('value', 'ivt_score')
# Append will only change the columns in parquet and leave other fields untouched.
(
    ipdf1.write.format("org.apache.spark.sql.cassandra")
              .mode("append")
              .options(table="ip", keyspace='graphy_production')
              .save()
)
