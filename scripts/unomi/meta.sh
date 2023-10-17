#!/bin/bash
filename=$(kubectl get pods --output name | grep meta-router | head -1)
sc="kubectl logs  $filename"
eval $sc