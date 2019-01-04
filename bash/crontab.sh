# 在/var/log/cron 文件里先测试跑了没有，确认调用没有问题再开实际的 job
# % should be escaped with /
# */1 * * * * command 这样的格式可以每分钟跑一次，for test
0 2 * * * source /home/dlabuser/code/cronjobs/dss_daily.sh

