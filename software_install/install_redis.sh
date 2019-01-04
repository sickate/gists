#!/bin/bash

# install
sudo yum install epel-release
sudo yum install redis -y
sudo systemctl start redis.service
sudo systemctl enable redis
sudo systemctl status redis.service

# TODO
# secure it
