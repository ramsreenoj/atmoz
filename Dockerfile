FROM debian:buster
MAINTAINER Adrian Dvergsdal [atmoz.net]

# Steps done in one RUN layers:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys

ADD resources/config /etc/sftp
ADD resources/keys /etc/ssh

EXPOSE 22/tcp

ENTRYPOINT ["/run.sh"]
