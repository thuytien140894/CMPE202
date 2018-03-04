FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y build-essential
RUN apt-get install -y git
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN apt-get install -y r-base

# set up fasttext
RUN wget https://github.com/facebookresearch/fastText/archive/v0.1.0.zip
RUN unzip v0.1.0.zip
WORKDIR fastText-0.1.0
RUN make

# get the train data
RUN mkdir data
RUN wget -c http://mattmahoney.net/dc/enwik9.zip -P data
RUN unzip data/enwik9.zip -d data
RUN perl wikifil.pl data/enwik9 > data/fil9

# train the data
RUN mkdir result
RUN head -c100m data/fil9 > data/test
RUN ./fasttext skipgram -input data/test -output result/fil9

# compile the benchmark source code
ADD latency /fastText-0.1.0/latency
RUN cd latency && make clean && make && chmod 777 latency
ADD dnorm.R /fastText-0.1.0/latency/dnorm.R
