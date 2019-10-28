#! /bin/sh
cp hosts-file /etc/hosts
ansible-playbook -i ../../hosts sync-host-file.yml
