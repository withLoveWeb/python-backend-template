#!/bin/bash

./manage.sh makemigrations --no-input
./manage.sh migrate --no-input
# ./manage.sh collectstatic --no-input

gunicorn config.wsgi:application --bind 0.0.0.0:8000
