#!/bin/bash
# start_srs_srt.sh - Script simples para iniciar SRS com SRT

docker run --rm -it \
  -p 1935:1935 \
  -p 8080:8080 \
  -p 10080:10080/udp \
  ossrs/srs:5 \
  ./objs/srs -c conf/srt.conf
