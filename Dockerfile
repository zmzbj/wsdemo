FROM golang:latest AS build
MAINTAINER zzm

ENV PATH /usr/local/wsdemo:$PATH

RUN mkdir -p /go/src/github/wsdemo
COPY . /go/src/github/wsdemo
WORKDIR /go/src/github/wsdemo

RUN go build wsdemo.go
RUN mv ./wsdemo /usr/local/wsdemo/

EXPOSE 7777

CMD /usr/local/wsdemo/wsdemo
