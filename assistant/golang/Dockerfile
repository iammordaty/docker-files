FROM golang:1.7

# env variables

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# apps and libs

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    vim \
    cmake \
    build-essential \
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

RUN apt-get autoremove && \
    apt-get clean

RUN ldconfig /usr/local/lib

# prepare entrypoint

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
