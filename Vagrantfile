# -*- mode: ruby -*-
# vi: set ft=ruby :

auto = false

# Increase numworkers if you want more than 3 nodes
numworkers = 2

# VirtualBox settings
# Increase vmmemory if you want more than 512mb memory in the vm's
vmmemory = 1536
# Increase numcpu if you want more cpu's per vm
numcpu = 1

instances = []

(1..numworkers).each do |n|
  instances.push({:name => "worker#{n}", :ip => "192.168.10.#{n+2}"})
end

manager_ip = "192.168.10.2"

File.open("./hosts", 'w') { |file|
  instances.each do |i|
    file.write("#{i[:ip]} #{i[:name]} #{i[:name]}\n")
  end
}

ports= [
  9000,
  8889,
  9411,
  9002,
  8761,
  7000
]


Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = vmmemory
    v.cpus = numcpu
  end

  config.vm.define "manager" do |i|
    i.vm.box = "ubuntu/zesty64"
    i.vm.hostname = "manager"
    i.vm.network "private_network", ip: "#{manager_ip}"
    i.vm.provision "shell", path: "./provision.sh"
    i.vm.provision "file", source: "vimrc", destination: ".vimrc"
    i.vm.provision "file", source: "zshrc", destination: ".zshrc"
    i.vm.provision "file", source: "tmux.conf", destination: ".tmux.conf"
    for p in ports
      i.vm.network "forwarded_port", guest: p, host: p
    end

    if File.file?("./hosts")
      i.vm.provision "file", source: "hosts", destination: "/tmp/hosts"
      i.vm.provision "shell", inline: "cat /tmp/hosts >> /etc/hosts", privileged: true
    end
    if auto
      i.vm.provision "shell", inline: "docker swarm init --advertise-addr #{manager_ip}"
      i.vm.provision "shell", inline: "docker swarm join-token -q worker > /vagrant/token"
    end

  end

  instances.each do |instance|
    config.vm.define instance[:name] do |i|
      i.vm.box = "ubuntu/zesty64"
      i.vm.hostname = instance[:name]
      i.vm.network "private_network", ip: "#{instance[:ip]}"
      i.vm.provision "shell", path: "./provision.sh"
      i.vm.provision "file", source: "zshrc", destination: ".zshrc"
      i.vm.provision "file", source: "tmux.conf", destination: ".tmux.conf"

      # for p in ports
        # i.vm.network "forwarded_port", guest: p, host: p
      # end

      if File.file?("./hosts")
        i.vm.provision "file", source: "hosts", destination: "/tmp/hosts"
        i.vm.provision "shell", inline: "cat /tmp/hosts >> /etc/hosts", privileged: true
      end
      if auto
        i.vm.provision "shell", inline: "docker swarm join --advertise-addr #{instance[:ip]} --listen-addr #{instance[:ip]}:2377 --token `cat /vagrant/token` #{manager_ip}:2377"
      end
    end
  end
end
