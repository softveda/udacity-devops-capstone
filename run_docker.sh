#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build -t simple_node_app .

# Step 2: 
# List docker images
docker image ls | grep simple_node_app

# Step 3: 
# Run the app
docker run --name simple_node_app -p 8080:80 -d simple_node_app