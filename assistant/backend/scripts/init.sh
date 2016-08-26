#!/bin/bash

rm -fr /data/bin /data/pkg

go get \
    github.com/julienschmidt/httprouter \
    github.com/githubnemo/CompileDaemon

(cd /data/src/github.com/iammordaty/assistant-backend/ && go install )
