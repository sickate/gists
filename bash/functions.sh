plog () {
  tmps=`date -d "${1} days ago" +%F`
  echo $tmps
  tail -f ~/hdfs/log/$tmps-$2.log
}
