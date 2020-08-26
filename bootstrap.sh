# initial prep
yum update -y
yum install -y yum-utils
yum install -y rsync
yum install -y pcre-tools

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

# setup db backup service
tempfile=$(mktemp)
crontab -l > $tempfile
echo "00 0,3,6,9,12,15,18,21 * * * /home/vagrant/scripts/backup_db.sh" >> $tempfile # backups every 3 hours
crontab $tempfile
crontab -l
rm $tempfile

# start
cd /home/vagrant/docker
docker-compose pull
docker-compose up -d
