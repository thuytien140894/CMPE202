#!/bin/bash

##############################################################################################
# Architecture: Intel(R) Core(TM) i7-4700MQ CPU @ 2.40GHz (Haswell)
# OS: Ubuntu 16.04.4 LTS
#
# Requirements:
# Make sure that git and docker are installed.
#
# Usage:
# To make this script executable, type:
#       chmod 777 setup.sh
##############################################################################################

rm -r -f CMPE202/
git clone https://github.com/thuytien140894/CMPE202.git

cd CMPE202/throughput
docker build . -t throughput

cd ./../latency
docker build . -t latency

cd ..
