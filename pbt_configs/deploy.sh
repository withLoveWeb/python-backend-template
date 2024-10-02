#!/bin/bash

PROJECT=${PWD##*/}

if [[ $1 = 'local' ]]; then

    cp ./server/.env.example ./server/.env
    echo "Don't forget to change your SECRET_KEY"
    echo "https://djecrety.ir/ can help you!"
    cp ./server/config/local_settings.example ./server/config/local_settings.py

    exit 0
fi

if [[ $1 = 'prod' ]]; then

    exit 0
fi
