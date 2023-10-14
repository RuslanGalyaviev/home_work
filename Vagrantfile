Vagrant.configure("2") do |config|
  config.vm.define "VM1" do |node1|
    node1.vm.box = "centos/7"
    node1.vm.hostname = "vm1.test.local"
    node1.vm.network "private_network", type: "static", ip: "192.168.56.10"
    node1.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
#       vb.memory = 4096 # По Заданию
      vb.cpus = 2
#       vb.cpus = 3  # По Заданию
    end
    config.vm.provision "shell", inline: "echo '192.168.56.10 vm1.test.local vm1' | sudo tee -a /etc/hosts"
    config.vm.provision "shell", inline: "echo '192.168.56.20 vm2.test.local vm2' | sudo tee -a /etc/hosts"
    config.vm.provision "shell", inline: "echo '192.168.56.30 vm3.test.local vm3' | sudo tee -a /etc/hosts"
    config.vm.provision "shell", inline: "sudo setenforce 0 || true"
    config.vm.provision "shell", inline: "sudo sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config"

    node1.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook_vm1.yml"
    end
    node1.vm.network "forwarded_port", guest: 80, host: 8080
  end

  config.vm.define "VM2" do |node2|
    node2.vm.box = "centos/7"
#     node2.vm.box = "ubuntu/bionic64"
    node2.vm.hostname = "vm2.test.local"
    node2.vm.network "private_network", type: "static", ip: "192.168.56.20"
    node2.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
#       vb.memory = 3072  # По Заданию
      vb.cpus = 2
    end
    config.vm.provision "shell", inline: "echo '192.168.56.10 vm1.test.local vm1' | sudo tee -a /etc/hosts"
    config.vm.provision "shell", inline: "echo '192.168.56.20 vm2.test.local vm2' | sudo tee -a /etc/hosts"
    config.vm.provision "shell", inline: "echo '192.168.56.30 vm3.test.local vm3' | sudo tee -a /etc/hosts"
    config.vm.provision "shell", inline: "sudo setenforce 0 || true"
#     config.vm.provision "shell", inline: "sudo sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config"
    node2.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook_vm2.yml"
    end
    node2.vm.network "forwarded_port", guest: 80, host: 8081
  end

  config.vm.define "VM3" do |node3|
    node3.vm.box = "ubuntu/bionic64"
    node3.vm.hostname = "vm3"
    node3.vm.network "private_network", type: "static", ip: "192.168.56.30"
    node3.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
#       vb.memory = 2048  # По Заданию
      vb.cpus = 2
    end
    config.vm.provision "shell", inline: "echo '192.168.56.10 vm1.test.local vm1' | sudo tee -a /etc/hosts"
    config.vm.provision "shell", inline: "echo '192.168.56.20 vm2.test.local vm2' | sudo tee -a /etc/hosts"
    config.vm.provision "shell", inline: "echo '192.168.56.30 vm3.test.local vm3' | sudo tee -a /etc/hosts"
    node3.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook_vm3.yml"
    end
    node3.vm.network "forwarded_port", guest: 80, host: 8082
  end
end
