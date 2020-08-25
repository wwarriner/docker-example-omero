# initial prep
yum update -y
yum install -y yum-utils
yum install -y rsync

# setup docker
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker vagrant

systemctl enable docker
systemctl start docker

# setup docker-compose
curl \
    -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# setup scripts
cd /home/vagrant/scripts
chmod a+x backup_db.sh
chmod a+x restore_db.sh

# start
cd /home/vagrant/docker
docker-compose pull
docker-compose up -d
