FROM gliderlabs/alpine:3.4
MAINTAINER Cesco Ferraro <francescoaferraro@gmail.com>
RUN echo 'Welcome to Alpine, all set for Golang and Node!'
RUN apk update && apk add curl git go && mkdir /gopath

RUN apk add nodejs
RUN apk add go

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin
