FROM amazonlinux
#FROM registry.access.redhat.com/ubi8/ubi

# Install some basics (groff needed to het aws help, openssl for helm)
RUN  export PS1="\w\$ "; \
     yum install -y unzip ;\
     yum install -y tar ; \ 
     yum install -y gzip ; \
     yum install -y groff ; \     
     yum install -y openssl; \
     yum install -y git;      

# Install the AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html (Try;  aws --version)

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    unzip awscliv2.zip; \
    rm awscliv2.zip; \
    ./aws/install; 

# Install AWS EKS tool (Try: eksctl version)
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp; \
    mv /tmp/eksctl /usr/local/bin; 

# Install Kubectl (Try: kubectl version --client)
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"; \
    chmod +x ./kubectl; \
    mv ./kubectl /usr/local/bin/kubectl; \
    alias k=kubectl;

# Install Helm: https://helm.sh/docs/intro/install/
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3; \
    chmod 700 get_helm.sh; \
    ./get_helm.sh

ADD Dockerfile /Dockerfile

