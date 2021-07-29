plog () {
  tmps=`date -d "${1} days ago" +%F`
  echo $tmps
  tail -f ~/hdfs/log/$tmps-$2.log
}


# named arguments in function
foo() {
  while [[ "$#" -gt 0 ]]
  do
    case $1 in
      -f|--follow)
        local FOLLOW="following"
        ;;
      -t|--tail)
        local TAIL="tail=$2"
        ;;
    esac
    shift
  done

  echo "FOLLOW: $FOLLOW"
  echo "TAIL: $TAIL"
}

# Usage:
# foo --follow --tail 10
