# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "mikrotik.rb"

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end

  config.ssh.insert_key = false

  config.vm.box = "damianog/mikrotik"

  config.vm.define "mikrotik1" do |subconfig|

    subconfig.vm.synced_folder ".", "/vagrant", disabled: true

    subconfig.vm.network "private_network", virtualbox__intnet: "wan", auto_config: false
    subconfig.vm.network "private_network", virtualbox__intnet: "client1", auto_config: false

    subconfig.vm.provider "virtualbox" do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    end

    subconfig.trigger.after :up, :provision, :reload, :resume do |trigger|
      trigger.ruby do |env,machine|
        upload_mikrotik_script(machine, "mikrotik1_provision.rsc", "mikrotik1_provision")
        system "vagrant ssh #{machine.name} -- /system script run mikrotik1_provision"
      end
    end
  end

  config.vm.define "mikrotik2" do |subconfig|

    subconfig.vm.synced_folder ".", "/vagrant", disabled: true

    subconfig.vm.network "private_network", virtualbox__intnet: "wan", auto_config: false
    subconfig.vm.network "private_network", virtualbox__intnet: "client2", auto_config: false

    subconfig.vm.provider "virtualbox" do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
      virtualbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    end
    subconfig.trigger.after :up, :provision, :reload, :resume do |trigger|
      trigger.ruby do |env,machine|
        upload_mikrotik_script(machine, "mikrotik2_provision.rsc", "mikrotik2_provision")
        system "vagrant ssh #{machine.name} -- /system script run mikrotik2_provision"
      end
    end
  end

  config.vm.define "client1" do |subconfig|
    subconfig.vm.box = "geerlingguy/centos7"
    subconfig.vm.hostname = "client1"
    subconfig.vm.network :private_network, ip: "192.168.101.10", virtualbox__intnet: "client1"
  end

  config.vm.define "client2" do |subconfig|
    subconfig.vm.box = "geerlingguy/centos7"
    subconfig.vm.hostname = "client2"
    subconfig.vm.network :private_network, ip: "192.168.101.20", virtualbox__intnet: "client2"
  end

end
