# Application

Based on Python and Flask, the application uses prometheus-flask-exporter to instrument the Prometheus metrics endpoint

## Deployment

Application deployment is handled using GitHub Actions,
- Build and push of application image to ECR happens on every change in app directory using [workflow](../.github/workflows/build_push.yml) 
- After pushing image, the application deployment with helm charts to EKS is triggered using [Workflow](../.github/workflows/deploy.yml)

** References** 
- https://flask.palletsprojects.com/en/1.1.x/quickstart/
- https://pypi.org/project/prometheus-flask-exporter/
