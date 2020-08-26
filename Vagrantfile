print "omero.server vagrantfile v0.1\n"
Vagrant.configure("2") do |config|
    config.vm.box = "generic/centos7"
    config.vm.define "omero.server" do |omero|
        omero.vm.hostname = "omero.server"
        omero.vm.network "forwarded_port", guest: 4063, host: 4063
        omero.vm.network "forwarded_port", guest: 4064, host: 4064
        omero.vm.network "forwarded_port", guest: 4080, host: 4080
        omero.vm.provider :virtualbox do |v|
            v.name = "omero.server"
            v.gui = false
            v.memory = 1024
            v.cpus = 2
        end
        omero.vm.provision :shell, path: "bootstrap.sh"
        omero.vm.synced_folder "data/", "/home/vagrant/data", type: "virtualbox", automount: true
        omero.vm.synced_folder "db/", "/home/vagrant/db", type: "virtualbox", automount: true
        omero.vm.synced_folder "docker/", "/home/vagrant/docker", type: "virtualbox", automount: true
        omero.vm.synced_folder "scripts/", "/home/vagrant/scripts", type: "virtualbox", automount: true
        omero.trigger.after :up, :reload do |trigger|
            trigger.name = "Startup"
            trigger.run_remote = {path: "startup.sh"}
        end
        omero.trigger.before :halt, :suspend, :reload do |trigger|
            trigger.name = "Shutdown"
            trigger.run_remote = {path: "shutdown.sh"}
        end
        omero.trigger.before :destroy do |trigger|
            trigger.name = "Shutdown (destroy)"
            trigger.run_remote = {path: "shutdown.sh"}
            trigger.on_error = :continue
        end
    end
end