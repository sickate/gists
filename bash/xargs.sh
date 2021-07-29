# tr 删除末尾的换行符，否则最后一个循环会有问题
# -d 指定切割 echo 出来的string
# -n max args 
# -P process 个数，控制并发
# -I {}：用 {} 指定传入参数在命令中的位置
echo {008..039} | tr -d '\n' | xargs -d ' ' -I {} -n1 -P8 sh -c 'echo {} {} lala'
