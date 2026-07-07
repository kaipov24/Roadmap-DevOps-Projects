#!/bin/bash

log_file="./nginx-access.log"

top_ip_address() {
    echo "Top 5 IP addresses with the most requests:"
    cat $log_file \
    | sort \
    | awk '{print $1}' \
    | uniq -c \
    | awk '{printf "%s - %d requests\n", $2, $1}' \
    | sort -k 3nr \
    | head -5
    printf "\n"
}

top_requested_paths() {
    echo "Top 5 most requested paths:"
    awk -F'"' '{split($2, req, " "); print req[2]}' "$log_file" \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -5 \
    | awk '{printf "%s - %d requests\n", $2, $1}'
    printf "\n"
}

top_response_status_code() {
    echo "Top 5 response status codes:" 
    awk -F'"' '{split($3, status, " "); print status[1]}' "$log_file" \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -5 \
    | awk '{printf "%s - %d requests\n", $2, $1}'
    printf "\n"
}

top_ip_address
top_requested_paths
top_response_status_code