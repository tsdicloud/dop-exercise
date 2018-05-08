# Open Telekom Cloud - CCE - ELK demo

## Hint 1: Openeing the Kubernetes Dashboard

On the ssh terminal:
```
kubectl proxy --port=81XX &
```

In the browser
```
http://localhost:81XX/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

## Hint 2: Opening Kibana on external loadbalancer

Remember to set the corresponding port in `kub-kibana-service.yaml`
```
http://80.158.6.109:84XX
```

