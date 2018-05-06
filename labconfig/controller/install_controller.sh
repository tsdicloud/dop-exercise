#!/bin/sh
# Install script to establish a docker/kubernetes client machine
# to control a CCE cluster by API
#
# Run this script as sudoer

sudo yum -y update
sudo yum -y install curl git

###
# Stage 1: Install Docker CE
# It is required to send docker command by commandline tool and
# to pack images using Dockerfile
sudo yum-config-manager \
   --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y makecache fast
sudo yum -y install docker-ce

sudo groupadd docker
sudo usermod -aG docker $USER

# MAKE SURE THAT THE DOWNLOADED AUTHENTTICATION FILE DOES NOT CONTAIN ANY LINEBREAKS!!!
# This may not work on windows systems due to differnet CR LF handling.
mkdir $HOME/.docker

#### TODO by students
## cp config/dockercfg.txt $HOME/.docker/config.json

sudo cp config/daemon.json /etc/docker/daemon.json

# finally, start docker daemon
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker

cp otc_certs.pem $HOME/otc_certs.pem
sudo cp otc.sh /usr/local/bin
sudo cp cce_kubeaddclusters /ust/local/bin
sudo cp cce_kubesecret /ust/local/bin

###
# Stage 3: INstall kubernetes client (kubectl)
# It is used to contact the kubernetes cluster manager that underlies CCE
#curl  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl > /tmp/kubectl
curl  https://storage.googleapis.com/kubernetes-release/release/v1.7.16/bin/linux/amd64/kubectl > /tmp/kubectl
chmod 755 /tmp/kubectl
sudo mv -i -f /tmp/kubectl /usr/local/bin/kubectl

###
# Stage 3: Setup kubectl
# The setup enables command line completion and installs an initial kube
# ~/.kube/config
# See also
# https://kubernetes.io/docs/concepts/cluster-administration/authenticate-across-clusters-kubeconfig/
# for kubectl configuration details

# prepare commandline completion and config directories
echo "source <(kubectl completion bash)" >> ~/.bashrc#
mkdir $HOME.kube
chmod 700 $HOME/.kube

echo "
# some useful kubernetes aliased
alias docker_clean_images='docker rmi \$(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm \$(docker ps --filter=status=exited --filter=status=created -q)'
alias kube_used_secrets='kubectl get pods -o json | jq ".items[].spec.containers[].env[]?.valueFrom.secretKeyRef.name" | grep -v null | sort | u
niq'
" >> ~/.bashrc


