install:
	mkdir /opt/virtuoso
	cp -R db /opt/virtuoso
	cp -R scripts /opt/virtuoso

build:
	sudo docker build -t aoki/docker-virtuoso .

buildnc:
	sudo docker build --no-cache=true -t aoki/docker-virtuoso .

run:
	sudo docker run -d --restart="always" -v /etc/localtime:/etc/localtime -v /opt/virtuoso:/virtuoso:rw -t -p 1111:1111 -p 8890:8890 --name="docker-virtuoso_bluetree" aoki/docker-virtuoso

runbeta:
	sudo docker run -d --restart="always" -v /etc/localtime:/etc/localtime -v /opt/beta.virtuoso:/virtuoso:rw -t -p 1112:1111 -p 8891:8890 --name="docker-beta.virtuoso_bluetree" aoki/docker-virtuoso

exec:
	sudo docker exec -it docker-virtuoso_bluetree /bin/bash

execscript:
	sudo docker exec -it docker-virtuoso_bluetree /usr/local/virtuoso-opensource/bin/isql 1111 dba dba /virtuoso/scripts/load.sql -i /virtuoso/rlog.ttl http://test.rlog

bash:
	sudo docker run -it --rm -v /opt/virtuoso:/virtuoso:rw -i -t aoki/docker-virtuoso /bin/bash

env:
	sudo docker run -it -v /opt/virtuoso:/virtuoso --rm --link mysql-docker-virtuoso_bluetree:db aoki/docker-virtuoso env

ps:
	sudo docker ps

stop:
	sudo docker stop docker-virtuoso_bluetree

stopbeta:
	sudo docker stop docker-beta.virtuoso_bluetree

rm:
	sudo docker rm docker-virtuoso_bluetree

rmbeta:
	sudo docker rm docker-beta.virtuoso_bluetree

ip:
	sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" docker-virtuoso_bluetree

restart:
	sudo docker restart docker-virtuoso_bluetree

dump:
	sudo docker export docker-virtuoso_bluetree > mail.gly.tar

load:
	cat mail.gly.tar.gz | docker import - aoki/docker-mail:mail_bluetree
	
clean: stop rm build run
	echo "cleaned."

logs:
	 sudo docker logs --follow --tail=100 docker-virtuoso_bluetree

logsbeta:
	 sudo docker logs --follow --tail=100 docker-beta.virtuoso_bluetree
	
.PHONY: build run test clean
