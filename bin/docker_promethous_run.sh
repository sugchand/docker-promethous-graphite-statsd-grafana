#!/bin/bash -x
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PARENTDIR="$(dirname "$SCRIPTPATH")"
CONFIGFILE="$PARENTDIR/config/prometheus.yml"
CONTAINERCONFIG="/etc/prometheus/prometheus.yml"
CONTAINERDATA="/data/prometheus"
DATADIR="$PARENTDIR/data"

sudo docker stop prometheous
sudo docker rm prometheous
sudo rm -rf $DATADIR
sudo mkdir -p $DATADIR
sudo chmod a+rw $DATADIR
sudo docker run --name prometheous \
--restart=always --network host \
-v "$CONFIGFILE:$CONTAINERCONFIG" \
-v "$DATADIR:$CONTAINERDATA" \
prom/prometheus \
--config.file="$CONTAINERCONFIG" \
--storage.tsdb.path="$CONTAINERDATA"
