build:
	sudo docker.io build -t aoki/docker-virtuoso .

run:
	sudo docker.io run -d --restart="always" -v /opt/virtuoso:/virtuoso:rw -t -p 1111:1111 -p 8890:8890 aoki/docker-virtuoso
#/usr/local/virtuoso-opensource/bin/virtuoso-t -df +configfile /virtuoso-opensource/db/virtuoso.ini

bash:
	sudo docker.io run -v /opt/virtuoso:/virtuoso:rw -i -t aoki/docker-virtuoso /bin/bash
	#-v /opt/mail:/mail:rw -v /opt/mail.git:/repo.git:rw -e "mail_PASS=glyT0uC@n" -e "mail_ARGS=--port 8000" -p 8000:8000 --name="docker-virtuoso_bluetree" aoki/docker-virtuoso /bin/bash

env:
	sudo docker.io run -v /opt/virtuoso:/virtuoso --rm --link mysql-docker-virtuoso_bluetree:db --name="docker-virtuoso_bluetree-env" aoki/docker-virtuoso env

ps:
	sudo docker.io ps

stop:
	sudo docker.io stop aoki/docker-virtuoso

rm:
	sudo docker.io rm aoki/docker-virtuoso

ip:
	sudo docker.io inspect -f "{{ .NetworkSettings.IPAddress }}" docker-virtuoso_bluetree

restart:
	sudo docker.io restart docker-virtuoso_bluetree

dump:
	sudo docker.io export docker-virtuoso_bluetree > mail.gly.tar

load:
	cat mail.gly.tar.gz | docker import - aoki/docker-mail:mail_bluetree
	
clean: stop rm build run
	echo "cleaned."

log:
	sudo docker.io logs -f docker-virtuoso_bluetree
	
.PHONY: build run test clean
