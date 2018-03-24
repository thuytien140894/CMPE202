#!/bin/bash

##############################################################################################
# Architecture: Intel(R) Core(TM) i7-4700MQ CPU @ 2.40GHz (Haswell)
# OS: Ubuntu 16.04.4 LTS
# perf version 4.13.13
#
# Requirements:
# In order for perf to run correctly and measure the whole system, the 
# two flags "kernel.perf_event_paranoid" and "kernel.nmi_watchdog" need to be set 
# as follows:
#
# To allow perf full access for non root, run this command:
#
#       echo "kernel.perf_event_paranoid=-1" >> /etc/sysctl.conf
#
# To disable the NMI watchdog, run this command:
#
#       echo "kernel.nmi_watchdog=0" >> /etc/sysctl.conf
#
# Usage:
# To make this script executable, type:
#
#       chmod 777 run.sh
#
# For help with using this run.sh script, type:
#
#       ./run.sh help
# 
# For instance, to run the summary throughput benchmark (instructions, branch misses, 
# L1 load misses, LLC load misses) for 1/2/4/8 threads, run:
#       ./run.sh -throughput -stat X
# where X is the number of instructions to benchmark (5T/1243B/310B/75B/20B).
# 
# To run the interval throughput benchmark (instructions, branch misses, L1 load misses, 
# LLC load misses) for 1/2/4/8 threads, run:
# 
#       ./run.sh -throughput -interval X
#
# where X is the number of instructions to benchmark (5T/1243B/310B/75B/20B).
#
# To run the latency benchmark, run:
#
#       ./run.sh -latency 
#
# Both latency and throughput benchmarks are included in this script. Type "help" 
# for more info on how to run them. 
#
# After running the latency benchmark, the plot named "dnorm-latency.png" will be outputed 
# in the current directory.
#
# Note:
# The script will stop and remove any container named "benchmark1" and "benchmark2" before 
# creating a new one with the same name. If no such container exists, there will be error 
# responses from docker. They can be ignored.
##############################################################################################

throughput="docker exec benchmark1 /bin/sh -c"
latency="docker exec benchmark2 /bin/sh -c"

