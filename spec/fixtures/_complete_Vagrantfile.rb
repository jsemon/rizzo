# This file generated with Rizzo 0.1.0 on 2017-08-18 13:00:09 -0700
# https://github.com/ghoneycutt/rizzo
Vagrant.configure(2) do |config|
  # use 'vagrant plugin install vagrant-proxyconf' to install
  if Vagrant.has_plugin?('vagrant-proxyconf')
    config.proxy.http  = ENV['HTTP_PROXY']  if ENV['HTTP_PROXY']
    config.proxy.https = ENV['HTTPS_PROXY'] if ENV['HTTPS_PROXY']
  end

  config.vm.define "puppetca", autostart: false do |cfg|
    cfg.vm.box = "el6-rc5"
    cfg.vm.box_url = "https://artifactory.acme.net/artifactory/infra-vagrant-local/centos-6-x86-64-acme-2017-06-14t13-27-20-0400.box"
    cfg.vm.box_download_checksum = "37f67caf1038992207555513504e37258c29e2e9"
    cfg.vm.box_download_checksum_type = "sha1"
    cfg.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', "2048"]
    end
    cfg.vm.hostname = "puppetca.acme.com"
    cfg.vm.network 'private_network',
      ip: "172.16.100.5",
      netmask: "255.255.255.0"
    cfg.vm.network 'forwarded_port',
      guest: "8140",
      host: "8140"
    cfg.vm.synced_folder "/Users/jeff/projects/acme/puppetdata", "/repos/puppetdata",
      owner: "root", group: "root"
    cfg.vm.synced_folder "/Users/jeff/projects/acme/ghoneycutt-modules", "/repos/ghoneycutt",
      owner: "root", group: "root"
    config.vm.synced_folder "/Users/jeff/projects/acme/bootstrap",
      "/tmp/bootstrap_puppet4",
      owner: 'vagrant', group: 'root'
    config.vm.provision 'shell', inline: "echo 'modulepath = ./modules:./puppetdata/modules:./ghoneycutt/modules' > /tmp/bootstrap_puppet4/environment.conf"
    config.vm.provision 'shell', inline: "/bin/bash /tmp/bootstrap_puppet4/bootstrap_puppet4.sh -l -f `hostname -f`"
    config.vm.provision 'shell', inline: "yum -y update"
    config.vm.provision 'shell', inline: "/sbin/shutdown -h now"
  end

  config.vm.define "puppet", autostart: false do |cfg|
    cfg.vm.box = "el6-rc5"
    cfg.vm.box_url = "https://artifactory.acme.net/artifactory/infra-vagrant-local/centos-6-x86-64-acme-2017-06-14t13-27-20-0400.box"
    cfg.vm.box_download_checksum = "37f67caf1038992207555513504e37258c29e2e9"
    cfg.vm.box_download_checksum_type = "sha1"
    cfg.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', "2048"]
    end
    cfg.vm.hostname = "puppet.acme.com"
    cfg.vm.network 'private_network',
      ip: "172.16.100.6",
      netmask: "255.255.255.0"
    cfg.vm.synced_folder "/Users/jeff/projects/acme/puppetdata", "/repos/puppetdata",
      owner: "root", group: "root"
    cfg.vm.synced_folder "/Users/jeff/projects/acme/ghoneycutt-modules", "/repos/ghoneycutt",
      owner: "root", group: "root"
    config.vm.synced_folder "/Users/jeff/projects/acme/bootstrap",
      "/tmp/bootstrap_puppet4",
      owner: 'vagrant', group: 'root'
    config.vm.provision 'shell', inline: "echo 'modulepath = ./modules:./puppetdata/modules:./ghoneycutt/modules' > /tmp/bootstrap_puppet4/environment.conf"
    config.vm.provision 'shell', inline: "/bin/bash /tmp/bootstrap_puppet4/bootstrap_puppet4.sh -l -f `hostname -f`"
    config.vm.provision 'shell', inline: "yum -y update"
    config.vm.provision 'shell', inline: "/sbin/shutdown -h now"
  end

  config.vm.define "dns", autostart: false do |cfg|
    cfg.vm.box = "el6-rc5"
    cfg.vm.box_url = "https://artifactory.acme.net/artifactory/infra-vagrant-local/centos-6-x86-64-acme-2017-06-14t13-27-20-0400.box"
    cfg.vm.box_download_checksum = "37f67caf1038992207555513504e37258c29e2e9"
    cfg.vm.box_download_checksum_type = "sha1"
    cfg.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', "1024"]
    end
    cfg.vm.hostname = "dns.acme.com"
    cfg.vm.network 'private_network',
      ip: "172.16.100.8",
      netmask: "255.255.255.0"
    config.vm.synced_folder "/Users/jeff/projects/acme/bootstrap",
      "/tmp/bootstrap_puppet4",
      owner: 'vagrant', group: 'root'
    config.vm.provision 'shell', inline: "/bin/bash /tmp/bootstrap_puppet4/bootstrap_puppet4.sh -l -f `hostname -f`"
    config.vm.provision 'shell', inline: "yum -y update"
    config.vm.provision 'shell', inline: "/sbin/shutdown -h now"
  end

  config.vm.define "logs", autostart: false do |cfg|
    cfg.vm.box = "el6-rc5"
    cfg.vm.box_url = "https://artifactory.acme.net/artifactory/infra-vagrant-local/centos-6-x86-64-acme-2017-06-14t13-27-20-0400.box"
    cfg.vm.box_download_checksum = "37f67caf1038992207555513504e37258c29e2e9"
    cfg.vm.box_download_checksum_type = "sha1"
    cfg.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', "1024"]
    end
    cfg.vm.hostname = "logs.acme.com"
    cfg.vm.network 'private_network',
      ip: "172.16.100.12",
      netmask: "255.255.255.0"
    config.vm.synced_folder "/Users/jeff/projects/acme/bootstrap",
      "/tmp/bootstrap_puppet4",
      owner: 'vagrant', group: 'root'
    config.vm.provision 'shell', inline: "/bin/bash /tmp/bootstrap_puppet4/bootstrap_puppet4.sh -l -f `hostname -f`"
    config.vm.provision 'shell', inline: "yum -y update"
    config.vm.provision 'shell', inline: "/sbin/shutdown -h now"
  end

  config.vm.define "mail", autostart: false do |cfg|
    cfg.vm.box = "el6-rc5"
    cfg.vm.box_url = "https://artifactory.acme.net/artifactory/infra-vagrant-local/centos-6-x86-64-acme-2017-06-14t13-27-20-0400.box"
    cfg.vm.box_download_checksum = "37f67caf1038992207555513504e37258c29e2e9"
    cfg.vm.box_download_checksum_type = "sha1"
    cfg.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', "1024"]
    end
    cfg.vm.hostname = "mail.acme.com"
    cfg.vm.network 'private_network',
      ip: "172.16.100.13",
      netmask: "255.255.255.0"
    config.vm.synced_folder "/Users/jeff/projects/acme/bootstrap",
      "/tmp/bootstrap_puppet4",
      owner: 'vagrant', group: 'root'
    config.vm.provision 'shell', inline: "/bin/bash /tmp/bootstrap_puppet4/bootstrap_puppet4.sh -l -f `hostname -f`"
    config.vm.provision 'shell', inline: "yum -y update"
    config.vm.provision 'shell', inline: "/sbin/shutdown -h now"
  end

  config.vm.define "jumpbox", autostart: false do |cfg|
    cfg.vm.box = "el6-rc5"
    cfg.vm.box_url = "https://artifactory.acme.net/artifactory/infra-vagrant-local/centos-6-x86-64-acme-2017-06-14t13-27-20-0400.box"
    cfg.vm.box_download_checksum = "37f67caf1038992207555513504e37258c29e2e9"
    cfg.vm.box_download_checksum_type = "sha1"
    cfg.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', "1024"]
    end
    cfg.vm.hostname = "jumpbox.acme.com"
    cfg.vm.network 'private_network',
      ip: "172.16.100.26",
      netmask: "255.255.255.0"
    config.vm.synced_folder "/Users/jeff/projects/acme/bootstrap",
      "/tmp/bootstrap_puppet4",
      owner: 'vagrant', group: 'root'
    config.vm.provision 'shell', inline: "/bin/bash /tmp/bootstrap_puppet4/bootstrap_puppet4.sh -l -f `hostname -f`"
    config.vm.provision 'shell', inline: "yum -y update"
    config.vm.provision 'shell', inline: "/sbin/shutdown -h now"
  end
end
# -*- mode: ruby -*-
# vim:ft=ruby
