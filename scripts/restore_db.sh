db="/home/vagrant/db"
filename="`ls -t ${db} | head -n1`"
pg="/var/lib/docker/volumes/docker_omero_postgres_db/_data"

if ! [ -z "$filename" ]
then
    echo "Restoring $filename"
    rsync -avhW --no-compress "$db/$filename" "/tmp/$filename"
    rm -rfv "$pg/{*,.*}"
    tar -xzvf "/tmp/$filename" -C "$pg"
    rm "/tmp/$filename"
fi
