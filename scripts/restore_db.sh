source /home/vagrant/scripts/utils.sh

tarfile="$(get_most_recent_tarfile "$(get_db_folder)")"

if ! [ -z "$tarfile" ]
then
    echo "Restoring $tarfile"
    echo "Container $(get_container_id)"
    dumpfile="$(get_dumpfile)"
    rsync -avhW --no-compress "$(get_db_folder)/$tarfile" "/tmp/$tarfile"
    tar -xzvf "/tmp/$tarfile" -C "/tmp" "$dumpfile"
    cat "/tmp/$dumpfile" | docker exec -i "$(get_container_id)" psql -h 0.0.0.0 -U postgres
    rm "/tmp/$tarfile"
    rm "/tmp/$dumpfile"
fi
