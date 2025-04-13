#!/bin/bash

USER_ID=${HOST_UID:-1000}
GROUP_ID=${HOST_GID:-1000}
USER_NAME=${HOST_USER:-user}

groupadd -g $GROUP_ID $USER_NAME

useradd -m -u $USER_ID -g $GROUP_ID -s /bin/bash $USER_NAME

usermod -a -G dialout $USER_NAME

cp -r /root/.apio /home/$USER_NAME/.apio
chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.apio

su $USER_NAME