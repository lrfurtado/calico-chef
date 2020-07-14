Vagrant.configure("2") do |config|

  #centos version to be installed on machines
  config.vm.box = "centos/7"
  config.vm.box_version = "1902.01"

  config.vm.define "etcd" do |etcd|
	etcd.vm.network "private_network", ip: "192.168.50.2", auto_config: false
    etcd.vm.provision "chef_solo" do |chef|
       chef.add_recipe "etcd"
       chef.arguments = "--chef-license accept"
    end
  end

  (1..3).each do |i|
    last_octet = 2 + i
    config.vm.define "node#{i}" do |node|
      node.vm.network "private_network", ip: "192.168.50.#{last_octet}", auto_config: false
      node.vm.provision "chef_solo" do |chef|
         chef.add_recipe "calico"
         chef.arguments = "--chef-license accept"
      end
    end
  end

end
