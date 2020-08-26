source /home/vagrant/scripts/utils.sh

tarfile="$(get_tarfile)"
dumpfile="$(get_dumpfile)"

echo "Dumping $tarfile"
echo "Container $(get_container_id)"
docker exec -t "$(get_container_id)" pg_dumpall -h 0.0.0.0 -c -U postgres > "/tmp/$dumpfile"
tar -czvf "/tmp/$tarfile" -C "/tmp" "$dumpfile"
rsync -avhW --no-compress "/tmp/$tarfile" "$(get_db_folder)/$tarfile"
rm "/tmp/$tarfile"
rm "/tmp/$dumpfile"
