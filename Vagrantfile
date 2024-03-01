box = "ubuntu/jammy64"

common_script = <<~SHELL
  sudo apt update
  sudo apt upgrade -y
SHELL

Vagrant.configure("2") do |config|
  (0..2).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.box = box
      node.vm.hostname = "node#{i}.local"
      node.vm.network :private_network, ip: "192.168.56.#{i+2}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end

      # To hold the downloaded items and survive VM restarts
      node.vm.synced_folder "share/dl", "/downloads", create: true

      node.vm.provision "shell", inline: common_script
      node.vm.provision "ansible" do |ansible|
        ansible.verbose = "v"
        ansible.playbook = "bootstrap.yml"
        ansible.compatibility_mode = "2.0"
      end
    end
  end

  config.vm.define "lb" do |node|
    node.vm.box = box
    node.vm.network :private_network, ip: "192.168.56.100"
    node.vm.hostname = "lb.local"
    node.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end

    node.vm.synced_folder "share/dl", "/downloads", create: true

    node.vm.provision "shell", inline: common_script
    node.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "bootstrap.yml"
      ansible.compatibility_mode = "2.0"
    end
  end
end
