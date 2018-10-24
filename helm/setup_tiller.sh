#!/bin/bash

echo "Setting up access for Tiller to the whole cluster"
sleep 3

kubectl create -f ./rbac-config.yaml
helm init --upgrade --service-account tiller
