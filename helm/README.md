# Helm charts 


## Chart for App deployment

The below command deploys the app to EKS cluster

```shell
$ kubectl create namespace pyapp
$ cd helm; helm install pyapp ./pyapp/ -n pyapp
```
Deployed Application can be accessed with [http://app.hossanrose.com](http://app.hossanrose.com)


