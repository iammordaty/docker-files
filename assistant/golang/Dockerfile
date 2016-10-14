FROM golang:1.7

# env variables

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# apps and libs

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bpm-tools \
    build-essential \
    cmake \
    libavcodec-dev \
    libavformat-dev \
    libavresample-dev \
    libavutil-dev \
    libeigen3-dev \
    libfftw3-dev \
    libqt4-dev \
    libsamplerate0-dev \
    libsox-fmt-mp3 \
    libtag1-dev \
    libyaml-dev \
    pkg-config \
    python-dev \
    python-numpy  \
    python-numpy-dev \
    qt5-default \
    swig

RUN git clone https://github.com/ibsh/libKeyFinder.git /tmp/keyfinder && \
    (cd /tmp/keyfinder && \
    qmake && \
    make && \
    make install && \
    rm -r /tmp/keyfinder)

RUN git clone https://github.com/EvanPurkhiser/keyfinder-cli.git /tmp/keyfinder-cli && \
    (cd /tmp/keyfinder-cli && \
    make && \
    make install && \
    rm -r /tmp/keyfinder-cli)

RUN git clone https://github.com/iammordaty/musly.git /tmp/musly && \
    (cd /tmp/musly && \
    mkdir -p build && cd build && \
    cmake ..  && \
    make && \
    make install && \
    rm -r /tmp/musly)

# taken from https://github.com/metabrainz/acousticbrainz-server/blob/master/admin/install_hl_extractor.sh

RUN git clone https://github.com/MTG/gaia.git /tmp/gaia && \
    (cd /tmp/gaia && \
    ./waf configure --with-python-bindings && \
    ./waf && \
    ./waf install && \
    rm -r /tmp/gaia)

RUN git clone https://github.com/MTG/essentia.git /tmp/essentia && \
    (cd /tmp/essentia && \
    ./waf configure --mode=release --with-gaia --with-example=streaming_extractor_music_svm,streaming_extractor_music && \
    ./waf && \
    cp ./build/src/examples/essentia_streaming_extractor_music_svm /usr/local/bin && \
    cp ./build/src/examples/essentia_streaming_extractor_music /usr/local/bin && \
    cp ./build/src/libessentia.so /usr/local/lib && \
    rm -r /tmp/essentia)

RUN curl http://essentia.upf.edu/documentation/svm_models/essentia-extractor-svm_models-v2.1_beta1.tar.gz | tar xz -C /tmp && \
    mv /tmp/v2.1_beta1/svm_models/ /usr/local/bin/

RUN apt-get autoremove && \
    apt-get clean

RUN ldconfig /usr/local/lib

# prepare entrypoint

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
