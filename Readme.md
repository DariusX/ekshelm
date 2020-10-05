# eksclient 0.1.0: A Docker image to work with EKS

This is a Dockerfile that builds an Amazon Linux image with:
* AWS CLI
* Kubectl
* Helm
* Git

One use case is to spin up a container with this image, to perform various pipeline/depoloyment tasks


## To run
`docker run --rm -it eksclient /bin/bash` 

## Example 1: Using Helm to deploy to EKS, and hit the deployed service

`aws eks --region us-east-2 update-kubeconfig --name myCluster` \
`kubectl get svc `  to check that you have access \
`git clone https://...` \
`helm upgrade --install ... `
`sleep 10`
`kubectl port-forward svc/getting-started -n apptest 8080:8080 & `
`sleep 10`
`curl localhost:8080/ping`
