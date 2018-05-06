#/bin/bash

#########################################
## Configure namespaces and dasjboard for
## cluster
##
## kubectl must be working!

# INstall dashboard
kubectl create -f kubernetes-dashboard-cluster-role.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.7.1/src/deploy/recommended/kubernetes-dashboard.yaml

# Create namespaces
for id in {01..15}
do
    kubectl create namespace dop$id
done

