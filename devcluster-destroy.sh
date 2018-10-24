#!/bin/bash

ZONE="europe-north1"
CL_NAME="kubernetes-dev-cluster"

echo "Destroying Dev Cluster: $CL_NAME ..."
gcloud container clusters delete $CL_NAME -z $ZONE


