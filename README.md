# Web app and Prometheus 

Automating the deployment of a web app and monitoring it with Prometheus. 

## Infrastruture

An EKS cluster is build using Terraform to deploy the application and monitoring solution,

![EKS Infra](https://blog.hossanrose.com/eks_infra.jpg)

### Application

Application is build using Python and Flask.
- Dockerfile for packaging the application as a container.
- Metrics of the HTTP endpoint /hello monitored.
- Metrics implementation is done using prometheus-flask-exporter plugin.

### Deployment

Application and Prometheus is deployed on to the EKS cluster in different namespaces. ALB ingress is used to configure the public endpoints.
**Endpoints:**
- http://app.hossanrose.com
- http://prometheus.hossanrose.com

#### Application

GitHub Actions is used as the continous deployment solution. Application orchestration is managed with [helm chart](helm/pyapp). 
Two workflows are used to automate the deployment,
- Build|Push is triggered on changes to app directory with [workflow](.github/workflows/build_push.yml)
- Deployment is triggered to EKS after every image push or every change to app helm chart with [workflow](.github/workflows/deploy.yml)

#### Prometheus

Prometheus is deployed using stable [helm chart](https://github.com/helm/charts/tree/master/stable/prometheus), with custom values for ALB ingress configuration.

### Prometheus Query

Query that graphs the rate of requests.
```bash
rate(flask_http_request_total[5m])
```
