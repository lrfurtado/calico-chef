Vagrant.configure("2") do |config|

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest= true

  #centos version to be installed on machines
  config.vm.box = "centos/7"
  config.vm.box_version = "1902.01"
  config.vm.provider "virtualbox" do |v|
	v.customize ["modifyvm", :id, "--natnet1", "192.168.66.0/24"]
  end

  config.vm.define "etcd" do |etcd|
    etcd.vm.hostname = "etcd"
	etcd.vm.network "private_network", ip: "192.168.50.2", virtualbox__intnet: true
    etcd.vm.provision "chef_solo" do |chef|
       chef.add_recipe "etcd"
       chef.arguments = "--chef-license accept"
    end
  end

  (1..3).each do |i|
    last_octet = 2 + i
    config.vm.define "node#{i}" do |node|
      node.vm.hostname = "node#{i}"
      node.vm.network "private_network", ip: "192.168.50.#{last_octet}", virtualbox__intnet: true
      node.vm.provision "chef_solo" do |chef|
         chef.add_recipe "calico"
         chef.arguments = "--chef-license accept"
      end
    end
  end

end
