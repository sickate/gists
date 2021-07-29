# 如果最后的路径表示文件夹，那么需要跟选项-R，表示对文件夹中的所有文件都修改副本
hadoop fs -setrep -R 2 /user   设置/user下所有文件（不是文件夹）的副本数量为2

# 还有一个选项是-w，表示等待副本操作结束才退出命令
hadoop fs -setrep -R -w 1 /user/hehe.txt
