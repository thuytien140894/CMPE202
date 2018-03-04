#!/bin/bash

cmd="docker exec benchmark1 /bin/sh -c"

if [ $# = 0 ]; then 
    echo "Missing arguments"
    echo "-stat: run perf"
    echo "-plot-toplev: plot top-level runtime"
    echo "-plot-cpu: plot cpu metrics runtime"
else 
    docker stop benchmark1
    docker rm benchmark1
    docker run --privileged -dit --name benchmark1 throughput

    if [ $1 = "-stat" ]; then 
        if [ $2 = "5T" ]; then 
            # run 5T instructions for 1/2/4/8 threads
            $cmd "cp data/5T.test data/test"
        elif [ $2 = "1243B" ]; then 
            # run 1.243T instructions for 1/2/4/8 threads
            $cmd "cp data/1243B.test data/test"
        elif [ $2 = "310B" ]; then 
            # run 310B instructions for 1/2/4/8 threads
            $cmd "cp data/310B.test data/test"
        elif [ $2 = "75B" ]; then 
            # run 75B instructions for 1/2/4/8 threads
            $cmd "cp data/75B.test data/test"
        elif [ $2 = "18B" ]; then 
            # run 18B instructions for 1/2/4/8 threads
            $cmd "cp data/18B.test data/test"
        fi

        $cmd "perf stat -d ./run1.sh"
        $cmd "perf stat -d ./run2.sh"
        $cmd "perf stat -d ./run4.sh"
        $cmd "perf stat -d ./run8.sh"

    elif [ $1 = "-plot-toplev" ]; then
        if [ $2 = "5T" ]; then 
            # generate plot for 5T
            $cmd "cp data/5T.test data/test"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/5T-1.csv ./run1.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/5T-1.csv -o plot/5T-1.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/5T-2.csv ./run2.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/5T-2.csv -o plot/5T-2.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/5T-4.csv ./run4.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/5T-4.csv -o plot/5T-4.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/5T-8.csv ./run8.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/5T-8.csv -o plot/5T-8.png"
        elif [ $2 = "1243B" ]; then 
            # generate plot for 1.243T 
            $cmd "cp data/1243B.test data/test"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/1243B-1.csv ./run1.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/1243B-1.csv -o plot/1243B-1.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/1243B-2.csv ./run2.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/1243B-2.csv -o plot/1243B5T-2.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/1243B-4.csv ./run4.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/1243B-4.csv -o plot/1243B-4.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/1243B-8.csv ./run8.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/1243B-8.csv -o plot/1243B-8.png"
        elif [ $2 = "310B" ]; then 
            # generate plot for 310B 
            $cmd "cp data/310B.test data/test"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/310B-1.csv ./run1.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/310B-1.csv -o plot/310B-1.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/310B-2.csv ./run2.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/310B-2.csv -o plot/310B-2.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/310B-4.csv ./run4.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/310B-4.csv -o plot/310B-4.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/310B-8.csv ./run8.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/310B-8.csv -o plot/310B-8.png"
        elif [ $2 = "75B" ]; then 
            # generate plot for 75B 
            $cmd "cp data/75B.test data/test"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/75B-1.csv ./run1.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/75B-1.csv -o plot/75B-1.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/75B-2.csv ./run2.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/75B-2.csv -o plot/75B-2.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/75B-4.csv ./run4.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/75B-4.csv -o plot/75B-4.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/75B-8.csv ./run8.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/75B-8.csv -o plot/75B-8.png"
        elif [ $2 = "18B" ]; then 
            # generate plot for 18B 
            $cmd "cp data/18B.test data/test"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/18B-1.csv ./run1.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/18B-1.csv -o plot/18B-1.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/18B-2.csv ./run2.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/18B-2.csv -o plot/18B-2.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/18B-4.csv ./run4.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/18B-4.csv -o plot/18B-4.png"
            $cmd "../toplev.py -l3 -I 1000 -x, -o plot/18B-8.csv ./run8.sh"
            $cmd "../tl-barplot.py --cpu C0-T0 plot/18B-8.csv -o plot/18B-8.png"
        fi

        docker cp benchmark1:/pmu-tools/fastText-0.1.0/plot .

    elif [ $1 = "-plot-cpu" ]; then 
        if [ $2 = "5T" ]; then 
            # generate plot for 5T
            $cmd "cp data/5T.test data/test"
            $cmd "../toplev.py --graph --metrics --output plot/5T-1.png ./run1.sh" 
            $cmd "../toplev.py --graph --metrics --output plot/5T-2.png ./run2.sh"
            $cmd "../toplev.py --graph --metrics --output plot/5T-4.png ./run4.sh"
            $cmd "../toplev.py --graph --metrics --output plot/5T-8.png ./run8.sh"
        elif [ $2 = "1243B" ]; then 
            # generate plot for 1.243T 
            $cmd "cp data/1243B.test data/test"
            $cmd "../toplev.py --graph --metrics --output plot/1243-1.png ./run1.sh" 
            $cmd "../toplev.py --graph --metrics --output plot/1243-2.png ./run2.sh"
            $cmd "../toplev.py --graph --metrics --output plot/1243-4.png ./run4.sh"
            $cmd "../toplev.py --graph --metrics --output plot/1243-8.png ./run8.sh"
        elif [ $2 = "310B" ]; then 
            # generate plot for 310B 
            $cmd "cp data/310B.test data/test"
            $cmd "../toplev.py --graph --metrics --output plot/310B-1.png ./run1.sh" 
            $cmd "../toplev.py --graph --metrics --output plot/310B-2.png ./run2.sh"
            $cmd "../toplev.py --graph --metrics --output plot/310B-4.png ./run4.sh"
            $cmd "../toplev.py --graph --metrics --output plot/310B-8.png ./run8.sh"
        elif [ $2 = "75B" ]; then 
            # generate plot for 75B 
            $cmd "cp data/75B.test data/test"
            $cmd "../toplev.py --graph --metrics --output plot/75B-1.png ./run1.sh" 
            $cmd "../toplev.py --graph --metrics --output plot/75B-2.png ./run2.sh"
            $cmd "../toplev.py --graph --metrics --output plot/75B-4.png ./run4.sh"
            $cmd "../toplev.py --graph --metrics --output plot/75B-8.png ./run8.sh"
        elif [ $2 = "18B" ]; then 
            # generate plot for 18B 
            $cmd "cp data/18B.test data/test"
            $cmd "../toplev.py --graph --metrics --output plot/18B-1.png ./run1.sh" 
            $cmd "../toplev.py --graph --metrics --output plot/18B-2.png ./run2.sh"
            $cmd "../toplev.py --graph --metrics --output plot/18B-4.png ./run4.sh"
            $cmd "../toplev.py --graph --metrics --output plot/18B-8.png ./run8.sh"
        fi

        docker cp benchmark1:/pmu-tools/fastText-0.1.0/plot .
    fi
fi


