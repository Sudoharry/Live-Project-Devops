## Docker Lifecycle

1) Create a image continer image

``` docker build -t cloud-project . ```

2) Run the container 

``` docker run -it -dp 5000:5000 cloud-project ```

- Port is 5000 for flask based application

3) Tag the docker image

``` docker tag sha256:9aca168ec7e80c5283b678d76fa7b677a9945344723aab9c11d0353f9a389e46 harendrabarot/cloud-project:v1.0 ```

4) Push the docker images to Docker Hub registry

``` docker push harendrabarot/cloud-project:v1.0 ```

