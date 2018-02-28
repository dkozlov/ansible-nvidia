ansible-nvidia
====================

ansible roles to install docker-ce, graphics drivers, cuda, cudnn and nvidia-docker

Roles Variables
--------------
docker-ce
--------------
- `docker_version`: latest
- `docker_state`: started
cuda
--------------
- `cuda_version_major` major cuda version
- `cuda_version_minor` minor cuda version
cudnn
--------------
- `cuda_version_major` major cuda version
- `cuda_version_minor` minor cuda version
- `cudnn_version` is a variable to specify cudnn version
nvidia-docker
--------------
- `nvidia_docker_version`is

Example Playbook
----------------
```
- hosts: gpus
  become: true
  become_user: root
  roles:
    - { role: docker-ce, docker_version: latest }
    - { role: cuda, cuda_version_major: 9, cuda_version_minor: 1 }
    - { role: cudnn, cuda_version_major: 9, cuda_version_minor: 1, cudnn_version: 7 }
    - { role: nvidia-docker, nvidia_docker_version: 2.0.2 }
```

How-to run
----------------

# Install ansible
`sudo apt install ansible`
# Create hosts file in current directory
[gpus]
192.168.1.2
# Use locally available ssh keys to authorise logins on a remote machine 
`ssh-copy-id  root@192.168.1.2`
# Run playbook
`ansible-playbook gpus.yml`
