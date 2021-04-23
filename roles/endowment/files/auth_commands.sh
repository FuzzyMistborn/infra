#!/bin/sh
#
# You can have only one forced command in ~/.ssh/authorized_keys. Use this
# wrapper to allow several commands.

case "$SSH_ORIGINAL_COMMAND" in
    "docker container restart logitech_media_server")
        docker container restart logitech_media_server
        ;;
    *)
        echo "Access denied"
        exit 1
        ;;
esac