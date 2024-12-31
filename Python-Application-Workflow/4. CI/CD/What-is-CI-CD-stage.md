## 4. CI/CD Stage

### Key Tasks:

 - Automate tests and deployments using GitHub Actions or Jenkins.
 - Set up CI/CD pipelines to:
   1) Run tests automatically.
   2) Build and push Docker images to a registry.
   3) Deploy to a staging or production environment.


### Example: GitHub Actions Workflow:

```yaml
name: CI/CD Pipeline
on:
  push:
    branches:
      - main
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v3
        with:
          python-version: 3.10
      - name: Install dependencies
        run: |
          python -m venv venv
          source venv/bin/activate
          pip install -r requirements.txt
      - name: Run tests
        run: |
          source venv/bin/activate
          pytest
      - name: Build Docker Image
        run: docker build -t flask-app .
      - name: Push to Docker Hub
        run: |
          echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
          docker push flask-app
```

## Dependencies to Learn:

 - GitHub Actions, Jenkins, or GitLab CI/CD.
 - YAML for pipeline configurations.
 - Docker Hub or private container registries.
