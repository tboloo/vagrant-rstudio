#
# Cookbook Name:: chef/cookbooks/R
# Recipe:: default
#
# Copyright 2014, vault13
#
# All rights reserved - Do Not Redistribute
#

case node["platform"]
when "debian"
  include_recipe "R::debian"
else 
  raise Chef::Exceptions::RecipeNotFound, "Could not find recipe for platform #{node["platform"]}"
end

template "/etc/environment" do
	source 'environment.erb'
	owner 'root'
	group 'root'
	mode '0644'
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