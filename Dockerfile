FROM arm32v7/golang

RUN apt update
RUN apt install git \
        make \
        gcc \
        musl-dev

git clone https://github.com/knqyf263/gost.git
cd gost
go build .
make


MAINTAINER yudanja

ENV LOGDIR /var/log/vuls
ENV WORKDIR /vuls

RUN apt install --no-cache ca-certificates git \
    && mkdir -p $WORKDIR $LOGDIR

COPY gost /usr/local/bin/

VOLUME ["$WORKDIR", "$LOGDIR"]
WORKDIR $WORKDIR
ENV PWD $WORKDIR

ENTRYPOINT ["gost"]
CMD ["--help"]
