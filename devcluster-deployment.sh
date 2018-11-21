#!/bin/bash

PROJECT="k8s-gcp-project"
CL_NAME="kubernetes-dev-cluster"
REGION="europe-north1"
ADM_NAME="admin"
CL_VERSION="1.9.7-gke.11"
VM_TYPE="g1-small"
VM_IMG="COS"
DISC_SIZE="50"
NUM_NODES="1"
MIN_NODES="1"
MAX_NODES="3"
NM_LIMITS="limits"
NM_LIMITLESS="limitless"
NM_MONITORING="monitoring"

gcloud beta container --project "$PROJECT" clusters create "$CL_NAME" --region "$REGION" --username "$ADM_NAME" --cluster-version "$CL_VERSION" --machine-type "$VM_TYPE" --image-type "$VM_IMG" --disk-type "pd-standard" --disk-size "$DISC_SIZE" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --preemptible --num-nodes "$NUM_NODES" --enable-cloud-logging --enable-cloud-monitoring --network "projects/k8s-gcp-project/global/networks/default" --subnetwork "projects/k8s-gcp-project/regions/europe-north1/subnetworks/default" --enable-autoscaling --min-nodes "$MIN_NODES" --max-nodes "$MAX_NODES" --addons HorizontalPodAutoscaling,HttpLoadBalancing,KubernetesDashboard --enable-autoupgrade --enable-autorepair

echo "###### Confoguring the Cluster ######"

echo "Creating namespaces for cluster $CLUSTERNAME"
kubectl create namespace $NM_LIMITS
kubectl create namespace $NM_LIMITLESS
kubectl create namespace $NM_MONITORING

echo "Applying quotas to the namespace $NM_LIMITS"
kubectl apply --namespace=limits -f ./nm-quotas.yaml
