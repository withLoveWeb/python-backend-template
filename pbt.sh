#!/bin/bash

# fork from https://github.com/lyaguxafrog/python-backend-devcontainer
#

help() {
    echo "Welcome to Python Backend Templates!
Usage:
$ pdt [COMMAND] [OPTION]"

    echo "Commands:"
    echo " template   Use the repository as a template"
    echo " --help          Show this help message and exit"

    echo "Options:"
    echo " -h, --help      Show this help message and exit"
}

template_drf() {

    # delete pbt files
    rm -rf django-template-gql
    rm -rf flask-template
    rm -rf README.md
    rm -rf LICENSE
    rm -rf docs
    rm -rf .github

    mv django-template-drf/* server

    read -p "Project name: " pr_name

    cat pbt_configs/django_drf_readme.md > README.md
    sed -i "s/projectname/$pr_name/g" README.md

    cp pbt_configs/containers/Dockerfile server/Dockerfile
    cp pbt_configs/containers/docker-compose.yml docker-compose.yml
    cp pbt_configs/django-entrypoint.sh server/entrypoint.sh

    cp pbt_configs/deploy.sh deploy.sh

    rm -rf pbt_configs

    xdg-open https://github.com/lyaguxafrog/python-backend-devcontainers/blob/release/docs/DJANGO_DRF.md
}

template_gql() {

    # delete pbt files
    rm -rf django-template-drf
    rm -rf flask-template
    rm -rf README.md
    rm -rf LICENSE
    rm -rf docs
    rm -rf .github

    mv django-template-gql server 
    mkdir client
    mkdir docs

    read -p "Project name: " pr_name

    cat pbt_configs/django_gql_readme.md > README.md
    sed -i "s/projectname/$pr_name/g" README.md

    read -p "Add Django to container? [y/n] " ans
    if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
      cp pbt_configs/containers/Dockerfile-django server/Dockerfile
      cp pbt_configs/containers/docker-compose-db-django.yml server/docker-compose.yml
    else
      cp pbt_configs/containers/docker-compose-db.yml server/docker-compose.yml
    fi

    cp pbt_configs/containers/Dockerfile.prod Dockerfile.prod
    cp pbt_configs/containers/docker-compose.prod.yml docker-compose.prod.yml

    cp pbt_configs/containers/Dockerfile.prod Dockerfile.prod
    cp pbt_configs/containers/docker-compose.prod.yml docker-compose.prod.yml

    cp pbt_configs/containers/entrypoint.sh server/entrypoint.sh
    cp pbt_configs/deploy.sh deploy.sh
    chmod 755 deploy.sh

    rm -rf pbt_configs

}

as_template() {
    echo "Select template:"
    echo "[1] Django + DRF"
    echo "[2] Django + Graphene"
    read -p "> " template_choice

    case "$template_choice" in
        1)
            echo "Django + DRF"
            template_drf
            rm -rf pbt.sh
            ;;
        2)
            echo "Django + Graphene"
            template_gql
            rm -rf pbt.sh
            ;;
        *)
            echo "Aborted..."
            exit 1
            ;;
    esac
}

case "$1" in
    --as-template)
        as_template
        ;;
    *)
        help
        ;;
esac
