#!/bin/bash

TILLER_NAMESAPCE="public"

kubectl create namespace $TILLER_NAMESPACE
kubectl create serviceaccount tiller --namespace $TILLER_NAMESPACE
kubectl create -f ./rbac-config-limited.yaml
kubectl create -f ./rolebinding-limited.yaml
helm init --service-account tiller --tiller-namespace $TILLER_NAMESPACE --upgrade
