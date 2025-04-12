build:
	docker build -t easy-ice40 .

install:
	cp run.sh /usr/local/bin/easy-ice40 && chmod a+x /usr/local/bin/easy-ice40

uninstall:
	rm -rf /usr/local/bin/easy-ice40
	docker rmi -f easy-ice40