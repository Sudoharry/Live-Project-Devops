# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install system dependencies, including Graphviz
RUN apt-get update && apt-get install -y graphviz libgraphviz-dev

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Flask runs on
EXPOSE 5000

# Command to run the Flask application
CMD ["python", "app.py"]
