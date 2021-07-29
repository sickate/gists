#!/bin/bash

# What exec cmd does, 
# is exactly the same as just running cmd, except that the current shell is replaced with the command, instead of a separate process being run. 
# Internally, running say /bin/ls will call fork() to create a child process, and then exec() in the child to execute /bin/ls. 
# exec /bin/ls on the other hand will not fork, but just replaces the shell.

# show current shell PID
echo $$

# if you run following cmd in ssh shell, it replaces the session and you are logged out
exec ls -l /proc/self

# eval will run the arguments as a command in the current shell. In other words eval foo bar is the same as just foo bar. But variables will be expanded before executing
# It will not create a child process, so the variable is set in the current shell.
# 
cmd="bar=foo"
eval "$cmd"
echo "$bar" # prints: foo

# 比如，下面命令会把 ssh agent 的 pid 设置在当前 shell，但不用 eval，就只能设在fork 出来的进程里，毫无luan用
eval $(ssh-agent)
# >> SSH_AUTH_SOCK=/tmp/ssh-Zk9o4RyaiRCC/agent.159994; export SSH_AUTH_SOCK;
# SSH_AGENT_PID=159995; export SSH_AGENT_PID;
# echo Agent pid 159995;
