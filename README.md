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
- `cuda_version_major` major cuda version, example: 9
- `cuda_version_minor` minor cuda version, example: 1
cudnn
--------------
- `cuda_version_major` major cuda version, example: 9
- `cuda_version_minor` minor cuda version, example: 1
- `cudnn_version` cudnn version, example: 7
nvidia-docker
--------------
- `nvidia_docker_version` nvidia-docker version, example: 2.0.2

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

#How-to run
----------------
- Install ansible
```
sudo apt install ansible
```
- Create hosts file in current directory
```
[gpus]
192.168.1.2
```
- Use locally available ssh keys to authorise logins on a remote machine 
```
ssh-copy-id  root@192.168.1.2
```
- Run playbook
```
ansible-playbook gpus.yml
```
