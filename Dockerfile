FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y cron openssh-server && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/ctf-cracked -s /bin/bash ctf-cracked
RUN useradd -m -d /home/ctf -s /bin/bash ctf && \
    echo "ctf:shellmates" | chpasswd

RUN mkdir -p /root/.ssh /home/ctf-cracked/.ssh /home/ctf/.ssh /run/sshd && \
    ssh-keygen -f /root/.ssh/id_rsa -N "" && \
    cp /root/.ssh/id_rsa.pub /home/ctf-cracked/.ssh/authorized_keys && \
    cp /home/ctf-cracked/.bashrc /root/.bashrc.bak && \
    echo "bash ~/.bashrc" >> /home/ctf-cracked/.ssh/rc && \
    echo "*    * * * * ssh -o 'StrictHostKeyChecking no' ctf-cracked@127.0.0.1 :" > /root/.cronjob && \
    echo "*/15 * * * * cp /root/.bashrc.bak /home/ctf-cracked/.bashrc" >> /root/.cronjob && \
    crontab /root/.cronjob && \
    chmod -x /etc/update-motd.d/* && \
    chmod o-r /tmp

COPY challenge/tictoctou /usr/games/tictoctou
COPY challenge/ctf-cracked /home/ctf-cracked

RUN chown root:ctf-cracked /usr/games/tictoctou && \
    chmod 2755 /usr/games/tictoctou

WORKDIR /home/ctf
COPY challenge/ctf/rc .ssh/rc
RUN ln -sf /dev/null .bash_history && \
    chown -R root: . && \
    chmod o-w .

WORKDIR /home/ctf-cracked
RUN ln -sf /dev/null .bash_history && \
    chown -R root:ctf-cracked .[^.]* * && \
    chown root: . && \
    chmod 664 .bashrc && \
    chmod 550 .ssh && \
    chmod 444 tictoctou.c header.h && \
    chmod 440 flag.txt && \
    chmod o-w .

EXPOSE 22

ENTRYPOINT service cron start && service ssh start && tail -f /dev/null
