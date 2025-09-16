#!/bin/bash

technology="kubernetes"
environment="lab"

if ls environments/$technology/$environment/projects/*.yml &>/dev/null; then
    for file in environments/$technology/$environment/projects/*.yml; do
        echo "Project: Applying $file"
        conjur policy replace -f $file -b environments/$technology/$environment/projects
    done
fi
