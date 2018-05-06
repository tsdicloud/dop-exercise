#!/bin/bash
kubectl delete deployment logstash
kubectl exec `kubectl get pods -o name |egrep -o "kibana-[0-9]*-.*"` -- ./clean_demo.sh
