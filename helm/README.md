# Helm charts 


## App deployment

The below command deploys the app to EKS cluster

```shell
$ kubectl create namespace pyapp
$ helm install pyapp helm/pyapp/ -n pyapp
```
Deployed Application can be accessed with [http://app.hossanrose.com](http://app.hossanrose.com)

## Prometheus deployment

Prometheus with ALB ingress

```shell
$ kubectl create namespace prometheus
$ helm install  prometheus stable/prometheus -f prometheus/prometheus.yaml -n prometheus
```

Prometheus can be accessed with [http://prometheus.hossanrose.com](http://prometheus.hossanrose.com)
