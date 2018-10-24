#!/bin/bash

PROJECT="k8s-gcp-project"
CL_VERSION="1.10.7-gke.6"
VM_TYPE="f1-micro"
IMG="COS"
DISC_SIZE="50"
NUM_NODES="1"
MIN_NODES="1"
MAX_NODES="3"


gcloud beta container --project "k8s-gcp-project" clusters create "kubernetes-dev-cluster" --region "europe-north1" --username "admin" --cluster-version "1.10.7-gke.6" --machine-type "f1-micro" --image-type "COS" --disk-type "pd-standard" --disk-size "50" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --preemptible --num-nodes "1" --enable-cloud-logging --enable-cloud-monitoring --network "projects/k8s-gcp-project/global/networks/default" --subnetwork "projects/k8s-gcp-project/regions/europe-north1/subnetworks/default" --enable-autoscaling --min-nodes "1" --max-nodes "3" --addons HorizontalPodAutoscaling,HttpLoadBalancing,KubernetesDashboard --enable-autoupgrade --enable-autorepair
