#!/bin/bash

PROJECT=${PWD##*/}

if [[ $1 = 'local' ]]; then

    cat ./server/.env.example >> ./kernel/.env
    echo "Don't forget to change your SECRET_KEY"
    echo "https://djecrety.ir/ can help you!"
    cat ./server/config/local_settings.example >> ./server/config/local_settings.py

    exit 0
fi
