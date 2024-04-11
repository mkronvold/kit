#!/bin/bash

go build . && cp kubernetes-inventory ../e2kpe.github.io && echo Copied new binary to e2kpe.github.io && pushd ../e2kpe.github.io && git add kubernetes-inventory && git commit -m "updated kit" && git push && popd
