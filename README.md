## Kubernetes application demo deployment using GKE

Terraform configuration to deploy a web application in a GKE cluster. The deployment consists of the following components.
* Pod running DokuWiki
* Service to expose the DokuWiki pod ports
* Ingress to act as a load balancer and expose the application externally

DokuWiki is a lightweight wiki application that can be used for project documentation. It is easy to use and keeps the wiki files in text mode for easy maintainability.

To demonstrate the load balancer in action a file with the pod hostname has been added into /wiki:node path. Making multiple calls to this path should return a different hostname from time to time.


### GKE cluster 

A GKE cluster deployment can be found at https://github.com/fizaguirre/gke-base-infrastructure. This configuration provides Server SSL certificates that can be used for the application deployment.