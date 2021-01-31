# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "nfs-server" do |nfs|
    nfs.vm.box = "ubuntu/xenial64"
    nfs.vm.hostname = "nfs-server.vagrant.com"
    nfs.vm.network "private_network", ip: "172.16.1.99"
    nfs.vm.provider "virtualbox" do |n|
      n.name = "nfs-server"
      n.memory = 5120
      n.cpus = 1
    end
    nfs.vm.provision "shell",path: "bootstrap_nfs.sh"
  end

#  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.boot_timeout = 1000
  # Kubernetes Master 
  config.vm.define "k8smaster", primary: true do |k8smaster|
    k8smaster.vm.box = "ubuntu/xenial64"
    k8smaster.vm.hostname = "k8smaster.vagrant.com"
    k8smaster.vm.network "private_network", ip: "172.16.1.100"
    k8smaster.vm.provider "virtualbox" do |v|
      v.name = "k8smaster"
      v.memory = 2048
      v.cpus = 2  
    end
    k8smaster.vm.provision "shell", path: "bootstrap.sh"
    k8smaster.vm.provision "shell", path: "bootstrap_k8s.sh"
  end

  NodeCount = 3

  # Kubernetes Minions
  (1..NodeCount).each do |i|
    config.vm.define "k8sworker#{i}" do |k8sworker|
      k8sworker.vm.box = "ubuntu/xenial64"
      k8sworker.vm.hostname = "k8sworker#{i}.vagrant.com"
      k8sworker.vm.network "private_network", ip: "172.16.1.10#{i}"
      k8sworker.vm.provider "virtualbox" do |v|
        v.name = "k8sworker#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      k8sworker.vm.provision "shell", path: "bootstrap.sh"
      k8sworker.vm.provision "shell", path: "bootstrap_k8sworker.sh"
    end
  end


end
