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

### Starting first kubernetes cluster and testing system setup

##### Pre-reqs to running Kubernetes on your machine:
1. kubectl
2. minikube
3. Virtualbox or some hypervisor - this seems to be optional in newer versions

##### After installation, try some things:
* minikube start
* kubectl get nodes
* kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
* kubectl get deployments
* kubectl expose deployment hello-minikube --type=NodePort --port=8080
* minikube service hello-minikube --url

You can then punch the url in your browser to access the service. You should see some application output (not a 404)

Clean up the system like this:
* kubectl delete services hello-minikube
* kubectl delete deployment hello-minikube

Done! You are set up with kubernetes!

#### pods
* kubernetes doesn't deploy directly to nodes, it deploys to pods.
* scaling works via adding or removing pods.
* you can start up multiple containers within one pod and network them to one another, although this is a rare use case. usually you have one container per pod.

Running a node creates a pod:
`kubectl run nginx --image=nginx`
`kubectl get pods`
`kubectl get pods -o wide`
`kubectl describe pod nginx`

#### Managing Kubernetes with YAML files

Yaml files are used for managing kubernetes files.

#### pod-definition.yml

```
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
    - name: nginx-container
      image: nginx
```
