db="/home/vagrant/db"
date="`date +"%Y%m%d-%H%M%S"`"
filename="db-$date.tar.gz"
pg="/var/lib/docker/volumes/docker_omero_postgres_db/_data/"

tar -czvf "/tmp/$filename" -C "$pg" .
rsync -avhW --no-compress "/tmp/$filename" "$db/$filename"
rm "/tmp/$filename"
