#!/bin/bash
# checking commits of nodes
filename=$(kubectl get pods --output name | grep unomi-master | head -1)
filename2=$(kubectl get pods --output name | grep unomi-slaver | head -1)
filename3=$(kubectl get pods --output name | grep unomi-api | head -1)
echo $filename
echo $filename2
echo $filename3
kubectl describe $filename | grep Image:
kubectl describe $filename2 | grep Image:
kubectl describe $filename3 | grep Image:
