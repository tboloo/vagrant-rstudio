#
# Cookbook Name:: chef/cookbooks/R
# Recipe:: default
#
# Copyright 2014, vault13
#
# All rights reserved - Do Not Redistribute
#

apt_repository "r-base" do
	uri "http://r.meteo.uni.wroc.pl/bin/linux/debian"
	components ["wheezy-cran3/"]
	keyserver "keys.gnupg.net"
	key "381BA480"
end

package 'r-base' do
	options "--no-install-recommends"
	action :install
end

package 'r-base-dev' do
	options "--no-install-recommends"
	action :install
end

#RStudio dependency
package 'gdebi-core' do
	options "--no-install-recommends"
	action :install
end

#RStudio dependency
package 'libapparmor1' do
	options "--no-install-recommends"
	action :install
end

#swirl dependency
package 'libcurl4-openssl-dev' do
	options "--no-install-recommends"
	action :install
end

#RStudio has hard coded dependency on buggy 0.9.8 version
execute 'download libssl-0.9.8' do
	command 'wget -nc http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb'
end

execute 'install libssl-0.9.8' do
	command 'sudo dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb'
end

template "/etc/environment" do
	source 'environment.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

execute 'download RStudio' do
	command 'wget -nc http://download2.rstudio.org/rstudio-server-0.98.1091-amd64.deb'
end

execute 'install RStudio' do
	command 'sudo gdebi rstudio-server-0.98.1091-amd64.deb'
end

template "/etc/rstudio/rserver.conf" do
	source 'rserver.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

user node['rserver']['username'] do
	password node['rserver']['password']
	shell "/bin/bash"
	home "/home/#{node['rserver']['username']}"
	supports :manage_home => true
end

group node['rserver']['group'] do
	action :create
	members node['rserver']['username']
end