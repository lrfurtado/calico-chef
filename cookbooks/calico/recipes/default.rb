
package "etcd" do
	action :install
end

remote_file '/usr/bin/calicoctl' do
  source 'https://github.com/projectcalico/calicoctl/releases/download/v3.15.1/calicoctl'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if 'test -f /usr/bin/calicoctl'
end

template '/etc/yum.repos.d/calico.repo' do
  source 'calico.repo.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

package "calico-felix" do
	action :install
end

service 'calico-felix' do
  supports :status => true, :restart => true, :truereload => true
  action [ :enable, :start ]
end

template '/etc/calico/node.yaml' do
  source 'node.yaml.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/calico/calicoctl.cfg' do
  source 'calicoctl.cfg.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/calico/felix.cfg' do
  source 'felix.cfg.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'load_calico_cfg' do
  code '/usr/bin/calicoctl create -f /etc/calico/node.yaml && touch /root/calico_loaded'
  not_if 'test -f /root/calico_loaded'
end


