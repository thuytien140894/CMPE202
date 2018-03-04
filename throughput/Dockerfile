FROM ubuntu:16.04

# ubuntu setup
RUN apt-get update -y
RUN apt-get upgrade -y 
RUN apt-get install -y build-essential
RUN apt-get install -y git
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN apt-get install -y linux-tools-common
RUN apt-get install -y linux-tools-4.13.0-36-generic
RUN apt-get install -y linux-cloud-tools-4.13.0-36-generic
RUN apt-get install -y python-tk
RUN apt-get install -y python-pip
RUN pip install matplotlib

# set up pmu-tools
RUN git clone https://github.com/andikleen/pmu-tools
WORKDIR pmu-tools
RUN export PATH=$PATH:`pwd`

# set up fasttext
RUN wget https://github.com/facebookresearch/fastText/archive/v0.1.0.zip
RUN unzip v0.1.0.zip
WORKDIR fastText-0.1.0
RUN ls -l
RUN make

# set up the training sample
RUN mkdir data
RUN wget -c http://mattmahoney.net/dc/enwik9.zip -P data
RUN unzip data/enwik9.zip -d data
RUN perl wikifil.pl data/enwik9 > data/fil9
RUN mkdir result

# set up scripts to run tests
RUN echo ./fasttext skipgram -input data/test -output result/fil9 -thread 1 > run1.sh
RUN echo ./fasttext skipgram -input data/test -output result/fil9 -thread 2 > run2.sh
RUN echo ./fasttext skipgram -input data/test -output result/fil9 -thread 4 > run4.sh
RUN echo ./fasttext skipgram -input data/test -output result/fil9 -thread 8 > run8.sh

RUN chmod 777 *.sh

# set up data for training
RUN head -c130m data/fil9 > data/5T.test
RUN head -c32m data/fil9 > data/1243B.test
RUN head -c8m data/fil9 > data/310B.test
RUN head -c1800k data/fil9 > data/75B.test
RUN head -c300k data/fil9 > data/18B.test

ADD tl-barplot.py /pmu-tools/tl-barplot.py

RUN mkdir plot
