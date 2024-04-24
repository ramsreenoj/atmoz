FROM debian:bullseye
MAINTAINER Adrian Dvergsdal [atmoz.net]

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN /bin/sh -c echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories &&     apk add --no-cache bash shadow@community openssh openssh-sftp-server &&     sed -i 's/GROUP=1000/GROUP=100/' /etc/default/useradd &&     mkdir -p /var/run/sshd &&     rm -f /etc/ssh/ssh_host_*key*

COPY file:7d0c9016d500c02a71cb9cc6316134f9d4a8b622809a9128dfba396d012b6f92 /etc/ssh/sshd_config
COPY file:7d0c9016d500c02a71cb9cc6316134f9d4a8b622809a9128dfba396d012b6f92 /etc/ssh/sshd_config
COPY file:66ce45b64c206be5e4493ef9e1ce5ff20f524ff649aa1ac3ac87d62f578eed24 /usr/local/bin/


EXPOSE 22

ENTRYPOINT ["/entrypoint"]

ADD dir:284cd3863a0066dac6574bb3ae6acb6040b720c5d02866fffe68fa2dbe4ad14c /etc/sftp
ADD dir:d57473419c0db4ed344ad70d3d05ad451fb7e1615bf6981ff87b8a09902392a5 /etc/ssh
ADD file:77d47b30138b3dd887125b3fb66db4c50131cec5f1590140c24fe43ece193c31 /run.sh
ADD file:77d47b30138b3dd887125b3fb66db4c50131cec5f1590140c24fe43ece193c31 /run.sh


EXPOSE 22/tcp

ENTRYPOINT ["/run.sh"]
ADD resources/config /etc/sftp
ADD resources/keys /etc/ssh
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.external.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.ops.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.unipay.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.ce.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.tisl.pipelines/.ssh/keys/id_rsa.pub

ADD run.sh /run.sh
EXPOSE map[22/tcp:{}]

ENTRYPOINT ["/run.sh"]










