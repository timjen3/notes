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

Kubectl: management tool for clusters (`kubectl run`, `kubectl cluster-info`, `kubectl get nodes`)

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

Quick way to get the yaml file equivalent of kubectl run:
`kubectl run redis --image=redis123 --dry-run -o yaml`

Change the image used by a pod:
`kubectl set image pods/nginx nginx=redis`

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

After making a change to a yaml file you can update a running pod like this:

`kubectl apply -f redis.yaml`

### IDE

VS Code is a solid option for working with k8 yaml files. Install the kubernetes plugin for ease of use.

Add a schema.json file to help vscode know which files will be for kubernetes.

### Replication Controllers and ReplicaSets

Allows you to run multiple pods for high availability. Alternatively, you can use the replication controller to build up a new pod when a pod fails. Ultimately the controller is ensuring the configured number of pods is running at once.

Each replication controller can manage multiple pods.

Replication Controllers are being replaced by ReplicaSets. There are minor differences in how each one works, but you should stick with Replica Sets.

rc-definition.yml
```
apiVersion: v1
kind: ReplicationController
metadata:
	name: myapp-rc
	labels:
		app: myapp
		type: front-end
spec:
	template:
		<insert everything from a pod yaml except apiVersion and kind>
	replicas: 3
```

Create the pods with the replication controller:
`kubectl create -f rc-definitions.yml`

To view running pods:
`kubectl get replicationcontroller`


Here's how to do the same thing with a ReplicaSet:

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
	name: myapp-replicaset
	labels:
		app: myapp
		type: front-end
spec:
	template:
		<insert everything from a pod yaml except apiVersion and kind>
	replicas: 3
	selector:
		matchLabels:
			type: front-end
```

The "selector" section helps identify additional pods to run. It offers a number of options for selecting pods to run.

It's a bit unintuitive why the pod template has to be specified in addition to the selector. But the pod template is required.

Working with ReplicaSet:
```
kubectl create -f replicaset.yaml
kubectl get replicaset
kubectl get pods  -- you can easily tell which pods are part of a replicaset
kubectl delete replicaset myapp-replicaset
kubectl replace -f replicaset.yaml  -- update from file
```

You can also scale it with a command, but it won't update the file so you'll want to do that too.

`kubectl scale -replicas=6 -f replicaset-definition.yml`

Try this exercise to see that the deleted pod is automatically reprovisioned by the replicaset:
```
kubectl create -f replicaset.yaml
kubectl get pods  -- get the name of one of the created pods
kubectl delete pod <podname>
kubectl get pods  -- notice a new pod was already created to replace it
```

Note: if the number of pods exceeds the configured number k8 will automatically terminate the extra pod. even if you create the extra manually.

You can edit a running ReplicaSet with this command. As soon as you save it the changes will be applied to the running replicaset:

`kubectl edit replicaset myapp-replicaset`


# Deployments

K8 keeps a history of deployments and allows you to rollback to previous versions easily.

Strategy 1: RollingUpdate; default deployment strategy if nothing is specified; stands up a new deployment based on the updated definition and waits for it to be fully stood up before switching over to it, and standing down the old deployment; if the new deployment fails then traffic will be routed to the old pods indefinitely, until you fix and redeploy the change
Strategy 2: Recreate; destroys deployments and recreate them

commands:
```
kubectl create -f deployment-definition.yml
kubectl get deployments
kubectl apply -f deployment-definition.yml
kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1
kubectl rollout status deployment/myapp-deployment --record
kubectl rollout history deployment/myapp-deployment
kubectl rollout undo deployment/myapp-d
```

Updates:

Updates are done with the rollout command. K8 deploys one pod at a time and only considers the deployment successful if they are all deployed successfully.

You can use `kubectl describe deployment myapp-deployment` to get info about the deployment. If you had used `--record` with rollout/edit of the deployment this will also tell you the command used to perform the rollout.

