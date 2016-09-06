#!/bin/bash

rm -fr /go/bin /go/pkg

go-wrapper download
go-wrapper install

go get github.com/githubnemo/CompileDaemon

CompileDaemon -directory="." -build="go install" -command="assistant-backend"
