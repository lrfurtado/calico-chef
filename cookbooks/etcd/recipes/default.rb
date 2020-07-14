
package "etcd" do
	action :install
end

service 'etcd' do
  supports :status => true, :restart => true, :truereload => true
  action [ :enable, :start ]
end
