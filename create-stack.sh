#!/usr/bin/env bash

echo "Checking if stack exists ..."

if ! aws cloudformation describe-stacks --stack-name $1 --region $2
then

  echo -e "\nStack does not exist, creating ..."
  aws cloudformation create-stack \   
    --stack-name $1 \
     --region $2 \
    --template-body file://$3

  echo "Waiting for stack to be created ..."
  aws cloudformation wait stack-create-complete \    
    --stack-name $1 \
    --region $2

  echo "Stack $1 created successfully!"

else
  echo "Stack $1 exists, skipping"
fi


