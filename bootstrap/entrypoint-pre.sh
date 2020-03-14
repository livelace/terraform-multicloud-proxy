#!/usr/bin/env bash

if [[ "$UID" = 0 ]];then
    echo "ERROR: UID is not set! You must provide your UID for proper permissions settings."
    exit 1
fi

useradd -d "/data" -u "$UID" "user"

mkdir -p "/conf" "/data" && chown "user:user" "/conf" "/data" >/dev/null 2>&1
chown "user" "/dev/kvm" >dev/null 2>&1 || true

su user -s /bin/bash -c "/entrypoint.sh $1 $2"
