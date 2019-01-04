# run following command under the path you want to benchmark

TEST_DIR=$1

printf "[FIO] random read/write test..."
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=rwtest --filename=$TEST_DIR/test --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75

printf "\n\n"
printf "[FIO] random read test..."
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=readtest --filename=$TEST_DIR/test --bs=4k --iodepth=64 --size=4G --readwrite=randread

printf "\n\n"
printf "[FIO] random write test..."
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=writetest --filename=$TEST_DIR/test --bs=4k --iodepth=64 --size=4G --readwrite=randwrite

printf "\n\n"
printf "[IOPING] Latencty test..."
sudo ioping -c 20 $TEST_DIR

printf "\n\n"
printf "[IOPING] Seeking speed test..."
sudo ioping -R $TEST_DIR

printf "\n\n"
printf "[IOPING] Sequential throughput test..."
sudo ioping -RL $TEST_DIR
