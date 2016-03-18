# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox"
  config.vm.provider "vmware_fusion"
  config.vm.box = "dockpack/centos7"
  config.vm.box_url = "https://atlas.hashicorp.com/dockpack/boxes/centos7"
  config.vm.box_check_update = true
  config.ssh.forward_agent = false
  config.ssh.insert_key = false

  # Timeouts
  config.vm.boot_timeout = 900
  config.vm.graceful_halt_timeout=100

  config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "inventory.ini"
    ansible.playbook = "provision.yml"
    ansible.verbose = "vv"
    ansible.host_key_checking = "false"
  end

  config.vm.define :control,  primary: true do |control_config|
    control_config.vm.network "private_network", ip: "192.168.30.20", :netmask => "255.255.255.0",  auto_config: true
    control_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2222, auto_correct: true
    control_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--natnet1", "172.16.1/24"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"  ]
      vb.name = "control"
      vb.gui = false
    end
  end

  config.vm.define :target, autostart: true do |target_config|
    target_config.vm.network "private_network", ip: "192.168.30.22", :netmask => "255.255.255.0",  auto_config: true
    target_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2223, auto_correct: true
    target_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "target"
    end
  end

end
