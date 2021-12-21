#!/bin/sh

if bw sync --nointeraction --session "$(cat /tmp/bw.token)" > /dev/null ; then
    bw get password "Ansible Infra" --session "$(cat /tmp/bw.token)"
else
    bw unlock --raw > /tmp/bw.token
    bw get password "Ansible Infra" --session "$(cat /tmp/bw.token)"
fi