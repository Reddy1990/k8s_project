#! /bin/bash
# url: https://dev.to/lordrahl90/creating-an-nfs-server-with-vagrant-1oke
#filename=bootstrap_nfs.sh

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.1.99 nfs-server.vagrant.com nfs-server
172.16.1.100 k8smaster.vagrant.com k8smaster
172.16.1.101 k8sworker1.vagrant.com k8sworker1
172.16.1.102 k8sworker2.vagrant.com k8sworker2
172.16.1.103 k8sworker2.vagrant.com k8sworker3
EOF

echo "[TASK 2] Download and install NFS server"
apt-get update -y -qq && apt-get -y -qq install nfs-kernel-server

echo "[TASK 3] Create a kubedata directory"
mkdir -p /srv/nfs/kubedata
mkdir -p /srv/nfs/kubedata/db
mkdir -p /srv/nfs/kubedata/storage
mkdir -p /srv/nfs/kubedata/logs

echo "[TASK 4] Update the shared folder access"
chmod -R 777 /srv/nfs/kubedata

echo "[TASK 5] Make the kubedata directory available on the network"
cat >>/etc/exports<<EOF
/srv/nfs/kubedata    *(rw,sync,no_subtree_check,no_root_squash)
EOF

echo "[TASK 6] Export the updates"
sudo exportfs -rav

echo "[TASK 7] Enable NFS Server"
sudo systemctl enable nfs-server

echo "[TASK 8] Start NFS Server"
sudo systemctl start nfs-server