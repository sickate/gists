#!/bin/sh

rsync -rtvzog -e "ssh" --chown=root:zzc --rsync-path="sudo rsync" conf.d patterns deploy@bach:/etc/logstash
