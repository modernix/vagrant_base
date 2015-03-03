# -*- mode: ruby -*-
# vi: set ft=ruby :

IMAGE_Name = ""
MEMSIZE = "2048"
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
  VAGRANTFILE_API_VERSION = "2"
   
  Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "centos-6.6-x86_64"
   config.vm.network "public_network", type: "dhcp", bridge: "eth1" 
config.vm.provider "vmware_fusion" do |v|

        v.vmx["displayName"] = IMAGE_Name
        v.vmx["numvcpus"] = "1"
        v.vmx["memsize"] = MEMSIZE
        v.vmx["numvcpus"] = "1" # set number of vcpus
        v.vmx["hypervisor.cpuid.v0"] = "FALSE"
        v.vmx["mce.enable"] = "TRUE"
        v.vmx["vhv.enable"] = "FALSE" # turn on host hardware virtualization extensions (VT-x|AMD-V)
        v.vmx["guestOS"] = "ubuntu-64" # set guest OS type

        v.vmx["logging"] = "FALSE"
        v.vmx["MemTrimRate"] = "0"
	v.vmx["MemAllowAutoScaleDown"] = "FALSE"
	v.vmx["mainMem.backing"] = "swap"
	v.vmx["sched.mem.pshare.enable"] = "FALSE"
	v.vmx["snapshot.disabled"] = "TRUE"
	v.vmx["isolation.tools.unity.disable"] = "TRUE"
	v.vmx["unity.allowCompostingInGuest"] = "FALSE"
	v.vmx["unity.enableLaunchMenu"] = "FALSE"
	v.vmx["unity.showBadges"] = "FALSE"
	v.vmx["unity.showBorders"] = "FALSE"
	v.vmx["unity.wasCapable"] = "FALSE"
        v.vmx["priority.grabbed"] = "high"
        v.vmx["priority.ungrabbed"] = "high"
        v.vmx["mainmem.backing"] = "swap"
        v.vmx["mainMem.allow8GB"] = "TRUE"
   end

   config.vm.provision "shell" do |s|
          s.path = "base.sh"
   end
end
