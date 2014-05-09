Vagrant.configure("2") do |config|
  config.vm.box = "centOS6.4_x64"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box"
  config.vm.network :private_network, ip: "192.168.57.107"
  config.vm.provision :chef_solo do |chef|
	chef.run_list = ["mysql::server", "rvm::system_install", "chef-fulcrum"]
	chef.log_level = :info
  end

  config.vm.provider :virtualbox do |vb|
     vb.customize ["modifyvm", :id, "--memory", "3072"]
  end
end
