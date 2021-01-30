#!/bin/bash

pswd=$1

function __fileUploader() {
    for i in ${files[@]}; do
        curl -v -u admin:${pswd} --upload-file ${i} http://192.168.88.2:8081/repository/raw-kube/spec/${i}
    done
}

files=(
    kube-flannel.yml
    nexus.yml
    gitlab.yml
    nginx.yml
    upload.sh
)

__fileUploader