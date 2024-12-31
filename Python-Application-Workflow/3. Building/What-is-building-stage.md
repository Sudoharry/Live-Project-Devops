## 3. Building Stage

### Key Tasks:

 Create a Docker container for the application to ensure consistent environments across development and production.

### Example: Dockerfile:

 ```dockerfile

 FROM python:3.10-slim
 WORKDIR /app
 COPY requirements.txt .
 RUN pip install -r requirements.txt
 COPY . .
 CMD ["flask", "run", "--host=0.0.0.0"]

```

### Dependencies to Learn:

 - Docker basics.
 - Writing and optimizing Dockerfiles.
 - Containerizing Python applications.