if [ $# = 0 ]; then 
    echo "Missing arguments"
    echo "help: for help"
    echo "-throughput: run throughput benchmarks"
    echo "      -stat: run perf summary"
    echo "      -interval: run perf interval"
    echo "              5T: 5 trillion instructions"
    echo "              1243B: 1.243 trillion instructions"
    echo "              310B: 310 billion instructions"
    echo "              75B: 75 billion instructions"
    echo "              20B: 20 billion instructions"
    echo "-latency: run latency benchmarks"
elif [ $1 = "help" ]; then 
    echo "-throughput: run throughput benchmarks"
    echo "      -stat: run perf summary"
    echo "      -interval: run perf interval"
    echo "              5T: 5 trillion instructions"
    echo "              1243B: 1.243 trillion instructions"
    echo "              310B: 310 billion instructions"
    echo "              75B: 75 billion instructions"
    echo "              20B: 20 billion instructions"
    echo "-latency: run latency benchmarks"
elif [ $1 = "-throughput" ]; then 
    docker stop benchmark1
    docker rm benchmark1
    docker run --privileged -dit --name benchmark1 throughput

    if [ $2 = "-interval" ]; then 
        if [ $3 = "5T" ]; then 
            # run 5T instructions for 1/2/4/8 threads
            $throughput "cp data/5T.test data/test"
            $throughput "echo RUNNING 5T INSTRUCTIONS ON 1 THREAD, INTERVAL: 10s"
            $throughput "perf stat -d -I 10000 ./run1.sh"
            $throughput "echo RUNNING 5T INSTRUCTIONS ON 2 THREADS, INTERVAL: 10s"
            $throughput "perf stat -d -I 10000 ./run2.sh"
            $throughput "echo RUNNING 5T INSTRUCTIONS ON 4 THREADS, INTERVAL: 5s"
            $throughput "perf stat -d -I 5000 ./run4.sh"
            $throughput "echo RUNNING 5T INSTRUCTIONS ON 8 THREADS, INTERVAL: 5s"
            $throughput "perf stat -d -I 5000 ./run8.sh"
        elif [ $3 = "1243B" ]; then 
            # run 1.243T instructions for 1/2/4/8 threads
            $throughput "cp data/1243B.test data/test"
            $throughput "echo RUNNING 1.243T INSTRUCTIONS ON 1 THREAD, INTERVAL: 5s"
            $throughput "perf stat -d -I 5000 ./run1.sh"
            $throughput "echo RUNNING 1.243T INSTRUCTIONS ON 2 THREADS, INTERVAL: 5s"
            $throughput "perf stat -d -I 5000 ./run2.sh"
            $throughput "echo RUNNING 1.243T INSTRUCTIONS ON 4 THREADS, INTERVAL: 3s"
            $throughput "perf stat -d -I 3000 ./run4.sh"
            $throughput "echo RUNNING 1.243T INSTRUCTIONS ON 8 THREADS, INTERVAL: 1s"
            $throughput "perf stat -d -I 1000 ./run8.sh"
        elif [ $3 = "310B" ]; then 
            # run 310B instructions for 1/2/4/8 threads
            $throughput "cp data/310B.test data/test"
            $throughput "echo RUNNING 310B INSTRUCTIONS ON 1 THREAD, INTERVAL: 1s"
            $throughput "perf stat -d -I 1000 ./run1.sh"
            $throughput "echo RUNNING 310B INSTRUCTIONS ON 2 THREADS, INTERVAL: 1s"
            $throughput "perf stat -d -I 1000 ./run2.sh"
            $throughput "echo RUNNING 310B INSTRUCTIONS ON 4 THREADS, INTERVAL: 0.5s"
            $throughput "perf stat -d -I 500 ./run4.sh"
            $throughput "echo RUNNING 310B INSTRUCTIONS ON 8 THREADS, INTERVAL: 0.5s"
            $throughput "perf stat -d -I 500 ./run8.sh"
        elif [ $3 = "75B" ]; then 
            # run 75B instructions for 1/2/4/8 threads
            $throughput "cp data/75B.test data/test"
            $throughput "echo RUNNING 75B INSTRUCTIONS ON 1 THREAD, INTERVAL: 1s"
            $throughput "perf stat -d -I 1000 ./run1.sh"
            $throughput "echo RUNNING 75B INSTRUCTIONS ON 2 THREADS, INTERVAL: 1s"
            $throughput "perf stat -d -I 1000 ./run2.sh"
            $throughput "echo RUNNING 75B INSTRUCTIONS ON 4 THREADS, INTERVAL: 0.5s"
            $throughput "perf stat -d -I 500 ./run4.sh"
            $throughput "echo RUNNING 75B INSTRUCTIONS ON 8 THREADS, INTERVAL: 0.5s"
            $throughput "perf stat -d -I 500 ./run8.sh"
        elif [ $3 = "20B" ]; then 
            # run 20B instructions for 1/2/4/8 threads
            $throughput "cp data/18B.test data/test"
            $throughput "echo RUNNING 20B INSTRUCTIONS ON 1 THREAD, INTERVAL: 0.4s"
            $throughput "perf stat -d -I 400 ./run1.sh"
            $throughput "echo RUNNING 20B INSTRUCTIONS ON 2 THREADS, INTERVAL: 0.4s"
            $throughput "perf stat -d -I 400 ./run2.sh"
            $throughput "echo RUNNING 20B INSTRUCTIONS ON 4 THREADS, INTERVAL: 0.3s"
            $throughput "perf stat -d -I 300 ./run4.sh"
            $throughput "echo RUNNING 20B INSTRUCTIONS ON 8 THREADS, INTERVAL: 0.3s"
            $throughput "perf stat -d -I 300 ./run8.sh"
        else 
            echo "Invalid arguments"
        fi

    elif [ $2 = "-stat" ]; then 
        if [ $3 = "5T" ]; then 
            # run 5T instructions for 1/2/4/8 threads
            $throughput "cp data/5T.test data/test"
            $throughput "echo RUNNING 5T INSTRUCTIONS ON 1 THREAD"
            $throughput "perf stat -d ./run1.sh"
            $throughput "echo RUNNING 5T INSTRUCTIONS ON 2 THREADS"
            $throughput "perf stat -d ./run2.sh"
            $throughput "echo RUNNING 5T INSTRUCTIONS ON 4 THREADS"
            $throughput "perf stat -d ./run4.sh"
            $throughput "echo RUNNING 5T INSTRUCTIONS ON 8 THREADS"
            $throughput "perf stat -d ./run8.sh"
        elif [ $3 = "1243B" ]; then 
            # run 1.243T instructions for 1/2/4/8 threads
            $throughput "cp data/1243B.test data/test"
            $throughput "echo RUNNING 1.243T INSTRUCTIONS ON 1 THREAD"
            $throughput "perf stat -d ./run1.sh"
            $throughput "echo RUNNING 1.243T INSTRUCTIONS ON 2 THREADS"
            $throughput "perf stat -d ./run2.sh"
            $throughput "echo RUNNING 1.243T INSTRUCTIONS ON 4 THREADS"
            $throughput "perf stat -d ./run4.sh"
            $throughput "echo RUNNING 1.243T INSTRUCTIONS ON 8 THREADS"
            $throughput "perf stat -d ./run8.sh"
        elif [ $3 = "310B" ]; then 
            # run 310B instructions for 1/2/4/8 threads
            $throughput "cp data/310B.test data/test"
            $throughput "echo RUNNING 310B INSTRUCTIONS ON 1 THREAD"
            $throughput "perf stat -d ./run1.sh"
            $throughput "echo RUNNING 310B INSTRUCTIONS ON 2 THREADS"
            $throughput "perf stat -d ./run2.sh"
            $throughput "echo RUNNING 310B INSTRUCTIONS ON 4 THREADS"
            $throughput "perf stat -d ./run4.sh"
            $throughput "echo RUNNING 310B INSTRUCTIONS ON 8 THREADS"
            $throughput "perf stat -d ./run8.sh"
        elif [ $3 = "75B" ]; then 
            # run 75B instructions for 1/2/4/8 threads
            $throughput "cp data/75B.test data/test"
            $throughput "echo RUNNING 75B INSTRUCTIONS ON 1 THREAD"
            $throughput "perf stat -d ./run1.sh"
            $throughput "echo RUNNING 75B INSTRUCTIONS ON 2 THREADS"
            $throughput "perf stat -d ./run2.sh"
            $throughput "echo RUNNING 75B INSTRUCTIONS ON 4 THREADS"
            $throughput "perf stat -d ./run4.sh"
            $throughput "echo RUNNING 75B INSTRUCTIONS ON 8 THREADS"
            $throughput "perf stat -d ./run8.sh"
        elif [ $3 = "20B" ]; then 
            # run 20B instructions for 1/2/4/8 threads
            $throughput "cp data/18B.test data/test"
            $throughput "echo RUNNING 20B INSTRUCTIONS ON 1 THREAD"
            $throughput "perf stat -d ./run1.sh"
            $throughput "echo RUNNING 20B INSTRUCTIONS ON 2 THREADS"
            $throughput "perf stat -d ./run2.sh"
            $throughput "echo RUNNING 20B INSTRUCTIONS ON 4 THREADS"
            $throughput "perf stat -d ./run4.sh"
            $throughput "echo RUNNING 20B INSTRUCTIONS ON 8 THREADS"
            $throughput "perf stat -d ./run8.sh"
        else 
            echo "Invalid arguments"
        fi

    elif [ $2 = "-plot-toplev" ]; then
        if [ $3 = "5T" ]; then 
            # generate plot for 5T
            $throughput "cp data/5T.test data/test"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 5Tplot/5T-1.csv ./run1.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 5Tplot/5T-1.csv -o 5Tplot/5T-1.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 5Tplot/5T-2.csv ./run2.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 5Tplot/5T-2.csv -o 5Tplot/5T-2.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 5Tplot/5T-4.csv ./run4.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 5Tplot/5T-4.csv -o 5Tplot/5T-4.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 5Tplot/5T-8.csv ./run8.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 5Tplot/5T-8.csv -o 5Tplot/5T-8.png"

            docker cp benchmark1:/pmu-tools/fastText-0.1.0/5Tplot .
        elif [ $3 = "1243B" ]; then 
            # generate plot for 1.243T 
            $throughput "cp data/1243B.test data/test"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 1243Bplot/1243B-1.csv ./run1.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 1243Bplot/1243B-1.csv -o 1243Bplot/1243B-1.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 1243Bplot/1243B-2.csv ./run2.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 1243Bplot/1243B-2.csv -o 1243Bplot/1243B5T-2.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 1243Bplot/1243B-4.csv ./run4.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 1243Bplot/1243B-4.csv -o 1243Bplot/1243B-4.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 1243Bplot/1243B-8.csv ./run8.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 1243Bplot/1243B-8.csv -o 1243Bplot/1243B-8.png"

            docker cp benchmark1:/pmu-tools/fastText-0.1.0/1243Bplot .
        elif [ $3 = "310B" ]; then 
            # generate plot for 310B 
            $throughput "cp data/310B.test data/test"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 310Bplot/310B-1.csv ./run1.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 310Bplot/310B-1.csv -o 310Bplot/310B-1.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 310Bplot/310B-2.csv ./run2.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 310Bplot/310B-2.csv -o 310Bplot/310B-2.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 310Bplot/310B-4.csv ./run4.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 310Bplot/310B-4.csv -o 310Bplot/310B-4.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 310Bplot/310B-8.csv ./run8.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 310Bplot/310B-8.csv -o 310Bplot/310B-8.png"

            docker cp benchmark1:/pmu-tools/fastText-0.1.0/310Bplot .
        elif [ $3 = "75B" ]; then 
            # generate plot for 75B 
            $throughput "cp data/75B.test data/test"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 75Bplot/75B-1.csv ./run1.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 75Bplot/75B-1.csv -o 75Bplot/75B-1.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 75Bplot/75B-2.csv ./run2.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 75Bplot/75B-2.csv -o 75Bplot/75B-2.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 75Bplot/75B-4.csv ./run4.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 75Bplot/75B-4.csv -o 75Bplot/75B-4.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 75Bplot/75B-8.csv ./run8.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 75Bplot/75B-8.csv -o 75Bplot/75B-8.png"

            docker cp benchmark1:/pmu-tools/fastText-0.1.0/75Bplot .
        elif [ $3 = "20B" ]; then 
            # generate plot for 20B 
            $throughput "cp data/18B.test data/test"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 20Bplot/20B-1.csv ./run1.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 20Bplot/20B-1.csv -o 20Bplot/20B-1.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 20Bplot/20B-2.csv ./run2.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 20Bplot/20B-2.csv -o 20Bplot/20B-2.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 20Bplot/20B-4.csv ./run4.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 20Bplot/20B-4.csv -o 20Bplot/20B-4.png"
            $throughput "../toplev.py -l3 -I 1000 -x, -o 20Bplot/20B-8.csv ./run8.sh"
            $throughput "../tl-barplot.py --cpu C0-T0 20Bplot/20B-8.csv -o 20Bplot/20B-8.png"

            docker cp benchmark1:/pmu-tools/fastText-0.1.0/20Bplot .
        else 
            echo "Invalid arguments"
        fi
    else 
        echo "Invalid arguments"
    fi

elif [ $1 = "-latency" ]; then 
    docker stop benchmark2
    docker rm benchmark2
    docker run -dit --privileged --name benchmark2 latency  

    $latency "cd latency/ && ./latency"
    $latency "cd latency/ && Rscript dnorm.R"

    docker cp benchmark2:/fastText-0.1.0/latency/dnorm-latency.png .
else 
    echo "Invalid arguments"
fi
