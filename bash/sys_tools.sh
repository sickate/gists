# 使用 strace命令，可以看程序执行时进行的操作和报错的情况：
# 例如有的时候 tmux 报错 can't create socket，一般是因为上次未正常退出，遗留了 /tmp/tmux-10xx
# 目录，用下面命令就可以发现（删除后即可正常启动 tmux）
strace -e trace=file tmux
