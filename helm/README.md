# Helm charts 

Helm chart for application and values for Prometheus

## App deployment

The below command deploys the app to EKS cluster

```shell
$ kubectl create namespace pyapp
$ helm install pyapp pyapp/ -n pyapp
```
Deployed Application can be accessed with [http://app.hossanrose.com](http://app.hossanrose.com)

### Automated deployment
Application will be autodeployed when triggered by build|push workflow or on any change in pyapp directory. 
The [Deploy]((../.github/workflows/deploy.yml) workflow is used for auto deployment

## Prometheus deployment

Prometheus with ALB ingress

```shell
$ kubectl create namespace prometheus
$ helm install  prometheus stable/prometheus -f prometheus/prometheus.yaml -n prometheus
```

Prometheus can be accessed with [http://prometheus.hossanrose.com](http://prometheus.hossanrose.com)

### Configuration

#### Metrics exporting
Metrics from the application is exported and exposed to prometheus by configuring the service with below annotations

```yaml
metadata:
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/path: /metrics
    prometheus.io/port: "80"
spec:
...
```
#### Prometheus targets
Prometheus is preconfigured with below scraping configuration to scrape exposed metrics.

```yaml
...
- job_name: kubernetes-service-endpoints
  honor_timestamps: true
  scrape_interval: 1m
  scrape_timeout: 10s
  metrics_path: /metrics
  scheme: http
  kubernetes_sd_configs:
  - role: endpoints
  relabel_configs:
  - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
    separator: ;
    regex: "true"
    replacement: $1
    action: keep
  - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
    separator: ;
    regex: (.+)
    target_label: __metrics_path__
    replacement: $1
    action: replace
  - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
    separator: ;
    regex: ([^:]+)(?::\d+)?;(\d+)
    target_label: __address__
    replacement: $1:$2
    action: replace
...
```
