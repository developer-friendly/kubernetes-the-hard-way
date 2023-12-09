box = "ubuntu/jammy64"

common_script = <<-SCRIPT
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y ansible
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.define "node0" do |node0|
    node0.vm.box = box
    node0.vm.hostname = "node0.local"
    node0.vm.network :private_network, ip: "192.168.56.2"
    node0.vm.provision "shell", inline: common_script

    node0.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "bootstrap-controlplane.yml"
    end

  end

  config.vm.define "node1" do |node1|
    node1.vm.box = box
    node1.vm.network :private_network, ip: "192.168.56.3"
    node1.vm.hostname = "node1.local"
    node1.vm.provision "shell", inline: common_script

    node1.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "bootstrap-workers.yml"
    end
  end

  config.vm.define "node2" do |node2|
    node2.vm.box = box
    node2.vm.network :private_network, ip: "192.168.56.4"
    node2.vm.hostname = "node2.local"
    node2.vm.provision "shell", inline: common_script

    node2.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "bootstrap-workers.yml"
    end

  end
end
