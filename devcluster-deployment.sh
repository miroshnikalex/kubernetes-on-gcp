#!/bin/bash

PROJECT="k8s-gcp-project"
CL_NAME="kubernetes-dev-cluster"
REGION="europe-north1"
NETWORK="gke-network"
SUBNET="gke-network"
ADM_NAME="admin"
CL_VERSION="1.9.7-gke.11"
VM_TYPE="n1-standard-1"
VM_IMG="COS"
DISC_SIZE="100"
NUM_NODES="1"
MIN_NODES="1"
MAX_NODES="3"
NM_LIMITS="limits"
NM_LIMITLESS="limitless"
NM_MONITORING="monitoring"

gcloud beta container --project "$PROJECT" clusters create "$CL_NAME" --region "$REGION" --username "$ADM_NAME" --cluster-version "$CL_VERSION" --machine-type "$VM_TYPE" --image-type "$VM_IMG" --disk-type "pd-standard" --disk-size "$DISC_SIZE" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --preemptible --num-nodes "$NUM_NODES" --enable-cloud-logging --enable-cloud-monitoring --network "projects/$PROJECT/global/networks/$NETWORK" --subnetwork "projects/$PROJECT/regions/$REGION/subnetworks/$SUBNET" --enable-autoscaling --min-nodes "$MIN_NODES" --max-nodes "$MAX_NODES" --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair --enable-ip-alias --metadata disable-legacy-endpoints=true --enable-network-policy 

echo "###### Configuring the Cluster ######"

echo "Creating namespaces for cluster $CLUSTERNAME"
kubectl create namespace $NM_LIMITS
kubectl create namespace $NM_LIMITLESS
kubectl create namespace $NM_MONITORING

echo "Applying quotas to the namespace $NM_LIMITS"
kubectl apply --namespace=limits -f ./nm-quotas.yaml
