#!/usr/bin/env bash

pass_files=("data/lldap/secrets/LLDAP_JWT_SECRET" \
            "data/lldap/secrets/LLDAP_PASSWORD" \
            "data/authelia/secrets/AUTHELIA_JWT_SECRET" \
            "data/authelia/secrets/SESSION_SECRET" \
            "data/authelia/secrets/STORAGE_ENCRYPTION_KEY" \
            "data/authelia/secrets/STORAGE_PASSWORD" \
            "data/casbin/secrets/CASBIN_STORAGE_PASSWORD" \
           )

for file in ${pass_files[@]}
do
    echo Generating $file
    tr -cd '[:alnum:]' < /dev/urandom | fold -w "64" | head -n 1 > $file
done
