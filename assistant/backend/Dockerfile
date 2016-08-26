FROM debian:jessie

# env variables

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

ENV GOLANG_VERSION 1.7
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOPATH=/data
ENV GOBIN=$GOPATH/bin

ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# apps and libs

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    vim \
    git \
    supervisor \
    build-essential \
	cmake \
    qt5-default \
	libeigen3-dev \
    libfftw3-dev \
    libavutil-dev \
    libavresample-dev \
    libavcodec-dev \
    libavformat-dev \
    bpm-tools \
    libsox-fmt-mp3

RUN git clone https://github.com/ibsh/libKeyFinder.git keyfinder && \
    (cd keyfinder && \
    qmake && \
    make && \
    make install)

RUN git clone https://github.com/EvanPurkhiser/keyfinder-cli.git && \
    (cd keyfinder-cli && \
    make && \
    make install)

RUN git clone https://github.com/iammordaty/musly.git && \
	(cd musly && \
	mkdir -p build && cd build && \
	cmake ..  && \
	make && \
	make install)

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

RUN apt-get autoremove && \
    apt-get clean

RUN ldconfig /usr/local/lib

# configs

COPY ./conf/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY ./scripts/init.sh /init.sh

RUN chmod +x /init.sh