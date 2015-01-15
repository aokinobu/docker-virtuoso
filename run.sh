#!/bin/bash

#[ -f /.setup_trac.sh ] && /bin/bash /.setup_trac.sh

ls -al /virtuoso/
echo "running:>/usr/local/virtuoso-opensource/bin/virtuoso-t -df +configfile /virtuoso/db/virtuoso.ini"
/usr/local/virtuoso-opensource/bin/virtuoso-t -df +configfile /virtuoso/db/virtuoso.ini
