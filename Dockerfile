FROM nathanosman/alpine-golang-armhf

RUN apk update
RUN apk add git \
        make \
        gcc \
        musl-dev

ENV REPOSITORY github.com/securitysamurai/arm-golang-alpine-gost
COPY . $GOPATH/src/$REPOSITORY
RUN cd $GOPATH/src/$REPOSITORY && make install

FROM securitysamurai/arm-golang-alpine-gost

MAINTAINER yudanja

ENV LOGDIR /var/log/vuls
ENV WORKDIR /vuls

RUN apk add --no-cache ca-certificates git \
    && mkdir -p $WORKDIR $LOGDIR

COPY --from=builder /go/bin/gost /usr/local/bin/

VOLUME ["$WORKDIR", "$LOGDIR"]
WORKDIR $WORKDIR
ENV PWD $WORKDIR

ENTRYPOINT ["gost"]
CMD ["--help"]
