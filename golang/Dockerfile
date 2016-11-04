FROM golang:1.7-alpine


RUN     apk add -U git bash curl tree

RUN     go get github.com/golang/lint/golint && \
        cp /go/bin/golint /usr/bin/ && \
        rm -rf /go/src/* /go/pkg/* /go/bin/*

RUN     go get github.com/cespare/reflex && \
        cp /go/bin/reflex /usr/bin/ && \
        rm -rf /go/src/* /go/pkg/* /go/bin/*


RUN     export GLIDE=v0.12.3; \
        export SRC=https://github.com/Masterminds/glide/releases/download/; \
        curl -sL ${SRC}/${GLIDE}/glide-${GLIDE}-linux-amd64.tar.gz | \
        tar -xz linux-amd64/glide && \
        mv linux-amd64/glide /usr/bin/glide && \
        chmod +x /usr/bin/glide

ENV     PS1="# "
ENV     GOBIN=/go/bin
ENV     CGO_ENABLED=0