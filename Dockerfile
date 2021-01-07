FROM golang:latest AS build
MAINTAINER zzm

ENV PATH /usr/local/wsdemo/bin:$PATH

RUN mkdir -p /go/src/github/wsdemo
RUN mkdir -p /usr/local/wsdemo/bin
COPY . /go/src/github/wsdemo
WORKDIR /go/src/github/wsdemo

RUN GOPROXY=https://goproxy.cn go build -o wsdemo wsdemo.go
RUN mv ./wsdemo /usr/local/wsdemo/bin/

EXPOSE 7777

CMD /usr/local/wsdemo/bin/wsdemo
