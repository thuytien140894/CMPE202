#!/bin/bash

cmd="docker exec benchmark2 /bin/sh -c"

docker stop benchmark2
docker rm benchmark2
docker run -dit --privileged --name benchmark2 latency

$cmd "cd latency/ && ./latency"
$cmd "cd latency/ && Rscript dnorm.R"

docker cp benchmark2:/fastText-0.1.0/latency/dnorm-latency.png .
