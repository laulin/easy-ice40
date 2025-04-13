FROM ubuntu:24.04

RUN apt update && apt upgrade -y && apt install -y python3 python3-pip gtkwave

RUN pip3 install --break-system-packages -U icefunprog apio
RUN apio install oss-cad-suite

RUN mkdir /work
RUN mkdir /home/user
WORKDIR /work

COPY icefun /usr/share/ice40/icefun

RUN deluser --remove-home ubuntu
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]