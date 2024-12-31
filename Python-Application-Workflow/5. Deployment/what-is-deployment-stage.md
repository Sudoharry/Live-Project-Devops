## 5. Deployment Stage

### Key Tasks:

 - Deploy to cloud services (e.g., AWS, Azure, or Google Cloud).
 - Use Kubernetes for orchestration in large-scale environments.

## Example: Deploy with Kubernetes:

 ```yaml

 # deployment.yaml
 apiVersion: apps/v1
 kind: Deployment
 metadata:
  name: flask-app
 spec:
  replicas: 3
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
      - name: flask-app
        image: flask-app:latest
        ports:
        - containerPort: 5000
```

### Dependencies to Learn:

 - AWS EC2, ECS, or Elastic Beanstalk for deployment.
 - Kubernetes basics (pods, services, deployments).
 - Helm for managing Kubernetes configurations.
