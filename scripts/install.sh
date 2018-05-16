#!/bin/sh
docker run -v ${HOME}/${SITE_CODE}/virtuoso/data/:/tmp/virtuoso/ --rm aokinobu/virtuoso:v7.2.4.2  cp -R /usr/local/virtuoso-opensource/var/lib/virtuoso/db /tmp/virtuoso/
sudo chown $USER:$GROUPS -R ${HOME}/${SITE_CODE}/virtuoso/data/
