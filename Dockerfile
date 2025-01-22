FROM debian:latest
LABEL Name=debssh Version=0.1.0

# set the locales
ENV LANG=fr_FR.UTF-8
ENV LANGUAGE=fr_FR.UTF-8
ENV TZ=Europe/Paris

ARG USERNAME=lambda

# Packages
RUN apt-get update && apt-get -y upgrade; \
        # Tools
        apt-get install -y sudo htop mc bash sed tzdata; \
        # Net utils
        apt-get install -y iputils-ping iproute2 traceroute dnsutils iperf; \
        # extra packages
        apt-get install -y openssh-server; \
        # Cleaning
        apt-get clean autoclean -y; \
        apt-get autoremove -y; \
        rm -rf /var/lib/{apt,dpkg,cache,log}/; \
        rm -rf /var/lib/apt/lists/*.lz4; \
        rm -rf /var/log/*; \
        rm -rf /tmp/*; \
        rm -rf /var/tmp/*; \
        rm -rf /usr/share/doc/; \
        rm -rf /usr/share/man/; \
        rm -rf $HOME/.cache; \
        touch /var/log/lastlog;

# sshd
RUN mkdir /var/run/sshd; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 no/' /etc/ssh/sshd_config; \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; 

# Add user
RUN useradd -m $USERNAME && echo "$USERNAME:$USERNAME" | chpasswd && adduser $USERNAME sudo

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

EXPOSE 22

ENTRYPOINT ["entry_point.sh"]
CMD    ["/usr/sbin/sshd", "-D", "-e"]

# add authorized_keys to user $USERNAME
RUN mkdir -p /home/$USERNAME/.ssh
WORKDIR /home/$USERNAME
ADD --chown=appuser:appuser authorized_keys /home/$USERNAME/.ssh
RUN chmod 600 /home/$USERNAME/.ssh/authorized_keys; chmod 700 /home/$USERNAME/.ssh; chown $USERNAME /home/$USERNAME -R
