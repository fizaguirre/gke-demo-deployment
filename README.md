## Kubernetes application demo deployment using GKE

Terraform configuration to deploy a web application in a GKE cluster. The deployment consists of the following components.
* Pod running DokuWiki
* Service to expose the DokuWiki pod ports
* Ingress to act as a load balancer and expose the application externally

A GKE cluster deployment can be found at https://github.com/fizaguirre/gke-base-infrastructure. This configuration provides Server SSL certificates that can be used for the application deployment.