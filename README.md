vagrant-rstudio
===============

Vagrant based environment propelled by chef-solo which gives you working RStudio server environment.

RStudio server setup with VirtualBox

1. Install VirtualBox from https://www.virtualbox.org/wiki/Downloads
2. Install Vagrant from https://www.vagrantup.com/downloads.html
3. Install chef development kit https://downloads.chef.io/chef-dk/
4. Install Vagrant plugin vbguest https://github.com/dotless-de/vagrant-vbguest

	```
	vagrant plugin install vagrant-vbguest
	```
5. Install Vagrant plugin berks https://github.com/berkshelf/vagrant-berkshelf

	```
	vagrant plugin install vagrant-berkshelf
	```
6. Clone this repository `git clone https://github.com/tboloo/vagrant-rstudio`
7. Adjust username and email in vagrant-rstudio/chef/cookbooks/R/attributes/default.rb to mathc yours

	```
	default['git']['username'] = ‘ruser’ #put your name here
	default['git']['email'] = ‘ruser@email.com’ # put your email here
	```
8. Run `vagrant up` in the directory where the cloned files are
9. If there are any issues during the provisionining process run `vagrant reload` and `vagrant provision`
10. Browse to http://172.16.33.10/ and enjoy working RStudio using default credentials 

	```
	login: ruser
	password: ruser
	```
	To change RStudio server address update Vagrant file and change `config.vm.network "private_network", ip: "172.16.33.10"` to some other address, and issue `vagrant reload`
11. Setup GitHub account, and configure it in RStudio
	1. Open RStudio page at http://172.16.33.10/ and log in
	2. Go to Tools -> Global Options -> Git/SVN and select `View public key`
	3. Copy contents and add it to your GitHub SSH keys
	4. Setup project with git versioning control https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN
	5. Open Git->Shell and run git push -u origin master (which will create link between local repository and github one)
Enjoy!