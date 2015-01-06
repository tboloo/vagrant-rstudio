#
# Cookbook Name:: chef/cookbooks/R
# Recipe:: default
#
# Copyright 2014, vault13
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'

case node["platform"]
when "debian"
	include_recipe "R::debian" 
when "ubuntu"
	include_recipe "R::ubuntu"
else 
	raise Chef::Exceptions::RecipeNotFound, "Could not find recipe for platform #{node["platform"]}"
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

execute 'git config user' do
	cwd "/home/vagrant"                                                           
	user "vagrant"
	environment ({
		'HOME' => "/home/vagrant"
		})
	command "git config --global user.name #{node[:git][:username]}"
	action :run
end

execute 'git config email' do
	cwd "/home/vagrant"                                                           
	user "vagrant"
	environment ({
		'HOME' => "/home/vagrant"
		})
	command "git config --global user.email #{node[:git][:email]}"
	action :run
end

execute 'generate ssh keys for github' do
	cwd "/home/vagrant"                                                           
	user "vagrant"
	environment ({
		'HOME' => "/home/vagrant"
		})
	command "ssh-keygen -f $HOME/.ssh/github.rsa -t rsa -N ''"
	action :run
end

execute 'copy public key to shared folder' do
	cwd "/home/vagrant"                                                           
	user "vagrant"
	environment ({
		'HOME' => "/home/vagrant"
		})
	command "cp -n $HOME/.ssh/github.rsa.pub /vagrant"
	action :run
end