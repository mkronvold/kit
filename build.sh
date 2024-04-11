#!/bin/bash

go build . && cp kubernetes-inventory ../e2kpe.github.io && echo Copied new binary to e2kpe.github.io
