#!/bin/sh
#
# You can have only one forced command in ~/.ssh/authorized_keys. Use this
# wrapper to allow several commands.

case "$SSH_ORIGINAL_COMMAND" in
    "./scripts/cast_traffic.sh")
        ./scripts/cast_traffic.sh
        ;;
    "./scripts/cast_weather.sh")
        ./scripts/cast_weather.sh
        ;;
    "./scripts/cast_frontdoor.sh")
        ./scripts/cast_frontdoor.sh
        ;;
    "./scripts/cast_media.sh")
        ./scripts/cast_media.sh
        ;;
    "./scripts/cast_stop.sh")
        ./scripts/cast_stop.sh
        ;;
    *)
        echo "Access denied"
        exit 1
        ;;
esac