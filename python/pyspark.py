# configuration
# https://stackoverflow.com/questions/41886346/spark-2-1-0-session-config-settings-pyspark

# generate multiple columns from one
df.withColumn("_tmp", split($"columnToSplit", "\\.")).select(
        $"_tmp".getItem(0).as("col1"),
        $"_tmp".getItem(1).as("col2"),
        $"_tmp".getItem(2).as("col3")
        ).drop("_tmp")

sc = SparkSession.builder \
        .appName("Spark_CLOB_Split") \
        .config("hive.metastore.sasl.enabled", "true") \
        .enableHiveSupport() \
        .getOrCreate()

# 清空已有表的数据：试了SQL最常用的delete # from 和delete from都不管用，竟然支持的是"truncate table <表名>"这种次常用的语法
# 查询数据：用标准的sql语句即可，注意不支持having语法，另外表连接只支持等值连接
sc.sql("""
    select some columns, sum(any solumn) as col_name from your_table1 a
    left join your_table2 b
    on a.key = b.key
    where a.col_name > 0
    group by some columns
""")

# 插入表：假设有一个名为df的spark frame
df.registerTempTable("tmp")
spark.sql("insert into your_table select # from tmp")

# 新生成一列常量：需要使用lit函数
from pyspark.sql.functions import lit
df.withColumn('your_col_name' ,lit(your_const_var))

# 新生成一列：利用自定义函数对某一列进行运算，生成新的一列
from pyspark.sql.functions import udf,col
from pyspark.sql.types import StringType
def func(s):
    return s[:3]
my_func = udf(func, StringType())
df = df.withColumn('new_col_name', my_func('col_name'))

# 表之间Cross Join笛卡尔积问题：
sc.conf.set("spark.sql.crossJoin.enabled", True)

# 创建临时视图：
df.createOrReplaceTempView("view_name")

# 创建dataframe
data = [(0, 1)]
col_names = ['col1', 'col2']
spark.createDataFrame(, col_names)

# 聚合运算
df = df.groupby(['col_group']).agg({'col1':'sum', 'col2':'count'})

# 合并RDD
df = df.union(df_tmp)

# 对RDD重命名
df = df.withColumnRenamed(old_colname, new_colname)

# python的timestamp转为spark的date格式
df = df.withColumn('col', lit(col.date()))

# 表连接
cols = ['col1', 'col2']
df = df.join(df2, cols, how = 'left')
df.join(df2, df.name == df2.name, 'outer').select(df.name, df2.height)
df.join(df2, 'name', 'outer').select('name', 'height').collect()

# 列合并
df = df.withColumn('col', concat('col1', 'col2'))

# concat_ws can use separator, concat can't
df = claim_group_info.withColumn('col', concat_ws('-','col1', 'col2'))



##########################
# explode multiple columns
##########################

# only works in spark > 2.4
from pyspark.sql.functions import arrays_zip, col
(df
    .withColumn("tmp", arrays_zip("b", "c"))
    .withColumn("tmp", explode("tmp"))
    .select("a", col("tmp.b"), col("tmp.c"), "d"))


# works for spark <= 2.3
from pyspark.sql.types import ArrayType, StructType, StructField, IntegerType
from pyspark.sql.functions import col, udf, explode

zip_ = udf(
        lambda x, y: list(zip(x, y)),
        ArrayType(StructType([
            StructField("first", IntegerType()),
            StructField("second", IntegerType())
            ]))
        )

df = spark.read.parquet('/data/stage/log_daily/pbs/2019-07-29/20/win')
df.withColumn("tmp", zip_("b", "c"))
    .withColumn("tmp", explode("tmp"))
    .select("a", col("tmp.first").alias("b"), col("tmp.second").alias("c"), "d")



#####################################
# Query/Where/Filter/Groupby/Sort/Agg
#####################################

df.filter('a > 10 and b = "fuck"')




#####################################
# Plot with https://github.com/Bergvca/pyspark_dist_explore/
#####################################

import matplotlib.pyplot as plt
from pyspark_dist_explore import Histogram, hist, distplot, pandas_histogram

df = spark.read.parquet('/tmp/link/output/s_df')

# 单个图
fig, ax = plt.subplots()
hist(ax, df[[df.value]], bins = 20, color=['red'])
ax.set_title('Sinker nodes: distribution')
ax.legend()
fig.savefig('/tmp/test5.png')

# 多个图
# Create some selections on this data

filtered_by_gender_m = transactions_df.filter(F.col('gender') == 'M').select(F.col('amount').alias('amount_m'))
filtered_by_gender_f = transactions_df.filter(F.col('gender') == 'F').select(F.col('amount').alias('amount_f') )
filtered_by_age_50_plus = transactions_df.filter(F.col('age') > 50).select(F.col('amount').alias('amount_50_plus'))
filtered_by_age_50_minus = transactions_df.filter(F.col('age') <= 50).select(F.col('amount').alias('amount_50_minus'))

# Create the plots

fig, axes = plt.subplots(nrows=2, ncols=2)
fig.set_size_inches(20, 20)

# Use the hist function to plot histograms on the Axes
hist(axes[0, 0], [filtered_by_gender_m, filtered_by_gender_f], bins = 20, color=['red', 'tan'])
axes[0, 0].set_title('01. Compare Genders')
axes[0, 0].legend()

hist(axes[0, 1], [filtered_by_age_50_plus, filtered_by_age_50_minus], overlapping=True)
axes[0, 1].set_title('02. Compare Age')
axes[0, 1].legend()

# Use the distplot function to plot (scaled) histograms + density plots on the Axes
distplot(axes[1, 0], [filtered_by_gender_m, filtered_by_gender_f], bins=20)
axes[1, 0].set_title('03. Compare distribution per gender')
axes[1, 0].legend()

distplot(axes[1, 1], [filtered_by_age_50_plus, filtered_by_age_50_minus], bins=20, color=['orange', 'green'])
axes[1, 1].set_title('03. Compare distribution per age group')
_ = axes[1, 1].legend()


#####################################
# IO/Read/Save
#####################################

# save as text
df.rdd.map(lambda x: ",".join(map(str, x))).coalesce(1).saveAsTextFile("file.csv")

# If you need to handle strings with linebreaks or comma that will not work. Use this:
import csv
import cStringIO

def row2csv(row):
    buffer = cStringIO.StringIO()
    writer = csv.writer(buffer)
    writer.writerow([str(s).encode("utf-8") for s in row])
    buffer.seek(0)
    return buffer.read().strip()

df.rdd.map(row2csv).coalesce(1).saveAsTextFile("file.csv")

