#!/bin/bash

echo "Setting up variables..."
ACCOUNT=$(gcloud info --format='value(config.account)')
NSPACE="monitoring"

echo "You are looged in as: $ACCOUNT"



echo "Creating cluster role binding..."
kubectl create clusterrolebinding owner-cluster-admin-binding --clusterrole cluster-admin --user $ACCOUNT

echo "Creating namespace..."
kubectl create namespace $MONITORING

echo "Creating a role..."
kubectl create -f ./clusterRole.yaml

echo "Creating a config map..."
kubectl create -f ./config-map.yaml -n $NSPACE

echo "Creating Prometheus deployment..."
kubectl create  -f ./prometheus-deployment.yaml --namespace=$NSPACE

echo "Creating Prometheus service..."
kubectl create -f prometheus-service.yaml --namespace=$NSPACE
