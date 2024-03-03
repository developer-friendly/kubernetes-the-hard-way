box = "ubuntu/jammy64"
N = 2

common_script = <<~SHELL
  export DEBIAN_FRONTEND=noninteractive
  sudo apt update
  sudo apt upgrade -y
SHELL

Vagrant.configure("2") do |config|
  config.vm.define "lb" do |node|
    node.vm.box = box
    node.vm.network :private_network, ip: "192.168.56.100", hostname: true
    node.vm.network "forwarded_port", guest: 6443, host: 6443
    node.vm.hostname = "lb.local"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "k8s-the-hard-way-lb"
      vb.memory = "1024"
      vb.cpus = 1
      vb.linked_clone = true
    end

    node.vm.synced_folder "share/dl", "/downloads", create: true

    node.vm.provision "shell", inline: common_script
    node.vm.provision "ansible" do |ansible|
      ansible.verbose = "vv"
      ansible.playbook = "bootstrap.yml"
      ansible.compatibility_mode = "2.0"
    end
  end

  (0..N).each do |machine_id|
    config.vm.define "node#{machine_id}" do |node|
      node.vm.box = box
      node.vm.hostname = "node#{machine_id}.local"
      node.vm.network :private_network, ip: "192.168.56.#{machine_id+2}", hostname: true
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-the-hard-way-node#{machine_id}"
        vb.memory = "1024"
        vb.cpus = 1
        vb.linked_clone = true
      end

      # To hold the downloaded items and survive VM restarts
      node.vm.synced_folder "share/dl", "/downloads", create: true

      node.vm.provision "shell", inline: common_script

      if machine_id == N
        node.vm.provision :ansible do |ansible|
          ansible.limit = "all"
          ansible.verbose = "vv"
          ansible.playbook = "bootstrap.yml"
        end
      end
    end
  end
end
