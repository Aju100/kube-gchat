#!/bin/sh

printf "\\n********* Installing packages from external-scripts.json *********\\n"
npm install --save $(jq -r '.[]' ./external-scripts.json | paste -sd" " -)

bin/kube-gchat "$@"

export GOOGLE_APPLICATION_CREDENTIALS='/kube/hangout-hubot.json'
