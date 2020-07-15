
package "etcd" do
	action :install
end

template '/etc/etcd/etcd.conf' do
  source 'etcd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[etcd]'
end

service 'etcd' do
  supports :status => true, :restart => true, :truereload => true
  action [ :enable, :start ]
end
