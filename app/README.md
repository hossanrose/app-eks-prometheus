# Application

Based on Python and Flask, the application uses prometheus-flask-exporter to instrument the Prometheus metrics endpoint

## Deployment

Application deployment is handled using GitHub Actions
- Build and Push of application image to ECR happens on every change in app directory using [Workflow](../.github/workflows/build_push.yml) 
- After Push of image the application deployment is triggered with helm using [Workflow](../.github/workflows/deploy.yml)

** References** 
- https://flask.palletsprojects.com/en/1.1.x/quickstart/
- https://pypi.org/project/prometheus-flask-exporter/
