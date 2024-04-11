#!/bin/bash

./run.sh


datestamp=$(date +'%Y-%m-%d_%H-%M-%S')

g add html
g commit -m "run ${datestamp}"
g push
