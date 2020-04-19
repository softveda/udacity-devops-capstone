#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
export dockerpath=softveda/simple_node_app

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker tag simple_node_app $dockerpath:latest
#docker login -u softveda --password-stdin

# Step 3:
# Push image to a docker repository
docker push $dockerpath:latest