include_recipe 'apt'

apt_repository "r-base" do
	uri "http://cran.rstudio.com/bin/linux/debian/"
	components ["wheezy-cran3/"]
	key "jranke.asc"
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

#swirl dependency
package 'libcurl4-openssl-dev' do
	options "--no-install-recommends"
	action :install
end

#RStudio has hard coded dependency on buggy 0.9.8 version
execute 'download libssl-0.9.8' do
	command 'wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb'
end

execute 'install libssl-0.9.8' do
	command 'dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb'
end

line = 'export LC_ALL=en_US.UTF-8'

file = Chef::Util::FileEdit.new('/etc/profile')
file.insert_line_if_no_match(/#{line}/, line)
file.write_file

template "/etc/environment" do
	source 'environment.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

bash 'source /etc/profile' do
	command 'source /etc/profile'
	action :run
end

execute 'download RStudio' do
	command 'wget -nc http://download2.rstudio.org/rstudio-server-0.98.1091-amd64.deb'
end

execute 'install RStudio' do
	environment "LC_ALL" => "en_US.UTF-8"
	command 'gdebi -n rstudio-server-0.98.1091-amd64.deb'
end