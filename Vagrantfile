Vagrant.configure("2") do |config|
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.box = 'ubuntu/trusty64'
  config.vm.host_name = 'icinga.example.com'
  config.vm.network "forwarded_port", guest: 443, host: 8443

  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "shell", inline: "apt-get install -y puppet git ruby1.9.1-dev"
  config.vm.provision "shell", inline: "gem install librarian-puppet"
  config.vm.provision "shell", inline: "cd /etc/puppet && librarian-puppet clean --verbose"
  config.vm.provision "shell", inline: "rm -f /etc/puppet/Puppetfile*"
  config.vm.provision "shell", inline: "cp /vagrant/tests/Puppetfile /etc/puppet"
  config.vm.provision "shell", inline: "cd /etc/puppet && librarian-puppet install --verbose"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'tests'
    puppet.manifest_file = 'init.pp'
    puppet.hiera_config_path = "tests/hiera.yaml"
  end
end
