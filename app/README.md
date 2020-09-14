# Application

Based on Python and Flask, the application uses prometheus-flask-exporter to instrument the Prometheus metrics endpoint

## Build/Push

Application is dockerised and pushed to the ECR registry using [GitHub Actions](../.github/workflows/build_push.yml). 
Build and Push happens on every commit to master branch and if the change is in app directory.

