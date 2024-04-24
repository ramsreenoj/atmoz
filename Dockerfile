FROM debian:buster
MAINTAINER Adrian Dvergsdal [atmoz.net]

# Steps done in one RUN layers:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys

ADD resources/config /etc/sftp
ADD resources/keys /etc/ssh

ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.external.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.ops.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.unipay.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.ce.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.tisl.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.adp.pipelines/.ssh/keys/id_rsa.pub
ADD resources/internal_user_ssh_keys/id_rsa.pub /home/strg.booker.pipelines/.ssh/keys/id_rsa.pub

EXPOSE 22/tcp

ENTRYPOINT ["/run.sh"]
