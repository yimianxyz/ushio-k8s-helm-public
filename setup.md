# Kubernetes Infrastructure Setup Guide

## Set hostname
```bash
$ hostname xxx.yimian.xyz
$ hostnamectl set-hostname xxx.yimian.xyz
```

## Physical laptop server setup
```bash
$ vi /etc/systemd/logind.conf
HandleLidSwitch=ignore
$ systemctl restart systemd-logind
```

## Add users
```bash
$ adduser iotcat
$ adduser ushio --disabled-password --disabled-login
```

Edit `/etc/passwd`:
```
iotcat:x:1000:1000::/home/iotcat:/bin/bash
ushio:x:1001:1001::/home/ushio:/usr/sbin/nologin
```

```bash
$ echo alias ushio=\'sudo -u ushio\'>~/.bash_aliases
```

## Sudo setup
```bash
$ visudo
Defaults rootpw
$ usermod -aG sudo iotcat
```

## Config SSH
Edit `/etc/ssh/sshd_config`:
```
Port 2222
PermitRootLogin no
PasswordAuthentication yes
```

```bash
$ sudo systemctl restart sshd 
```

## Connect to SSH
```bash
$ ssh-keygen
# on remotes 
$ ssh-copy-id -p 2222 iotcat@xxx.yimian.xyz
```

## Disable firewall
### Debian
```bash
$ sudo ufw disable
```

### CentOS
```bash
$ systemctl stop firewalld
$ systemctl disable firewalld
$ sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
$ setenforce 0
```

## Package management
### Debian
```bash
$ sudo apt update && sudo apt upgrade -y
$ sudo apt install -y wget git vim screen htop
```

### CentOS
```bash
$ yum update -y
$ yum install epel-release -y
$ yum update -y
$ yum install -y wget git vim screen ntp
```

## Enable NTP
### Debian
```bash
$ sudo apt install -y systemd-timesyncd
$ sudo systemctl start systemd-timesyncd
$ sudo systemctl enable systemd-timesyncd
```

### CentOS
```bash
$ systemctl start ntpd
$ systemctl enable ntpd
$ systemctl start crond
$ systemctl enable crond
$ crontab -e
*/5 * * * * /usr/sbin/ntpdate -u pool.ntp.org
```

## Disable swap
```bash
$ sudo swapoff -a
$ sudo sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab
```

## Install Docker
```bash
$ sudo apt install -y docker.io
$ sudo systemctl start docker
$ sudo usermod -aG docker ushio
$ cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
$ sudo systemctl enable docker
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
```

## br_netfilter
```bash
$ cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
$ cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward=1
EOF
$ sudo sysctl --system
```

## Install kubeadm kubectl kubelet
```bash
$ sudo apt-get install -y apt-transport-https ca-certificates curl
$ sudo mkdir /etc/apt/keyrings
$ sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
$ echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
$ sudo apt-get update
$ sudo apt install -y kubeadm=1.23.3-00 kubelet=1.23.3-00 kubectl=1.23.3-00
$ sudo apt-mark hold kubelet kubeadm kubectl
```

## For master node
```bash
$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16
$ ushio mkdir -p /home/ushio/.kube 
$ sudo cp -i /etc/kubernetes/admin.conf /home/ushio/.kube/config 
$ sudo chown ushio:ushio /home/ushio/.kube/config
$ ushio kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/v0.20.2/Documentation/kube-flannel.yml
```

### For small nodes
```bash
$ ushio kubectl taint node xxx node-role.kubernetes.io/small:NoSchedule
```

### Label nodes
```bash
$ ushio kubectl label node main --overwrite role=main location=usa
$ ushio kubectl label node xxx --overwrite v2ray=enabled
```

## Install Helm
```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```

## Git configuration
```bash
$ git config --global user.name "xxx.yimian.xyz"
$ git config --global user.email "xxx@yimian.xyz"
```

## Get helm repo
```bash
$ git clone -b xxx git@github.com:IoTcat/ushio-k8s-helm.git ~/prod
```

## Vim configuration
```bash
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ git clone https://github.com/iotcat/vimrc.git ~/.vim_src && rm -f ~/.vimrc && ln -s ~/.vim_src/.vimrc ~/.vimrc
$ vim +PlugInstall
$ vim
```

## For worker node
```bash
$ sudo kubeadm join [MASKED_JOIN_COMMAND]
```

On k8s console:
```bash
$ ushio kubectl label node xxx.yimian.xyz --overwrite role=<main|worker|temp> location=<usa|hk|cn>
``` 