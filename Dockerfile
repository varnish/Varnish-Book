FROM ubuntu:16.04

MAINTAINER JesusLC <jeslopcru@gmail.com>

RUN apt-get update
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN  apt-get install -y gawk
RUN  apt-get install -y git
RUN  apt-get install -y build-essential
RUN  apt-get install -y php5.6
RUN  apt-get install -y gdebi-core
RUN  apt-get install -y sphinxsearch
RUN  apt-get install -y python-docutils
RUN  apt-get -y install inkscape
RUN  apt-get -y install graphviz
RUN  apt-get install -y rst2pdf
RUN pip install --upgrade pip
RUN pip install rst2pdf
RUN pip install sphinx

ADD . /
