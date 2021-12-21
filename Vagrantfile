# -*- mode: ruby -*-
# vi: set ft=ruby :

load "config.rb"

Vagrant.configure("2") do |config|
	config.ssh.insert_key = false
    config.vm.box_check_update = false
    config.vm.synced_folder '.', '/vagrant', disabled: true
    config.vm.provision :file, source: '.', destination: '$HOME/'

    config.vm.provider :libvirt do |lv|
    	lv.management_network_name = 'mgmt'
	    lv.management_network_address = '192.168.121.0/24'
	    lv.management_network_mode = 'nat'
	
		lv.default_prefix = ""
        lv.graphics_type = "none"
    end

    $groups['cluster'].each_with_index do |node,i|
		config.vm.define node do |srv|
			srv.vm.box = "aesirteam/proxmox-ve-amd64"
  			srv.vm.box_version = "6.4"

  			ip = "10.10.10.#{i+10}"
			srv.vm.network :private_network,
				ip: ip,
				auto_config: false,
				libvirt__network_name: 'pve_network',
				libvirt__dhcp_enabled: false,
				libvirt__forward_mode: 'none'

			ip1 = "10.20.20.#{i+10}"
			srv.vm.network :private_network,
				ip: ip1,
				auto_config: false,
				libvirt__network_name: 'ceph_network',
				libvirt__dhcp_enabled: false,
				libvirt__forward_mode: 'none'

			srv.vm.provider :libvirt do |lv|
				lv.memory = $cluster_vars[:ram]
				lv.cpus = $cluster_vars[:vcpu]
		    	lv.cpu_mode = 'host-passthrough'
		    	lv.nested = true
		    	lv.keymap = 'pt'
		    	lv.machine_virtual_size = 20

		    	lv.storage :file, :size => $cluster_vars[:storage], :path => "#{node}_disk.img", :type => 'qcow2', :cache => 'none'
			end

			srv.vm.provision :shell, path: 'prepare.sh', args: node
			srv.vm.provision :shell, path: 'provision.sh', args: [ip, ip1]
			srv.vm.provision :shell, path: 'provision-pveproxy-certificate.sh', args: ip
  			srv.vm.provision :shell, path: 'summary.sh', args: ip
		end
    end

    $groups['storage'].each_with_index do |node,i|
    	config.vm.define node do |srv|
    		srv.vm.box = "centos/7"
    		
    		ip = "10.20.20.#{i+80}"
    		srv.vm.network :private_network,
    			ip: ip,
				auto_config: false,
				libvirt__network_name: 'ceph_network',
				libvirt__dhcp_enabled: false,
				libvirt__forward_mode: 'none'

			srv.vm.provider :libvirt do |lv|
				lv.memory = $storage_vars[:ram]
				lv.cpus = $storage_vars[:vcpu]
		    	lv.cpu_mode = 'host-passthrough'
		    	lv.nested = true
		    	lv.keymap = 'pt'
		    	lv.machine_virtual_size = 8

		    	lv.storage :file, :size => $storage_vars[:storage], :path => "#{node}_disk.img", :type => 'qcow2', :cache => 'none'
			end
			
			srv.vm.provision :shell, path: 'provision-target.sh', args: ip
    	end
    end

    config.group.groups = $groups
end