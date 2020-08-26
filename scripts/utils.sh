get_container_id () {
    echo "$(docker ps | pcregrep -o1 "^(.*?) .*? postgres:12.4 .*?$")"
}

get_dumpfile () {
    echo "omero_db_dumpfile.sql"
}

get_tarfile () {
    date="`date +"%Y%m%d-%H%M%S"`"
    echo "db-"$date".tar.gz"
}

get_most_recent_tarfile () {
    echo "`ls -t "$1" | head -n1`"
}

get_db_folder () {
    echo "/home/vagrant/db"
}