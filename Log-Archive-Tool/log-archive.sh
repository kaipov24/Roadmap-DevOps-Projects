#!/bin/bash

log_location=$1

log-archive() {
    echo "Storing logs in $log_location"
    date_and_time=$(date +%F)
    tar -czvf log_archive_"$date_and_time".tar.gz /var/log
    if [ -d "$log_location" ]; then
        echo "$log_location directory exists."
    else
        mkdir "$log_location" 
        echo "Directory created"
    fi
    mv log_archive_"$date_and_time".tar.gz "$log_location"
    ls "$log_location"
}

log-archive