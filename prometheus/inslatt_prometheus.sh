#!/bin/bash

REPO="https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/"
OS="coreos"
HELM_BIN="/usr/local/bin"

$HELM_BIN/helm repo add coreos "$REPO"

$HELM_BIN/helm install --name prometheus-operator --namespace monitoring --set rbacEnable=false coreos/prometheus-operator

echo "###### Checking Operators ######"

kubectl get CustomResourceDefinition

echo "###### Installing Prometheus ######"

helm install --name mon --namespace monitoring -f custom-values.yaml coreos/kube-prometheus

