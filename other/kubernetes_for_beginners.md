# Kubernetes for the Absolute Beginner

#### REF: https://telusagri.udemy.com/course/learn-kubernetes/learn/lecture/9703196#overview

2 Certs:
1.  Certified Kubernetes Administrator
2.  Certified Kubernetes Application Developer

Containers & Orchestration Overview:
* Kubernetes aka: K8 was built by Google.
* Highly available, load balanced, easy to scale up or down with no downtime
* Kubernetes is a container orchestration platform

Kubernetes components:
* A node is an instance of an application
* A cluster is a set of nodes
* A cluster has a "master" that is a node which manages the "worker" nodes in the cluster
* etcd: keyvalue store that tracks information across all nodes in a cluster
* scheduler: distributes work for containers across nodes
* controller: brain behind orchestration; notices and responds when nodes go down
* container runtime: underlying platform of each container (ex: docker)
* kubelet: agent running on each node in cluster, makes sure nodes are running properly

Worker Node: houses container runtime (ex: docker) which runs the app; provides status and responds to commands from kube-apiserver via kubelet
Master: houses kube-api-server which controls nodes in cluster; has etcd, controller, and scheduler as well

Kubectl: management tool for clusters (`kubectl run`, `cubectl cluster-info`, `kubectl get nodes`)

#### Pre-reqs to running Kubernetes on your machine:
1. minikube: provides all the necessary components for running a kubernetes cluster. saves you from having to install all these components listed above manually.
2. Virtualbox or some hypervisor
3. kubectl command line tool

