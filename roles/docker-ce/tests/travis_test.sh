#!/usr/bin/env bash

set -e

export container_id=$(date +%s)
export cleanup=false
export skip_rerun=true

old_version=17.03.0
playbook_opts="-e docker_version=$old_version"
playbook_opts="$playbook_opts" ${PWD}/tests/test.sh

# Ensure docker is installed
docker exec --tty ${container_id} env TERM=xterm which docker

# Ensure specified version is installed
docker_info=$(docker exec --tty ${container_id} env TERM=xterm docker info)
echo $docker_info | grep $old_version

# Install latest docker
export container_id=$(date +%s)
playbook_opts='-e {"docker_opts":{"dns":["192.168.1.1","192.168.1.2"]},"docker_envs":{"http_proxy":"192.168.1.3"}}'
playbook_opts="$playbook_opts" ${PWD}/tests/test.sh
docker_info=$(docker exec --tty ${container_id} env TERM=xterm docker info)
if ! echo $docker_info | grep $old_version >/dev/null 2>&1; then
    echo "Install latest docker successfully"
fi
# Testing docker opts
docker_conf=$(docker exec --tty ${container_id} env TERM=xterm cat /etc/docker/daemon.json)
# Testing docker environment
echo $docker_info | grep 192.168.1.3
echo "=== Test change docker environemnt success ==="
# Testing docker conf
echo $docker_conf | grep 192.168.1.2
echo "=== Test change docker configuration success ==="
