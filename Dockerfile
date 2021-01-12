FROM golang:latest AS build
MAINTAINER zzm

ENV PATH /usr/local/wsdemo/bin:$PATH

RUN mkdir -p /go/src/github/wsdemo
COPY . /go/src/github/wsdemo
WORKDIR /go/src/github/wsdemo

RUN GOPROXY=https://goproxy.cn go build -o wsdemo wsdemo.go
FROM debian 
#FROM Alpine
COPY --from=build /go/src/github/wsdemo/wsdemo .

EXPOSE 7777

CMD ./wsdemo
