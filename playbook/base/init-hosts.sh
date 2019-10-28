#! /bin/sh

[ $# -eq 1 ] || { echo "usage: $(basename $0) new_host_name"; exit 1; }

SROOT=`cd $(dirname $0);pwd`

cp hosts-file /etc/hosts

newhost=$1
#ansible-playbook -i ../../hosts sync-host-file.yml
#the following task will restart the host
ansible-playbook -i ../../hosts setup-swap.yml --extra-vars "target=$newhost"
ansible-playbook -i ../../hosts mount-data.yml --extra-vars "target=$newhost"
ansible-playbook -i ../../hosts setup-new-host.yml --extra-vars "target=$newhost"
